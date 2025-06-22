module Fluxbit
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::OutputSafetyHelper

    attr_reader :template

    delegate :render, :pluralize, to: :template

    def errors_summary(within: :container)
      return if object.blank?
      return unless object.errors.any?

      title = I18n.t(
        "polaris.form_builder.errors_summary",
        count: object.errors.count,
        model: object.class.model_name.human.downcase
      )

      render Fluxbit::BannerComponent.new(
        title: title,
        status: :critical,
        within: within,
        data: { errors_summary: true }
      ) do |banner|
        [
          render(Fluxbit::ListComponent.new) do |list|
            object.errors.full_messages.each do |error|
              list.with_item { error.html_safe }
            end
          end,
          (template.capture { yield(banner) } if block_given?)
        ].compact.join.html_safe
      end
    end

    def error_for(method)
      return if object.blank?
      return unless object.errors.key?(method)

      raw object.errors.full_messages_for(method)&.first
    end

    def fluxbit_inline_error_for(method, **options, &block)
      error_message = error_for(method)
      return unless error_message

      render(Fluxbit::InlineErrorComponent.new(**options, &block)) do
        error_message
      end
    end

    Fluxbit::Form::TextFieldComponent::TYPE_OPTIONS.each do |type|
      define_method(type.in?([ :text_area, :textarea ]) ? "fx_#{type}" : "fx_#{type}_field") do |method, **options, &block|
        options[:error] ||= error_for(method)
        options[:error] = !!options[:error] if options[:error_hidden] && options[:error]
        render Fluxbit::Form::TextFieldComponent.new(form: self, type: type, attribute: method, **options), &block
      end
    end

    Fluxbit::Form::CheckBoxComponent::TYPE_OPTIONS.each do |type|
      define_method("fx_#{type}") do |method, **options, &block|
        options[:error] ||= error_for(method)
        options[:error] = !!options[:error] if options[:error_hidden] && options[:error]
        render Fluxbit::Form::CheckBoxComponent.new(form: self, type: type, attribute: method, **options), &block
      end
    end

    [ :range, :toggle, :upload_image, :dropzone ].each do |component|
      define_method("fx_#{component}") do |method, **options, &block|
        options[:error] ||= error_for(method)
        options[:error] = !!options[:error] if options[:error_hidden] && options[:error]
        klass = "Fluxbit::Form::#{component.to_s.camelize}Component".constantize
        render klass.new(form: self, attribute: method, **options), &block
      end
    end

    # select(object, method, choices = nil, options = {}, html_options = {}, &block) public
    def fx_select(method, **options, &block)
      options[:error] ||= error_for(method)
      options[:error] = !!options[:error] if options[:error_hidden] && options[:error]
      value = object&.public_send(method)
      options[:selected] = value if value.present?

      render Fluxbit::Form::SelectComponent.new(form: self, attribute: method, **options, &block)
    end
  end
end
