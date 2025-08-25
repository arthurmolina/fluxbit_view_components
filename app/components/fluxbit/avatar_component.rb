# frozen_string_literal: true


# The `Fluxbit::AvatarComponent` is a component for rendering customizable avatars.
# It extends `Fluxbit::Component` and provides options for configuring the avatar's
# appearance and behavior. You can control the avatar's color, placeholder initials,
# status, size, and other attributes. The avatar can display an image or a placeholder
# icon if no image is provided.
class Fluxbit::AvatarComponent < Fluxbit::Component
  include Fluxbit::Config::AvatarComponent

  # Initializes the avatar component with the given properties.
  #
  # @param [Hash] props The properties to customize the avatar.
  # @option props [String] :color The color of the avatar border.
  # @option props [String] :placeholder_initials The initials to display as a placeholder.
  # @option props [Symbol] :status The status of the avatar (:online, :busy, :offline, :away).
  # @option props [String] :status_position The position of the status indicator.
  # @option props [Boolean] :rounded Whether the avatar should have rounded corners.
  # @option props [Symbol, String] :size The size of the avatar.
  # @option props [String] :src The source URL of the avatar image.
  # @option props [String] :remove_class Classes to be removed from the default avatar class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes, applied to the avatar container.
  def initialize(**props)
    super
    @props = props
    @color = @props.delete(:color) || @@color
    @placeholder_initials = @props.delete(:placeholder_initials) || @@placeholder_initials
    @status = @props[:status].nil? ? @@status : @props.delete(:status) # online, busy, offline, away
    @status_position = (@props.delete(:status_position) || @@status_position).to_s.split("_").map(&:to_sym)
    @rounded = @props[:rounded].nil? ? @@rounded : @props.delete(:rounded)
    @size = @props.delete(:size) || @@size
    @src = @props[:src]
    declare_color
    declare_classes
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def declare_color
    return unless @color.present?
    add to: @props,
        first_element: true,
        class: "#{styles[:bordered]} #{@color.in?(styles[:color].keys) ? styles[:color][@color] : styles[:color][:info]}"
  end

  def declare_classes
    add to: @props,
        first_element: true,
        class: [
          (!@placeholder_initials && @src.nil? ? styles[:placeholder_icon][:base] : ""),
          @placeholder_initials ? styles[:initials][:base] : "",
          styles[@rounded ? :rounded : :not_rounded][:base],
          (@size.in?(styles[:size].keys) ? styles[:size][@size] : styles[:size][:md])
        ].join(" ")
  end

  def avatar_itself
    return tag.img(**@props) unless @src.nil? || @placeholder_initials

    tag.div(**@props) do
      if @placeholder_initials
        tag.span(@placeholder_initials, class: styles[:initials][:text])
      else
        placeholder_icon
      end
    end
  end

  def placeholder_icon
    svg_attributes = {
      class: [ "absolute", "text-gray-400", "-left-1", placeholder_size ].join(" "),
      fill: "currentColor",
      viewBox: "0 0 20 20",
      xmlns: "http://www.w3.org/2000/svg"
    }

    path_attributes = {
      "fill-rule": "evenodd",
      d: "M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z",
      "clip-rule": "evenodd"
    }

    tag.svg(**svg_attributes) do
      tag.path(**path_attributes)
    end
  end

  def placeholder_size
    return styles[:placeholder_icon][:size][@size] if @size.in?(styles[:placeholder_icon][:size].keys)

    styles[:size][:md]
  end

  def dot_indicator
    tag.span("", class: [
      styles[:status][:base],
      styles[:status][:options][@status],
      styles[@rounded ? :rounded : :not_rounded][:status_position][@status_position[0]],
                  styles[@rounded ? :rounded : :not_rounded][:status_position][@status_position[1]][@size]
                ].join(" ")
    )
  end

  def call
    return avatar_itself unless @status

    tag.div(class: "relative") do
      concat avatar_itself
      concat dot_indicator
    end
  end
end
