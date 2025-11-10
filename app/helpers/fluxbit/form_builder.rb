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
        parts = []

        parts << render(Fluxbit::ListComponent.new) do |list|
          object.errors.full_messages.each do |error|
            list.with_item { template.sanitize(error.to_s, tags: [], attributes: []) }
          end
        end

        parts << template.capture { yield(banner) } if block_given?

        template.safe_join(parts)
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

    [ :range, :toggle, :upload_image, :dropzone, :password, :telephone ].each do |component|
      define_method("fx_#{component}") do |method, **options, &block|
        options[:error] ||= error_for(method)
        options[:error] = !!options[:error] if options[:error_hidden] && options[:error]
        klass = "Fluxbit::Form::#{component.to_s.camelize}Component".constantize
        render klass.new(form: self, attribute: method, **options), &block
      end
    end

    def fx_radio_group_button(method, **options, &block)
      options[:name] ||= "#{@object_name}[#{method}]"
      render Fluxbit::Form::RadioGroupButtonComponent.new(**options), &block
    end

    # Mimics Rails' form.select signature:
    # select(method, choices = nil, options = {}, html_options = {}, &block)
    #
    # @param method [Symbol] The attribute name
    # @param choices [Array, Hash, String, nil] Options for the select (raw data or pre-formatted HTML)
    # @param options [Hash] Options like prompt, include_blank, selected, disabled
    # @param html_options [Hash] HTML attributes for the select tag
    # @param block [Proc] Optional block for custom options
    #
    # @example Basic usage
    #   form.fx_select :role, ["Admin", "User", "Guest"]
    #
    # @example With options
    #   form.fx_select :country, countries, { prompt: "Select a country" }, { class: "custom-class" }
    #
    # @example With pre-formatted options
    #   form.fx_select :status, options_for_select(statuses, selected: "active")
    def fx_select(method, choices = nil, options = {}, html_options = {}, &block)
      # Handle Rails-style signature
      all_options = html_options.merge(options)

      # Set the choices/options
      all_options[:options] = choices if choices.present?

      # Add error handling
      all_options[:error] ||= error_for(method)
      all_options[:error] = !!all_options[:error] if all_options[:error_hidden] && all_options[:error]

      # Set selected value from object if not explicitly provided
      value = object&.public_send(method)
      all_options[:selected] ||= value if value.present?

      render Fluxbit::Form::SelectComponent.new(form: self, attribute: method, **all_options, &block)
    end

    def fx_submit(content = nil, **options, &block)
      options[:form] = self
      options[:content] = content if content.present?
      options[:color] ||= :primary
      options[:size] ||= 2
      options[:disabled] = true if object&.persisted? && !object.valid?

      if block_given?
        render Fluxbit::ButtonComponent.new(**options) do |*args|
          yield(*args)
        end
      else
        render Fluxbit::ButtonComponent.new(**options)
      end
    end
  end
end
