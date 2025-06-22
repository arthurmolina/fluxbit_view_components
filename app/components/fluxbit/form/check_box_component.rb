# frozen_string_literal: true

# The `Fluxbit::Form::CheckBoxComponent` is a form input component for check boxes and radio buttons.
# It extends `Fluxbit::Form::FieldComponent` and provides a styled checkbox/radio with label, helper text,
# and support for different visual states and groupings. It automatically adds the correct styles for both
# checkbox and radio types and works with or without Rails form builders.
#
# @example Basic usage
#   = render Fluxbit::Form::CheckBoxComponent.new(name: :accept_terms, label: "Accept the terms")
#
# @see docs/03_Forms/CheckBox.md For detailed documentation and examples.
class Fluxbit::Form::CheckBoxComponent < Fluxbit::Form::FieldComponent
  include Fluxbit::Config::Form::CheckBoxComponent
  TYPE_DEFAULT = :check_box
  TYPE_OPTIONS = %i[check_box checkbox radio_button].freeze

  # Initializes the check box component with the given properties.
  #
  # @param name [String] Name of the field (required unless using form builder)
  # @param label [String] Label text next to the input (optional)
  # @param value [String] Value for the field (optional)
  # @param type [String, Symbol] Input type (`"check_box"`, `"checkbox"`, `"radio_button"`)
  # @param help_text [String] Helper or error text below the field
  # @param disabled [Boolean] Disables the input if true
  # @param checked [Boolean] Marks the input as checked if true
  # @param class [String] Additional CSS classes for the input element
  # @param ... any other HTML attribute supported by check_box_tag/radio_button_tag
  def initialize(**props)
    super(**props)
    @type = options(@props.delete(:type), collection: TYPE_OPTIONS, default: TYPE_DEFAULT)
    add(class: styles[:checkbox], to: @props, first_element: true) if @props[:type] == "checkbox"
    add(class: styles[:base], to: @props, first_element: true)
  end

  def input
    if @form.present? && @attribute.present?
      @form.public_send(@type, @attribute, @props)
    else
      public_send("#{@type}_tag", @name, @value, @props)
    end
  end

  def call
    if @help_text
      content_tag :div, { class: "flex" } do
        concat content_tag(:div, input, { class: styles[:input_div] })
        concat content_tag(:div, safe_join([ label, help_text ]), { class: styles[:helper_div] })
      end
    else
      content_tag :div, { class: styles[:no_helper_div] } do
        concat input
        concat label
      end
    end
  end
end
