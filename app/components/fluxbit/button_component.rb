# frozen_string_literal: true

##
# The `Fluxbit::ButtonComponent` is a customizable button component that extends `Fluxbit::Component`.
# It allows you to create buttons with various styles, sizes, colors, and supports additional
# features like popovers and tooltips.
class Fluxbit::ButtonComponent < Fluxbit::Component
  include Fluxbit::Config::ButtonComponent
  renders_one :popover, lambda { |**props, &block|
    @popover_props = props
    @popover_text = block.call
  }
  renders_one :tooltip, lambda { |**props, &block|
    @tooltip_props = props
    @tooltip_text = block.call
  }

  ##
  # Initializes the button component with the given properties.
  #
  # @param [Hash] props The properties to customize the button.
  # @option props [Object] :form (nil) The form object associated with the button.
  # @option props [Symbol, String] :as The HTML tag to use for the button (e.g., `:button`, `:a`).
  # @option props [Boolean] :pill (false) Determines if the button has pill-shaped edges.
  # @option props [Symbol, String] :color The color style of the button.
  # @option props [Symbol, String] :size The size of the button (e.g., `0` to `4`).
  # @option props [Boolean] :disabled (false) Sets the button to a disabled state.
  # @option props [String] :remove_class ('') Classes to remove from the default class list.
  # @option props [String] :popover_text (nil) Popover text (from Fluxbit::Component).
  # @option props [Symbol] :popover_placement (:right) Popover placement (e.g., `:right`, `:left`, `:top`, `:bottom`) (from Fluxbit::Component).
  # @option props [Symbol] :popover_trigger (:hover) Popover trigger (e.g., `:hover`, `:click`) (from Fluxbit::Component).
  # @option props [String] :tooltip_text (nil) Tooltip text (from Fluxbit::Component).
  # @option props [Symbol] :tooltip_placement (:right) Tooltip placement (e.g., `:right`, `:left`, `:top`, `:bottom`) (from Fluxbit::Component).
  # @option props [Symbol] :tooltip_trigger (:hover) Tooltip trigger (e.g., `:hover`, `:click`) (from Fluxbit::Component).
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::ButtonComponent]
  def initialize(**props)
    super
    @props = props
    @form = @props.delete(:form)
    @as = @props.delete(:as) || @@as
    @pill = @props.delete(:pill) || @@pill
    @color = @props.delete(:color) || @@color
    @grouped = @props.delete(:grouped) || false
    @first_button = @props.delete(:first_button) || false
    @last_button = @props.delete(:last_button) || false
    @outline = @color.end_with?("_outline")
    declare_size(@props.delete(:size) || @@size)
    declare_disabled
    declare_classes
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def declare_size(size)
    return if size.blank?

    add(
      class: (styles[:size][size.to_i]),
      to: @props,
      first_element: true
    )
  end

  def declare_classes
    add(class: styles[:pill][@pill ? :on : :off], to: @props, first_element: true) unless @outline
    add(class: styles[:outline][:pill][@pill ? :on : :off], to: @props, first_element: true) if @outline
    add(class: styles[:outline][@outline ? :on : :off], to: @props, first_element: true)
    add(class: styles[:base], to: @props, first_element: true)
    add(
      class: (@color.in?(styles[:colors].keys) ? styles[:colors][@color] : styles[:colors][:info]),
      to: @props,
      first_element: true
    )
    add(class: styles[:inner][:base], to: @props) if @grouped
    add(class: styles[:inner][:position][:start], to: @props) if @grouped && @first_button
    add(class: styles[:inner][:position][:end], to: @props) if @grouped && @last_button
    add(class: styles[:inner][:position][:middle], to: @props) if @grouped && !@last_button && !@first_button
  end

  def declare_disabled
    return unless @props[:disabled].present? && @props[:disabled] == true

    add(class: styles[:disabled], to: @props, first_element: true)
  end

  def before_render
    add_popover_or_tooltip
  end

  def call
    concat(
      (@form.nil? ? content_tag(@as, content, @props) : @form.submit(**@props)) +
      render_popover_or_tooltip.to_s
    )
  end
end
