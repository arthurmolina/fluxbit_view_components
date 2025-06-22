# frozen_string_literal: true

class Fluxbit::Form::DropzoneComponentPreview < ViewComponent::Preview
  # Fluxbit::DropzoneComponent
  # ------------------------
  #
  # @param id [String] "The id of the input element (optional)"
  # @param label [String] "The label for the input field (optional)"
  # @param help_text [String] "Additional help text for the input field (optional)"
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param title [String] "Title text above the dropzone (true for default, false to hide, or custom string)"
  # @param subtitle [String] "Subtitle text above the dropzone (true for default, false to hide, or custom string)"
  # @param height [Integer] "Height of the dropzone"
  # @param icon select "Icon to display in the dropzone" :icon_options
  def playground(
    id: 'dropzone_playground', label: "Full Name",
    help_text: "Help text",
    name: "dropzone", title: "Upload Files", subtitle: "Drag and drop files here or click to select",
    height: 0, icon: 'heroicons_solid:upload')
    render Fluxbit::Form::DropzoneComponent.new(
      id: id,
      label: label,
      help_text: help_text,
      name: name,
      title: title.presence,
      subtitle: subtitle.presence,
      height: height,
      icon: icon.presence
    )
  end

  private

  def icon_options
    [ nil ] + %w[heroicons_solid:upload heroicons_solid:eye heroicons_solid:user heroicons_solid:check heroicons_solid:pencil heroicons_solid:x-mark]
  end
end
