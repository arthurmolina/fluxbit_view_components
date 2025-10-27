# frozen_string_literal: true

class Fluxbit::Form::FieldComponent < Fluxbit::Form::Component
  def initialize(**props)
    super
    @props = props
    @form = @props.delete(:form)
    @attribute = @props.delete(:attribute)
    @name = @props.delete(:name) || (@attribute if @form.present?)
    @value = @props.delete(:value)
    @id = @props.delete(:id)
    @required = @props.delete(:required)

    @object = @form&.object
    @help_text = define_help_text(props.delete(:help_text), @object, @attribute)
    @helper_popover = define_helper_popover(props.delete(:helper_popover), @object, @attribute)
    @helper_popover_placement = props.delete(:helper_popover_placement) || "right"
    @label = label_value(props.delete(:label), @object, @attribute, @id)
    @wrapper_html = props.delete(:wrapper_html) || {}
    @wrapper_html = { class: @wrapper_html } if @wrapper_html.is_a?(String)
    define_wrapper_options
  end

  def define_wrapper_options
    add(to: @wrapper_html, class: "required") if @required.present?
    add(to: @wrapper_html, class: @name.to_s) if @name.present?
  end
end
