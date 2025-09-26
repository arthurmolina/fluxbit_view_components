# frozen_string_literal: true

require_relative "shared/base_product_model"

class Fluxbit::Form::DropzoneComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::DropzoneComponent
  # --------------------------------
  # You can use this component to create drag-and-drop file upload areas with various customization options
  #
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param label [String] "The label for the input field (optional)"
  # @param title [String] "Title text inside dropzone (true for default, false to hide, or custom string)"
  # @param subtitle [String] "Subtitle text below title (true for default, false to hide, or custom string)"
  # @param icon select "Icon to display in the dropzone" :icon_options
  # @param height select "Height preset" :height_options
  # @param help_text [String] "Additional help text for the input field (optional)"
  # @param multiple [Boolean] toggle "Allow multiple file selection"
  # @param accept [String] "Comma-separated list of accepted file types (optional)"
  # @param disabled [Boolean] toggle "Disables the input if true"
  def playground(
    name: "file_upload",
    label: "",
    title: "Upload Files",
    subtitle: "Drag and drop files here or click to select",
    icon: "heroicons_solid:cloud_arrow_up",
    height: 0,
    help_text: "",
    multiple: false,
    accept: "",
    disabled: false)
    render Fluxbit::Form::DropzoneComponent.new(
      name: name,
      label: label == "" ? nil : label,
      title: title.presence,
      subtitle: subtitle.presence,
      icon: icon.presence,
      height: height,
      help_text: help_text == "" ? nil : help_text,
      multiple: multiple,
      accept: accept == "" ? nil : accept,
      disabled: disabled
    )
  end

  def basic_dropzone; end
  def different_heights; end
  def custom_title_subtitle; end
  def different_icons; end
  def multiple_files; end
  def file_restrictions; end
  def with_helper_text; end
  def disabled_dropzone; end
  def custom_content; end
  def with_form_builder
    @product ||= ::BaseProductModel.new(
      name: "Sample Product"
    )

    # Ensure the product is valid and ready for form display
    @product.valid? if @product
    @product
  end

  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def icon_options
    %w[
      heroicons_solid:cloud_arrow_up
      heroicons_solid:photo
      heroicons_solid:document_plus
      heroicons_solid:archive_box
      heroicons_solid:folder_open
      heroicons_solid:paper_clip
    ]
  end

  def height_options
    {
      "Auto (default)" => 0,
      "Small (h-32)" => 1,
      "Medium (h-64)" => 2,
      "Large (h-96)" => 3
    }
  end
end
