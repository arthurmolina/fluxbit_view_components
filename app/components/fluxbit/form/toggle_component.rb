# frozen_string_literal: true


# The `Fluxbit::Form::ToggleComponent` renders a styled switch/toggle (on/off) input.
# It supports custom label placement, color and sizing options, helper text, and is fully compatible
# with Rails form builders. Additional options allow you to invert label order, customize colors
# for checked/unchecked/button states, and provide an extra label via a slot.
#
# @example Basic usage
#   = render Fluxbit::Form::ToggleComponent.new(name: :enabled, label: "Enabled?")
#
# @see docs/03_Forms/Toggle.md For detailed documentation and examples.
class Fluxbit::Form::ToggleComponent < Fluxbit::Form::FieldComponent
  include Fluxbit::Config::Form::ToggleComponent

  renders_one :other_label, "Fluxbit::Form::LabelComponent"

  # Initializes the toggle component with the given properties.
  #
  # @param form [ActionView::Helpers::FormBuilder] The form builder (optional, for Rails forms)
  # @param attribute [Symbol] The model attribute to be used in the form (required if using form builder)
  # @param id [String] The id of the input element (optional)
  # @param label [String] The label for the input field (optional)
  # @param help_text [String] Additional help text for the input field (optional)
  # @param helper_popover [String] Content for a popover helper (optional)
  # @param helper_popover_placement [String] Placement of the popover (default: "right")
  # @param name [String] Name of the field (required unless using form builder)
  # @param other_label [String] Additional label, rendered via slot (optional)
  # @param sizing [Integer] Size index for the toggle (default: config)
  # @param color [Symbol] Checked toggle color (:default, :success, :danger, :info, :warning, etc)
  # @param unchecked_color [Symbol] Unchecked toggle color (see config)
  # @param button_color [Symbol] Color for the toggle button
  # @param invert_label [Boolean] If true, inverts label/toggle order (default: config)
  # @param disabled [Boolean] Disables the toggle if true
  # @param class [String] Additional CSS classes for the input element
  # @param ... any other HTML attribute supported by <input type="checkbox">
  def initialize(**props)
    super(**props)

    @other_label = props.delete(:other_label)
    @sizing = @props.delete(:sizing) || @@sizing
    @sizing = (styles[:toggle][:sizes].count - 1) if @sizing > (styles[:toggle][:sizes].count - 1)
    @color = valid_color(@props.delete(:color))
    @unchecked_color = options(
      @props.delete(:unchecked_color),
      collection: styles[:toggle][:unchecked].keys,
      default: @@unchecked_color
    )
    @button_color = options(@props.delete(:button_color), collection: styles[:toggle][:button].keys, default: @@button_color)
    @invert_label = options(@props.delete(:invert_label), collection: [ true, false ], default: @@invert_label)

    add to: @props, first_element: true, class: styles[:input]
  end

  def valid_color(color)
    return color if styles[:toggle][:checked].key?(color)
    return :danger if errors.present?

    @@color
  end

  def label_class
    styles[:label]
  end

  def input_class
    styles[:input]
  end

  def toggle_class
    [
      (@invert_label || @other_label || other_label?) ? styles[:toggle][:invert_label] : nil,
      styles[:toggle][:base],
      styles[:toggle][:unchecked][@unchecked_color],
      styles[:toggle][:checked][@color],
      styles[:toggle][:button][@button_color],
      styles[:toggle][:sizes][@sizing],
      styles[:toggle][:active][(@props[:disabled] ? :off : :on)]
    ].compact.join(" ")
  end
end
