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
  # @param initials [String] Initials to display as placeholder (e.g., "JD" for John Doe) - overrides image_placeholder
  # @param title [Boolean, String] Whether to show a title (true for default, false to hide, or custom string)
  # @param rounded [Boolean] Whether to show image as circle (true, default) or square with rounded edges (false)
  # @param class [String] Additional CSS classes for the input element
  # @param ... any other HTML attribute supported by file_field_tag
  def initialize(**props)
    super(**props)
    @title = @props.delete(:title) || "Change"
    @rounded = @props.delete(:rounded)
    @rounded = true if @rounded.nil?
    @initials = @props.delete(:initials)
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
              class: "img_photo_#{id} img_photo absolute inset-0 w-full h-full object-cover #{image_rounded_class}",
              alt: @attribute&.to_s&.humanize
  end

  def container_rounded_class
    @rounded ? "rounded-full" : "rounded-lg"
  end

  def image_rounded_class
    @rounded ? "rounded-full" : "rounded-lg"
  end

  def has_initials?
    @initials.present?
  end

  def initials_element
    return unless has_initials?

    content_tag :div,
                class: "img_photo_#{id} img_photo absolute inset-0 w-full h-full flex items-center justify-center #{image_rounded_class} #{initials_gradient_class}",
                data: { initials_placeholder: true } do
      content_tag :span, @initials.upcase, class: "text-white font-bold #{initials_text_size_class}"
    end
  end

  def initials_gradient_class
    # Generate a consistent gradient based on the initials hash
    gradient_index = @initials.sum { |c| c.ord } % gradient_options.length
    gradient_options[gradient_index]
  end

  def initials_text_size_class
    # Smaller initials (1-2 chars) get larger text, longer ones get smaller text
    case @initials.length
    when 1..2
      "text-4xl"
    when 3
      "text-3xl"
    else
      "text-2xl"
    end
  end

  def gradient_options
    [
      "bg-gradient-to-br from-blue-500 to-purple-600",
      "bg-gradient-to-br from-green-500 to-teal-600",
      "bg-gradient-to-br from-pink-500 to-rose-600",
      "bg-gradient-to-br from-orange-500 to-red-600",
      "bg-gradient-to-br from-indigo-500 to-blue-600",
      "bg-gradient-to-br from-purple-500 to-pink-600",
      "bg-gradient-to-br from-cyan-500 to-blue-600",
      "bg-gradient-to-br from-emerald-500 to-green-600",
      "bg-gradient-to-br from-amber-500 to-orange-600",
      "bg-gradient-to-br from-violet-500 to-purple-600"
    ]
  end
end
