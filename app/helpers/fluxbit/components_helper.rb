# frozen_string_literal: true

module Fluxbit
  module ComponentsHelper
    # Components
    def fx_avatar(...) = fluxbit_method("Avatar", ...)
    def fx_avatar_group(...) = fluxbit_method("AvatarGroup", ...)
    def fx_gravatar(...) = fluxbit_method("Gravatar", ...)
    def fx_alert(...) = fluxbit_method("Alert", ...)
    def fx_button(...) = fluxbit_method("Button", ...)
    def fx_button_group(...) = fluxbit_method("ButtonGroup", ...)
    def fx_badge(...) = fluxbit_method("Badge", ...)
    def fx_card(...) = fluxbit_method("Card", ...)
    def fx_modal(...) = fluxbit_method("Modal", ...)
    def fx_popover(...) = fluxbit_method("Popover", ...)
    def fx_tooltip(...) = fluxbit_method("Tooltip", ...)
    def fx_flex(...) = fluxbit_method("Flex", ...)
    def fx_tab(...) = fluxbit_method("Tab", ...)

    # Forms
    def fx_helper_text(...) = fluxbit_method("Form::HelperText", ...)
    def fx_checkbox_input(...) = fluxbit_method("Form::CheckboxInput", ...)
    def fx_form_builder(...) = fluxbit_method("Form::FormBuilder", ...)
    def fx_label(...) = fluxbit_method("Form::Label", ...)
    def fx_range_input(...) = fluxbit_method("Form::RangeInput", ...)
    def fx_select_input(...) = fluxbit_method("Form::SelectInput", ...)
    def fx_select_free_input(...) = fluxbit_method("Form::SelectFreeInput", ...)
    def fx_text_input(...) = fluxbit_method("Form::TextInput", ...)
    def fx_textarea_input(...) = fluxbit_method("Form::TextareaInput", ...)
    def fx_toggle_input(...) = fluxbit_method("Form::ToggleInput", ...)
    def form_builder(...) = fluxbit_method("Form::FormBuilder", ...)

    # Typography
    def fx_heading(...) = fluxbit_method("Heading", ...)
    def fx_txt(...) = fluxbit_method("Text", ...)

    def fluxbit_method(method_name, *args, **kwargs, &c)
      component_klass = "Fluxbit::#{method_name}Component".constantize
      if kwargs[:with_content]
        content = kwargs.delete(:with_content)
        render(component_klass.new(*args, **kwargs).with_content(content), &c)
      else
        render(component_klass.new(*args, **kwargs), &c)
      end
    end

    # # Succint method for render component
    # # from: https://dev.to/abeidahmed/advanced-viewcomponent-patterns-in-rails-2b4m
    # #
    # # Instead of using 'render XComponent'
    # # One can use 'render_component "X", **@options'
    # def render_component(component_path, collection: nil, with_content: nil, **options, &block)
    #   component_klass = "#{component_path.classify}Component".constantize

    #   return render component_klass.new(**options).with_content(with_content) if with_content

    #   if collection
    #     render component_klass.with_collection(collection, **options), &block
    #   else
    #     render component_klass.new(**options), &block
    #   end
    # end

    # def method_missing(name, *args, &block)
    #   if name == :alert
    #     render component_klass.new(**options), &block
    #     # do something if the method name is "custom_helper_method"
    #     #content_tag(:div, *args, &block)
    #   else
    #     # call the original method_missing method if the method name is not recognized
    #     super
    #   end
    # end
  end
end
