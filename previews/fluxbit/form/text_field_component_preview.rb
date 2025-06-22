# frozen_string_literal: true

class Fluxbit::Form::TextFieldComponentPreview < ViewComponent::Preview
  # Fluxbit::TextFieldComponent
  # ------------------------
  #
  # @param id [String] "The id of the input element (optional)"
  # @param label [String] "The label for the input field (optional)"
  # @param help_text [String] "Additional help text for the input field (optional)"
  # @param helper_popover [String] "Content for a popover helper (optional)"
  # @param helper_popover_placement select "Placement of the popover (default: right)" :helper_popover_placement_options
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param value [String] "Value for the field (optional)"
  # @param type select "Type" :type_options
  # @param icon select "Left Icon (optional)" :icon_options
  # @param right_icon select "Right Icon (optional)" :icon_options
  # @param addon select "Addon Icon (optional)" :icon_options
  # @param color select "Color" :color_options
  # @param sizing [Integer] "Input size"
  # @param shadow [Boolean] toggle "Adds drop shadow if true"
  # @param placeholder [String] "Placeholder text for the input (optional)"
  # @param disabled [Boolean] toggle "Disables the input if true"
  # @param readonly [Boolean] toggle "Makes the input readonly if true"
  def playground(
    id: 'text_field_playground', label: "Full Name",
    help_text: "Help text", helper_popover: "Helper popover", helper_popover_placement: "right",
    name: "full_name", value: nil, type: :text, icon: 'heroicons_solid:eye', right_icon: 'heroicons_solid:user',
    addon: nil, color: :default, sizing: 0, shadow: false, placeholder: "Enter your full name",
    disabled: false, readonly: false)
    render Fluxbit::Form::TextFieldComponent.new(
      id: id,
      label: label,
      help_text: help_text,
      helper_popover: helper_popover,
      helper_popover_placement: helper_popover_placement,
      name: name,
      value: value,
      type: type,
      icon: icon,
      right_icon: right_icon,
      addon: addon,
      color: color,
      sizing: sizing,
      shadow: shadow,
      placeholder: placeholder,
      disabled: disabled,
      readonly: readonly,
    )
  end

  # Renders a basic text input.
  def default; end

  private

  def color_options
    Fluxbit::Config::Form::TextFieldComponent.styles[:text].keys
  end

  def type_options
    Fluxbit::Form::TextFieldComponent::TYPE_OPTIONS
  end

  def icon_options
    [ nil ] + %w[heroicons_solid:eye heroicons_solid:user heroicons_solid:check heroicons_solid:pencil heroicons_solid:x-mark]
  end

  def helper_popover_placement_options
    %w[top right bottom left]
  end
end
