# frozen_string_literal: true

class Fluxbit::Form::ToggleComponentPreview < ViewComponent::Preview
  # Fluxbit::ToggleComponent
  # ------------------------
  #
  # @param id [String] "The id of the input element (optional)"
  # @param label [String] "The label for the input field (optional)"
  # @param other_label [String] "The label on the other side (optional)"
  # @param help_text [String] "Additional help text for the input field (optional)"
  # @param helper_popover [String] "Content for a popover helper (optional)"
  # @param helper_popover_placement select "Placement of the popover (default: right)" :helper_popover_placement_options
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param value [String] "Value for the field (optional)"
  # @param color select "Checked Color" :color_options
  # @param unchecked_color select "Unchecked Color" :unchecked_color_options
  # @param button_color select "Button Color" :button_color_options
  # @param sizing [Integer] "Input size"
  # @param invert_label [Boolean] toggle "If true, inverts label/toggle order"
  # @param disabled [Boolean] toggle "Disables the input if true"
  def playground(
    id: 'text_field_playground', label: "Full Name", other_label: "Other side",
    help_text: "Help text", helper_popover: "Helper popover", helper_popover_placement: "right",
    name: "full_name", value: nil, color: :default, unchecked_color: :default, button_color: :default,
    sizing: 0, invert_label: false, disabled: false)
    render Fluxbit::Form::ToggleComponent.new(
      id: id,
      label: label,
      other_label: other_label.presence,
      help_text: help_text,
      helper_popover: helper_popover,
      helper_popover_placement: helper_popover_placement,
      name: name,
      value: value,
      color: color,
      unchecked_color: unchecked_color,
      button_color: button_color,
      sizing: sizing,
      invert_label: invert_label,
      disabled: disabled,
    )
  end

  private

  def color_options
    Fluxbit::Config::Form::ToggleComponent.styles[:toggle][:checked].keys
  end

  def unchecked_color_options
    Fluxbit::Config::Form::ToggleComponent.styles[:toggle][:unchecked].keys
  end

  def button_color_options
    Fluxbit::Config::Form::ToggleComponent.styles[:toggle][:button].keys
  end

  def helper_popover_placement_options
    %w[top right bottom left]
  end
end
