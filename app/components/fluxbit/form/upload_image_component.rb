# frozen_string_literal: true

# The `Fluxbit::Form::UploadImageComponent` renders a stylized image upload field with live preview,
# drag-and-drop UI, support for both mobile and desktop layouts, labels, helper text, and integration
# with Rails form builders and Active Storage attachments. It provides custom title/subtitle, placeholder,
# and image preview, and is fully configurable via props.
#
# @example Basic usage
#   = render Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, label: "Profile photo")
#
# @see docs/03_Forms/UploadImage.md For detailed documentation and examples.
class Fluxbit::Form::UploadImageComponent < Fluxbit::Form::FieldComponent
  # Initializes the upload image component with the given properties.
  #
  # @param form [ActionView::Helpers::FormBuilder] The form builder (optional, for Rails forms)
  # @param attribute [Symbol] The model attribute to be used in the form (required if using form builder)
  # @param id [String] The id of the input element (optional)
  # @param label [String] The label for the input field (optional)
  # @param help_text [String] Additional help text for the input field (optional)
  # @param helper_popover [String] Content for a popover helper (optional)
  # @param helper_popover_placement [String] Placement of the popover (default: "right")
  # @param image_path [String] Path to the image to be displayed (optional)
  # @param image_placeholder [String] Placeholder image path if no image is attached (optional)
  # @param title [Boolean, String] Whether to show a title (true for default, false to hide, or custom string)
  # @param class [String] Additional CSS classes for the input element
  # @param ... any other HTML attribute supported by file_field_tag
  def initialize(**props)
    super(**props)
    @title = @props.delete(:title) || "Change"
    @image_path = @props.delete(:image_path) ||
      (if @object&.send(@attribute).respond_to?(:attached?) && @object&.send(@attribute)&.send("attached?")
        @object&.send(@attribute)&.variant(resize_to_fit: [ 160, 160 ])
       end) || @props.delete(:image_placeholder) || ""

    @props["class"] = "absolute inset-0 h-full w-full cursor-pointer rounded-md border-gray-300 opacity-0"
  end

  def input_element(input_id: nil)
    @props["onchange"] = "loadFile(event, '#{id}')"
    return file_field_tag @name, @props.merge(id: input_id || id) if @form.nil?

    @form.file_field(@attribute, **@props, id: input_id || id)
  end

  def image_element
    image_tag @image_path,
              class: "img_photo_#{id} img_photo absolute inset-0 w-full h-full object-cover rounded-full",
              alt: @attribute&.to_s&.humanize
  end
end
