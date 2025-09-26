# frozen_string_literal: true

require_relative "shared/base_product_model"

class Fluxbit::Form::UploadImageComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::UploadImageComponent
  # --------------------------------
  # You can use this component to create image upload fields with live preview and responsive design
  #
  # @param name [String] "Field name"
  # @param label [String] "Label text"
  # @param title [String] "Upload button text"
  # @param image_path [String] "Current image URL"
  # @param image_placeholder [String] "Placeholder image URL"
  # @param help_text [String] "Help text below field"
  # @param helper_popover [String] "Helper popover content"
  # @param helper_popover_placement select "Popover placement" :placement_options
  # @param accept [String] "Accepted file types"
  # @param multiple [Boolean] "Allow multiple files"
  # @param disabled [Boolean] "Disabled state"
  def playground(
    name: "avatar",
    label: "Profile Photo",
    title: "Change Photo",
    image_path: "",
    image_placeholder: "https://via.placeholder.com/160x160?text=Upload",
    help_text: "Upload a profile photo. Recommended size: 160x160 pixels.",
    helper_popover: "Choose a clear, professional photo that represents you well. The image will be cropped to a circle.",
    helper_popover_placement: "right",
    accept: "image/*",
    multiple: false,
    disabled: false)
    render Fluxbit::Form::UploadImageComponent.new(
      name: name,
      label: label.present? ? label : nil,
      title: title.present? ? title : nil,
      image_path: image_path.present? ? image_path : nil,
      image_placeholder: image_placeholder.present? ? image_placeholder : nil,
      help_text: help_text.present? ? help_text : nil,
      helper_popover: helper_popover.present? ? helper_popover : nil,
      helper_popover_placement: helper_popover_placement,
      accept: accept.present? ? accept : nil,
      multiple: multiple,
      disabled: disabled
    )
  end

  def default; end
  def basic_upload; end
  def custom_title; end
  def with_existing_image; end
  def with_placeholder; end
  def with_help; end
  def file_restrictions; end
  def multiple_files; end
  def with_form_builder
    @product ||= ::BaseProductModel.new(
      name: "Sample Product",
      avatar: "https://via.placeholder.com/160x160?text=Avatar",
      main_image: "",
      thumbnail: "https://via.placeholder.com/100x100?text=Thumb",
      banner: "",
      logo: "https://via.placeholder.com/200x80?text=Logo"
    )

    # Ensure the product is valid and ready for form display
    @product.valid? if @product
    @product
  end
  def profile_examples; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def placement_options
    %w[top right bottom left]
  end
end
