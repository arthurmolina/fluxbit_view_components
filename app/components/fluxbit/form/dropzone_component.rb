# frozen_string_literal: true

# The `Fluxbit::Form::DropzoneComponent` provides a drag-and-drop file input zone with support for labels,
# titles, subtitles, icons, validation states, and integration with Rails form builders.
# It renders a visually rich area that lets users drag files or click to select a file, and is fully customizable
# via its options and slot for custom content.
#
# @example Basic usage
#   = render Fluxbit::Form::DropzoneComponent.new(name: :avatar)
#
# @see docs/03_Forms/Dropzone.md For detailed documentation and examples.
class Fluxbit::Form::DropzoneComponent < Fluxbit::Form::FieldComponent
  include Fluxbit::Config::Form::DropzoneComponent

  # Initializes the dropzone component with the given properties.
  #
  # @param name [String] Name of the field (required unless using form builder)
  # @param label [String] Label for the input (optional)
  # @param title [Boolean, String] Title text above the dropzone (true for default, false to hide, or custom string)
  # @param subtitle [Boolean, String] Subtitle text below the title (true for default, false to hide, or custom string)
  # @param icon [String, Symbol] Icon to display above the title (defaults to config)
  # @param icon_props [Hash] Extra props for the icon element
  # @param height [Integer] Height preset (0: auto, 1: h-32, 2: h-64, 3: h-96; default is 0)
  # @param help_text [String] Helper or error text below the field
  # @param ... any other HTML attribute supported by file_field_tag
  def initialize(**props)
    super(**props)
    @title = options(@props.delete(:title), default: true)
    @subtitle = options(@props.delete(:subtitle), default: true)
    @icon = @props.delete(:icon) || @@icon
    @icon_props = @props.delete(:icon_props) || { class: styles[:icon] }
    @height = @props.delete(:height) || @@height
    add to: @props, class: "hidden"
  end

  def create_icon
    anyicon(@icon, class: styles[:icon])
  end
end
