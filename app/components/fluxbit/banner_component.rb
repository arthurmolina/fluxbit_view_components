# frozen_string_literal: true

##
# The `Fluxbit::BannerComponent` is a customizable banner component that extends `Fluxbit::Component`.
# It provides various options to display banner messages with different styles, positions, and behaviors
# such as close functionality and call-to-action elements.
#
# Example usage:
#   = render Fluxbit::BannerComponent.new(position: :top, color: :info).with_content("Banner message")
#
class Fluxbit::BannerComponent < Fluxbit::Component
  include Fluxbit::Config::BannerComponent

  renders_one :cta_button, lambda { |**props|
    Fluxbit::ButtonComponent.new(**props)
  }

  renders_one :logo, lambda { |**props|
    content_tag(:img, "", **props)
  }

  ##
  # Initializes the banner component with the given properties.
  #
  # @param [Hash] props The properties to customize the banner.
  # @option props [Symbol, String] :position (:top) The position of the banner (top, bottom, sticky_top, sticky_bottom).
  # @option props [Symbol, String] :color (:info) The color style of the banner.
  # @option props [Symbol, String, Boolean] :icon (:default) The icon to display in the banner or `false` to omit.
  # @option props [Hash] :icon_html ({}) Additional HTML attributes for the icon.
  # @option props [Boolean] :dismissible (true) Determines if the banner can be dismissed.
  # @option props [Boolean] :full_width (true) Determines if the banner spans the full width.
  # @option props [String] :remove_class ('') Classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::BannerComponent]
  #
  # @example
  #   = render Fluxbit::BannerComponent.new(position: :top, color: :info).with_content("Banner message")
  #
  def initialize(**props)
    super
    @props = props
    @position = define_position(@props.delete(:position) || @@position)
    @color = define_color(@props.delete(:color) || @@color)
    icon_prop = @props.delete(:icon)
    icon_html = @props.delete(:icon_html) || {}
    @icon = define_icon(icon_prop.nil? ? :default : icon_prop, icon_html)
    @dismissible = @props[:dismissible].nil? ? @@dismissible : @props.delete(:dismissible)
    @full_width = @props[:full_width].nil? ? @@full_width : @props.delete(:full_width)
    @props["id"] = fx_id if @props["id"].nil?

    declare_classes
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def call
    tag.div(**@props) do
      concat banner_content
    end
  end

  private

  def banner_content
    content_wrapper_class = @full_width ? styles[:content_wrapper][:full_width] : styles[:content_wrapper][:constrained]

    tag.div(class: content_wrapper_class) do
      concat banner_left_content
      concat banner_right_content if @dismissible || cta_button?
    end
  end

  def banner_left_content
    tag.div(class: styles[:left_content]) do
      concat logo if logo?
      concat @icon unless @icon.blank?
      text_class = icon_or_logo_present? ? styles[:text][:with_icon_or_logo] : styles[:text][:without_icon_or_logo]
      concat tag.div(content, class: text_class)
    end
  end

  def banner_right_content
    tag.div(class: styles[:right_content]) do
      concat cta_button if cta_button?
      concat dismiss_button if @dismissible
    end
  end

  def icon_or_logo_present?
    !@icon.blank? || logo?
  end

  def dismiss_button
    button_props = {
      "aria-label" => t("fluxbit.banner.aria_close"),
      "data-dismiss-target" => "##{@props["id"]}",
      type: "button",
      class: styles[:dismiss_button][:base]
    }

    if cta_button?
      add(to: button_props, class: styles[:dismiss_button][:with_cta])
    end

    tag.button(**button_props) do
      concat tag.span(t("fluxbit.banner.dismiss"), class: styles[:screen_reader])
      concat close_icon(class: styles[:close_icon])
    end
  end

  def declare_classes
    base_classes = [
      styles[:base],
      styles[:positions][@position],
      styles[:colors][@color]
    ]

    add(to: @props, first_element: true, class: base_classes)
  end

  def define_position(position)
    position.to_sym.in?(styles[:positions].keys) ? position.to_sym : @@position
  end

  def define_color(color)
    color.to_sym.in?(styles[:colors].keys) ? color.to_sym : @@color
  end

  def define_icon(icon, icon_html = {})
    return "" if icon == false
    icon = icon || @@icon
    icon_props = { class: styles[:icon_default] }.merge(icon_html)
    icon_props[:class] = remove_class(icon_props.delete(:remove_class) || "", icon_props[:class])

    return anyicon(icon, **icon_props) if icon != :default

    anyicon("heroicons_solid:#{styles[:default_icons][@color]}", **icon_props)
  end
end