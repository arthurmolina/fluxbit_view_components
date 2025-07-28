# frozen_string_literal: true

##
# The `Fluxbit::AlertComponent` is a customizable alert component that extends `Fluxbit::Component`.
# It provides various options to display alert messages with different styles, icons, and behaviors
# such as close functionality and animations.
#
# Example usage:
#   = render Fluxbit::AlertComponent.new(color: :success, icon: "check").with_content("Alert message")
#
class Fluxbit::AlertComponent < Fluxbit::Component
  include Fluxbit::Config::AlertComponent

  ##
  # Initializes the alert component with the given properties.
  #
  # @param [Hash] props The properties to customize the alert.
  # @option props [Symbol, String] :color (:info) The color style of the alert.
  # @option props [Symbol, String, Boolean] :icon (:default) The icon to display in the alert or `false` to omit.
  # @option props [String] :class_icon ('') Additional CSS classes for the icon.
  # @option props [Boolean] :can_close (true) Determines if the alert can be closed.
  # @option props [String] :remove_class ('') Classes to remove from the default class list.
  # @option props [Integer] :dismiss_timeout (3000) The timeout in milliseconds before the alert dismisses itself.
  # @option props [Boolean] :fade_in_animation (true) Determines if the alert should fade in.
  # @option props [Symbol] :out_animation (:fade_out) The type of fade out/dismiss animation.
  # @option props [Boolean] :all_rounded (true) Determines if the alert has rounded corners.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::AlertComponent]
  #
  # @example
  #   = render Fluxbit::AlertComponent.new(color: :success, icon: "check").with_content("Alert message")
  #
  def initialize(**props)
    super
    @props = props
    @color = define_color(@props.delete(:color) || @@color)
    @icon = define_icon(@props.delete(:icon) || :default, @props.delete(:class_icon) || "")
    @can_close = @props[:can_close].nil? ? @@can_close : @props.delete(:can_close)
    @all_rounded = @props[:all_rounded].nil? ? @@all_rounded : @props.delete(:all_rounded)
    @props["id"] = fx_id if @props["id"].nil?
    @props[:role] = "alert"
    prop_fade_in_automation = @props.delete(:fade_in_animation)

    animation_props(
      dismiss_timeout: [ (@props.delete(:dismiss_timeout) || @@dismiss_timeout).to_i, 0 ].max,
      fade_in_animation: prop_fade_in_automation.nil? ? @@fade_in_animation : prop_fade_in_automation,
      out_animation: @props.delete(:out_animation) || @@out_animation
    )
    declare_classes
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def animation_props(dismiss_timeout:, fade_in_animation:, out_animation:)
    return if [ :dont_remove, nil ].include?(out_animation) || dismiss_timeout.to_i == 0

    @props["data-controller"] = "notification"
    @props["data-action"] = "notification#hide"
    @props["data-notification-delay-value"] = dismiss_timeout.to_s

    add(to: @props, class: "transition transform duration-1000 hidden")

    if fade_in_animation
      @props["data-transition-enter-from"] = "opacity-0"
      @props["data-transition-enter-to"] = "opacity-100"
    else
      @props["data-transition-enter-from"] = "opacity-100"
      @props["data-transition-enter-to"] = "opacity-100"
    end

    @props["data-transition-leave-from"] = styles[:animations][out_animation.to_sym][:from]
    @props["data-transition-leave-to"] = styles[:animations][out_animation.to_sym][:to]
  end

  def call
    content_tag :div, @props do
      concat @icon
      concat content_tag(:div, content, class: "ml-3 text-sm font-medium")
      concat close_button
    end
  end

  private

  def declare_classes
    add to: @props,
        first_element: true,
        class: [
          styles[:colors][@color],
          styles[:all_rounded][@all_rounded ? :on : :off],
          styles[:base]
        ]
  end

  def define_color(color)
    case color.to_sym
    when :timedout, :alert then :danger
    when *styles[:colors].keys then color
    else @@color # :notice included
    end
  end

  def define_icon(icon, class_icon = "")
    return "" if icon == false
    icon = icon || @@icon
    return anyicon(icon, class: class_icon) if icon != :default

    anyicon("heroicons_solid:#{styles[:default_icons][@color]}", class: class_icon + " size-4")
  end

  def close_button
    return "" unless @can_close

    b_props = {
      "aria-label" => "Close",
      "data-dismiss-target" => "##{@props["id"]}",
      type: "button"
    }

    add to: b_props, class: [ styles[:close_button][:base], styles[:close_button][:colors][@color] ]
    content_tag :button, b_props do
      concat content_tag(:span, "Dismiss", class: "sr-only")
      concat anyicon("heroicons_outline:x-mark", class: "size-5")
    end
  end
end
