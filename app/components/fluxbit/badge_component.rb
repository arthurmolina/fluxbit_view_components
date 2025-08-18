# frozen_string_literal: true

##
# The `Fluxbit::BadgeComponent` is a customizable badge component that extends `Fluxbit::Component`.
# It allows you to create badges with different colors, sizes, borders, and shapes (pill).
class Fluxbit::BadgeComponent < Fluxbit::Component
  include Fluxbit::Config::BadgeComponent
  renders_one :popover, lambda { |**props, &block|
    @popover_props = props
    @popover_text = block.call
  }
  renders_one :tooltip, lambda { |**props, &block|
    @tooltip_props = props
    @tooltip_text = block.call
  }

  ##
  # Initializes the badge component with the given properties.
  #
  # @param [Hash] props The properties to customize the badge.
  # @option props [Symbol, String] :color The color style of the badge.
  # @option props [Boolean] :pill (false) Determines if the badge is pill-shaped.
  # @option props [Symbol, Integer] :size The size of the badge (e.g., `0` to `1`).
  # @option props [Symbol, String] :perfect_rounded (:none) Define if the bage is a perfect rounded with size (e.g., `0` to `5`).
  # @option props [Symbol, String] :as The HTML tag to use for the badge (e.g., `:span`, `:div`).
  # @option props [String] :remove_class ('') Classes to remove from the default class list.
  # @option props [String] :popover_text (nil) Popover text (from Fluxbit::Component).
  # @option props [Symbol] :popover_placement (:right) Popover placement (e.g., `:right`, `:left`, `:top`, `:bottom`) (from Fluxbit::Component).
  # @option props [Symbol] :popover_trigger (:hover) Popover trigger (e.g., `:hover`, `:click`) (from Fluxbit::Component).
  # @option props [String] :tooltip_text (nil) Tooltip text (from Fluxbit::Component).
  # @option props [Symbol] :tooltip_placement (:right) Tooltip placement (e.g., `:right`, `:left`, `:top`, `:bottom`) (from Fluxbit::Component).
  # @option props [Symbol] :tooltip_trigger (:hover) Tooltip trigger (e.g., `:hover`, `:click`) (from Fluxbit::Component).
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::BadgeComponent]
  def initialize(**props)
    super
    @props = props
    @color = options @props.delete(:color), collection: styles[:colors].keys, default: @@color
    @pill = options @props.delete(:pill), default: @@pill
    @size = options @props.delete(:size), default: @@size
    @perfect_rounded = options @props.delete(:perfect_rounded), default: @@perfect_rounded
    @notification = options @props.delete(:notification), default: @@notification
    @as = options @props.delete(:as), default: @@as

    add(class: badge_classes, to: @props, first_element: true)
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def before_render
    add_popover_or_tooltip
  end

  def call
    concat(content_tag(@as, content, @props) + render_popover_or_tooltip.to_s)
  end

  private

  def badge_classes
    @badge_classes ||= begin
      base_classes = [
        styles[:base],
        styles[:colors][@color.to_sym],
        styles[:sizes][@size.to_i],
        styles[:perfect_rounded][@perfect_rounded.to_i],
        styles[:pill][@pill ? :on : :off],
        notification_classes
      ]
      base_classes.join(" ")
    end
  end

  def notification_classes
    return "" unless @notification.present?
    ([ styles[:notification][:default] ] + @notification.split(" ").map do |position|
      styles[:notification][:positions][position.to_sym]
    end).join(" ")
  end
end
