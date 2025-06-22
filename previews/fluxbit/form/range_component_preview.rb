# frozen_string_literal: true

class Fluxbit::Form::RangeComponentPreview < ViewComponent::Preview
  # Fluxbit::RangeComponent
  # ------------------------
  #
  # @param id [String] "The id of the input element (optional)"
  # @param label [String] "The label for the input field (optional)"
  # @param help_text [String] "Additional help text for the input field (optional)"
  # @param helper_popover [String] "Content for a popover helper (optional)"
  # @param helper_popover_placement select "Placement of the popover (default: right)" :helper_popover_placement_options
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param value [String] "Value for the field (optional)"
  # @param min [Integer] "Minimum value for the range"
  # @param max [Integer] "Maximum value for the range"
  # @param step [Integer] "Step value for the range"
  # @param vertical [Boolean] toggle "Renders the slider vertically if true"
  # @param sizing [Integer] "Input size"
  def playground(
    id: 'range_playground', label: "Full Name",
    help_text: "Help text", helper_popover: "Helper popover", helper_popover_placement: "right",
    name: "full_name", value: nil, min: 0, max: 100, step: 1, vertical: false,
    sizing: 0)
    render Fluxbit::Form::RangeComponent.new(
      id: id,
      label: label,
      help_text: help_text,
      helper_popover: helper_popover,
      helper_popover_placement: helper_popover_placement,
      name: name,
      value: value,
      min: min,
      max: max,
      step: step,
      vertical: vertical,
      sizing: sizing
    )
  end

  private

  def helper_popover_placement_options
    %w[top right bottom left]
  end
end
