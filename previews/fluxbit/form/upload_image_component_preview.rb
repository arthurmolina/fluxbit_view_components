# frozen_string_literal: true

class Fluxbit::Form::UploadImageComponentPreview < ViewComponent::Preview
  # Fluxbit::UploadImageComponent
  # -----------------------------
  #
  # @param id [String] "The id of the input element (optional)"
  # @param label [String] "The label for the input field (optional)"
  # @param help_text [String] "Additional help text for the input field (optional)"
  # @param helper_popover [String] "Content for a popover helper (optional)"
  # @param helper_popover_placement select "Placement of the popover (default: right)" :helper_popover_placement_options
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param title [String] "Whether to show a title (true for default, false to hide, or custom string)"
  def playground(
    id: 'text_field_playground', label: "Image Upload",
    help_text: "Help text", helper_popover: "Helper popover", helper_popover_placement: "right",
    name: "image_upload", title: "Upload Image")
    render Fluxbit::Form::UploadImageComponent.new(
      id: id,
      label: label,
      help_text: help_text,
      helper_popover: helper_popover,
      helper_popover_placement: helper_popover_placement,
      name: name,
      title: title.presence
    )
  end

  private

  def helper_popover_placement_options
    %w[top right bottom left]
  end
end
