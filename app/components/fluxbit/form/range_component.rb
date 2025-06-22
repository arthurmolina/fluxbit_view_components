# frozen_string_literal: true

# The `Fluxbit::Form::RangeComponent` renders a styled range slider for selecting numeric values within a range.
# It supports vertical and horizontal orientation, sizing options, helper text, labels, and full compatibility with Rails form builders.
# Custom classes and HTML attributes can be passed for further styling and control.
#
# @example Basic usage
#   = render Fluxbit::Form::RangeComponent.new(name: :volume, label: "Volume")
#
# @see docs/03_Forms/Range.md For detailed documentation and examples.
class Fluxbit::Form::RangeComponent < Fluxbit::Form::FieldComponent
  include Fluxbit::Config::Form::RangeComponent

  # Initializes the range component with the given properties.
  #
  # @param name [String] Name of the field (required unless using form builder)
  # @param label [String] Label for the input (optional)
  # @param value [Numeric] Value for the range input (optional)
  # @param min [Numeric] Minimum value for the range slider (optional)
  # @param max [Numeric] Maximum value for the range slider (optional)
  # @param step [Numeric] Step value for the slider (optional)
  # @param vertical [Boolean] Renders the slider vertically if true (default: false)
  # @param sizing [Integer] Size index for slider height/thickness (default: config default)
  # @param help_text [String] Helper or error text below the field
  # @param class [String] Additional CSS classes for the input element
  # @param ... any other HTML attribute supported by the <input type="range"> tag
  def initialize(**props)
    super(**props)
    @vertical = options(@props.delete(:vertical), collection: [ true, false ], default: @@vertical)
    @sizing = @props[:sizing].to_i || @@sizing
    @sizing = (styles[:sizes].count - 1) if @sizing > (styles[:sizes].count - 1)
    @props[:type] = "range"
    @props[:style] = @props[:style] || "" + ";transform: rotate(270deg);" if @vertical

    add(class: styles[:sizes][@sizing], to: @props, first_element: true)
    add(class: styles[:base], to: @props, first_element: true)
  end

  def range
    if @form.nil?
      text_field_tag @name, @value, @props
    else
      @form.text_field(@attribute, **@props)
    end
  end

  def call
    content_tag :div, **@wrapper_html do
      safe_join [ label, range, help_text ]
    end
  end
end
