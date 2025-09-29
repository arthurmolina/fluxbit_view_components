# frozen_string_literal: true

module Fluxbit
  module ComponentsHelper
    # Components
    [ :accordion, :avatar, :avatar_group, :banner, :breadcrumb, :gravatar, :alert, :button, :button_group, :link,
      :badge, :drawer, :dropdown, :card, :modal, :pagination, :popover, :tooltip, :flex, :tab, :table, :skeleton, :stepper, :speed_dial, :timeline, :spinner_percent, :progress ].each do |component|
      define_method("fx_#{component}") do |*args, **kwargs, &block|
        fluxbit_method(component.to_s.camelize, *args, **kwargs, &block)
      end
    end

    # Forms
    [ :help_text, :form_builder, :label, :range,
      :select, :toggle, :upload_image, :dropzone ].each do |component|
      define_method("fx_#{component}") do |*args, **kwargs, &block|
        fluxbit_method("Form::#{component.to_s.camelize}", *args, **kwargs, &block)
      end
    end
    def form_builder(...) = fluxbit_method("Form::FormBuilder", ...)

    Fluxbit::Form::TextFieldComponent::TYPE_OPTIONS.each do |type|
      define_method(type.in?([ :text_area, :textarea ]) ? "fx_#{type}" : "fx_#{type}_field") do |*args, **kwargs, &block|
        fluxbit_method("Form::TextField", *args, type: type, **kwargs, &block)
      end
    end

    Fluxbit::Form::CheckBoxComponent::TYPE_OPTIONS.each do |type|
      define_method("fx_#{type}") do |*args, **kwargs, &block|
        fluxbit_method("Form::CheckBox", *args, type: type, **kwargs, &block)
      end
    end

    # Typography
    def fx_heading(...) = fluxbit_method("Heading", ...)
    def fx_txt(...) = fluxbit_method("Text", ...)


    def fx_link_to_old(body, url, **kwargs, &block)
      kwargs[:body] = body if body.is_a?(String)
      kwargs[:url] = url if url.is_a?(String)
      kwargs[:with_content] = block if block_given?
      Fluxbit::TextComponent.new(body, url, **kwargs).render(&block)
    end

    def fx_link_to(body = nil, url = nil, **kwargs, &block)
      kwargs[:as] = :a
      if block_given? && body.is_a?(String) && (url.is_a?(String) || url.is_a?(Symbol))
        # Handle case: fx_link_to("Link text", "/path") { ... }
        kwargs[:href] = url
        fluxbit_method("Link", as: :a, content: body, **kwargs, &block)
      elsif block_given? && body.is_a?(String) && url.nil?
        # Handle case: fx_link_to("/path") { ... content ... }
        kwargs[:href] = body # first arg is URL
        fluxbit_method("Link", as: :a, **kwargs, &block)
      elsif !block_given? && body.is_a?(String) && (url.is_a?(String) || url.is_a?(Symbol))
        # Handle case: fx_link_to("Link text", "/path", class: "...")
        component_klass = "Fluxbit::LinkComponent".constantize
        kwargs[:href] = url
        render(component_klass.new(**kwargs).with_content(body))
      else
        # Handle other cases or provide feedback
        raise ArgumentError, "Invalid arguments for fx_link_to"
      end
    end


    def fluxbit_method(method_name, *args, **kwargs, &c)
      component_klass = "Fluxbit::#{method_name}Component".constantize
      if kwargs[:with_content]
        content = kwargs.delete(:with_content)
        render(component_klass.new(*args, **kwargs).with_content(content), &c)
      else
        render(component_klass.new(*args, **kwargs), &c)
      end
    end
  end
end
