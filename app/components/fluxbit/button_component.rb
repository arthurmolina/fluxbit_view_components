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
  renders_one :dropdown, Fluxbit::DropdownComponent

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
    @content = @props.delete(:content)
    @as = options @props.delete(:as), default: @@as
    @pill = options @props.delete(:pill), default: @@pill
    @color = options (@props.delete(:color) || "").to_sym, collection: styles[:colors].keys, default: @@color
    @grouped = options @props.delete(:grouped), default: false
    @first_button = options @props.delete(:first_button), default: false
    @last_button = options @props.delete(:last_button), default: false
    @outline = @color.to_s.end_with?("_outline")
    @full_sized = options(@props.delete(:full_sized), default: true)
    @remove_dropdown_arrow = options(@props.delete(:remove_dropdown_arrow), default: false)
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
    add(class: styles[:full_sized], to: @props) if @full_sized
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
    @props["data-dropdown-toggle"] = dropdown.get_item if dropdown?

    concat(render_button)
    concat(render_popover_or_tooltip.to_s)
    concat(dropdown&.to_s || "")
  end

  private

  def render_button
    button_content = @content || content || ""

    if @form.nil?
      button_content += dropdown? && !@remove_dropdown_arrow ? chevron_down(class: "ms-3") : ""
      content_tag(@as, button_content, @props)
    else
      @form.submit(button_content, **@props)
    end
  end
end
