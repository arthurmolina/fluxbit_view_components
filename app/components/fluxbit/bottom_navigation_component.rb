# frozen_string_literal: true

##
# The `Fluxbit::BottomNavigationComponent` is a customizable bottom navigation component that extends `Fluxbit::Component`.
# It allows you to create fixed bottom navigation bars with multiple menu items, icons, and text labels.
#
# @example Basic usage
#   = fx_bottom_navigation do |nav|
#     nav.with_item(href: "/", icon: "heroicons_solid:home") { "Home" }
#     nav.with_item(href: "/search", icon: "heroicons_solid:magnifying-glass") { "Search" }
#   end
#
# @example With button group
#   = fx_bottom_navigation do |nav|
#     nav.with_button_group(columns: 3) do |group|
#       group.with_button(active: true) { "New" }
#       group.with_button { "Popular" }
#       group.with_button { "Following" }
#     end
#     nav.with_item(href: "/", icon: "heroicons_solid:home") { "Home" }
#     nav.with_item(href: "/wallet", icon: "heroicons_solid:wallet") { "Wallet" }
#   end
#
# @see docs/02_Components/BottomNavigation.md For detailed documentation.
class Fluxbit::BottomNavigationComponent < Fluxbit::Component
  include Fluxbit::Config::BottomNavigationComponent

  renders_many :items, lambda { |**props, &block|
    Item.new(**props, parent_config: self, parent_variant: @variant, &block)
  }

  renders_one :cta, lambda { |**props, &block|
    CTA.new(**props, parent_config: self, &block)
  }

  renders_one :pagination, lambda { |**props, &block|
    Pagination.new(**props, parent_config: self, &block)
  }

  renders_one :button_group, lambda { |**props, &block|
    ButtonGroup.new(**props, parent_config: self, &block)
  }

  ##
  # Initializes the bottom navigation component with the given properties.
  #
  # @param [Hash] **props The properties to customize the component.
  # @option props [Symbol] :variant (:default) The style variant (:default or :app_bar).
  # @option props [Boolean] :border (true) Shows border at the top of the navigation.
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::BottomNavigationComponent]
  def initialize(**props)
    super
    @props = props

    @variant = options(@props.delete(:variant), collection: styles[:variants].keys, default: @@variant)
    @border = options(@props.delete(:border), default: @@border)

    declare_classes

    # Handle class removal
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def call
    items      # Ensure items are rendered
    cta        # Ensure CTA is rendered if present
    pagination # Ensure pagination is rendered if present
    button_group # Ensure button_group is rendered if present

    # Adjust height when button_group is present
    if button_group?
      @props[:class] = @props[:class].gsub(/\bh-16\b/, 'h-auto')
    end

    tag.div(**@props) do
      safe_join([
        (button_group if button_group?),
        tag.div(class: container_classes) do
          if cta?
            # Insert CTA in the middle for both variants
            half = (items.size / 2.0).floor
            safe_join(items[0...half] + [tag.div(cta, class: styles[:cta_wrapper])] + items[half..])
          elsif pagination?
            # Insert pagination in the middle
            half = (items.size / 2.0).floor
            safe_join(items[0...half] + [pagination] + items[half..])
          else
            safe_join(items)
          end
        end
      ].compact)
    end
  end

  private

  def declare_classes
    add(class: styles[:variants][@variant][:base], to: @props, first_element: true)
    add(class: styles[:variants][@variant][:border], to: @props) if @border && @variant == :default
  end

  def container_classes
    base = styles[:container][:base]

    # When button_group is present, set specific height for items container
    if button_group?
      base = base.gsub(/\bh-full\b/, 'h-16')
    end

    # Auto-calculate columns based on items count and presence of CTA/pagination
    columns = calculate_columns

    [
      base,
      styles[:container][:columns][columns - 2]
    ].compact.join(" ")
  end

  def calculate_columns
    # Count items + additional columns for CTA/pagination
    total = items.size
    total += 1 if cta?        # CTA occupies 1 grid cell
    total += 2 if pagination? # Pagination spans 2 grid cells (col-span-2)

    # Ensure columns is within valid range (2-6)
    [[total, 2].max, 6].min
  end

  ##
  # Item component for bottom navigation
  class Item < Fluxbit::Component
    include Fluxbit::Config::BottomNavigationComponent

    ##
    # Initializes the item component.
    #
    # @param [Hash] **props The properties to customize the item.
    # @option props [String] :href The URL the item links to.
    # @option props [String] :icon The icon to display.
    # @option props [Boolean] :active (false) Whether the item is currently active.
    # @option props [String] :tooltip_text Tooltip text to display on hover.
    # @option props [Boolean] :sr_only (false) Show text for screen readers only.
    # @option props [Fluxbit::BottomNavigationComponent] :parent_config Parent component configuration.
    # @option props [Symbol] :parent_variant Parent component variant.
    # @option props [Hash] **props Remaining options declared as HTML attributes.
    #
    # @return [Item]
    def initialize(**props, &block)
      super(**props, &block)
      @props = props
      @parent_config = @props.delete(:parent_config)
      @parent_variant = @props.delete(:parent_variant) || :default

      @href = @props.delete(:href) || "#"
      @icon = @props.delete(:icon)
      @active = options(@props.delete(:active), default: false)
      @tooltip_text = @props.delete(:tooltip_text)
      @sr_only = options(@props.delete(:sr_only), default: @parent_variant == :app_bar)

      add(class: styles[:item][:base], to: @props, first_element: true)
      add(class: styles[:item][:active], to: @props) if @active
      add(class: styles[:item][:inactive], to: @props) unless @active

      @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
    end

    def call
      setup_data_attributes

      button_content = tag.button(type: "button", **@props) do
        concat(render_icon) if @icon
        concat(tag.span(content, class: text_classes))
      end

      if @tooltip_text
        safe_join([button_content, render_tooltip])
      else
        button_content
      end
    end

    private

    def render_icon
      return "" if @icon.blank?

      tag.div(class: styles[:item][:icon_wrapper]) do
        anyicon(@icon, class: styles[:item][:icon])
      end
    end

    def text_classes
      @sr_only ? styles[:item][:sr_only] : styles[:item][:text]
    end

    def setup_data_attributes
      @props[:data] ||= {}
      @props[:data][:href] = @href

      if @tooltip_text
        tooltip_id = "tooltip-#{content.to_s.parameterize}"
        @props[:data][:"tooltip-target"] = tooltip_id
      end
    end

    def render_tooltip
      tooltip_id = "tooltip-#{content.to_s.parameterize}"

      tag.div(id: tooltip_id, role: "tooltip", class: styles[:tooltip][:base]) do
        concat(@tooltip_text)
        concat(tag.div(class: styles[:tooltip][:arrow], data: { tooltip_arrow: "" }))
      end
    end
  end

  ##
  # CTA component for app bar variant
  class CTA < Fluxbit::Component
    include Fluxbit::Config::BottomNavigationComponent

    ##
    # Initializes the CTA component.
    #
    # @param [Hash] **props The properties to customize the CTA.
    # @option props [String] :href The URL the CTA links to.
    # @option props [String] :icon The icon to display.
    # @option props [String] :tooltip_text Tooltip text to display on hover.
    # @option props [Hash] **props Remaining options declared as HTML attributes.
    #
    # @return [CTA]
    def initialize(**props, &block)
      super(**props, &block)
      @props = props
      @parent_config = @props.delete(:parent_config)

      @href = @props.delete(:href) || "#"
      @icon = @props.delete(:icon)
      @tooltip_text = @props.delete(:tooltip_text)

      add(class: styles[:cta][:button], to: @props, first_element: true)

      @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
    end

    def call
      setup_data_attributes

      button_content = tag.button(type: "button", **@props) do
        safe_join([
          (@icon ? anyicon(@icon, class: styles[:cta][:icon]) : nil),
          tag.span(content, class: styles[:item][:sr_only])
        ].compact)
      end

      if @tooltip_text
        safe_join([button_content, render_tooltip])
      else
        button_content
      end
    end

    private

    def setup_data_attributes
      @props[:data] ||= {}
      @props[:data][:href] = @href

      if @tooltip_text
        tooltip_id = "tooltip-#{content.to_s.parameterize}"
        @props[:data][:"tooltip-target"] = tooltip_id
      end
    end

    def render_tooltip
      tooltip_id = "tooltip-#{content.to_s.parameterize}"

      tag.div(id: tooltip_id, role: "tooltip", class: styles[:tooltip][:base]) do
        concat(@tooltip_text)
        concat(tag.div(class: styles[:tooltip][:arrow], data: { tooltip_arrow: "" }))
      end
    end
  end

  ##
  # Pagination component for bottom navigation
  class Pagination < Fluxbit::Component
    include Fluxbit::Config::BottomNavigationComponent

    ##
    # Initializes the pagination component.
    #
    # @param [Hash] **props The properties to customize the pagination.
    # @option props [Integer] :current_page (1) The current page number.
    # @option props [Integer] :total_pages (1) The total number of pages.
    # @option props [String] :previous_href The URL for the previous page.
    # @option props [String] :next_href The URL for the next page.
    # @option props [String] :previous_label ("Previous") The label for the previous button.
    # @option props [String] :next_label ("Next") The label for the next button.
    # @option props [Hash] **props Remaining options declared as HTML attributes.
    #
    # @return [Pagination]
    def initialize(**props, &block)
      super(**props, &block)
      @props = props
      @parent_config = @props.delete(:parent_config)

      @current_page = @props.delete(:current_page) || 1
      @total_pages = @props.delete(:total_pages) || 1
      @previous_href = @props.delete(:previous_href) || "#"
      @next_href = @props.delete(:next_href) || "#"
      @previous_label = @props.delete(:previous_label) || "Previous"
      @next_label = @props.delete(:next_label) || "Next"
    end

    def call
      tag.div(class: styles[:pagination][:container]) do
        safe_join([
          render_previous_button,
          render_page_info,
          render_next_button
        ])
      end
    end

    private

    def render_previous_button
      tag.button(
        type: "button",
        class: styles[:pagination][:button],
        data: { href: @previous_href },
        disabled: @current_page <= 1
      ) do
        concat(chevron_left(class: styles[:pagination][:icon]))
        concat(tag.span(@previous_label, class: "sr-only"))
      end
    end

    def render_next_button
      tag.button(
        type: "button",
        class: styles[:pagination][:button],
        data: { href: @next_href },
        disabled: @current_page >= @total_pages
      ) do
        concat(tag.span(@next_label, class: "sr-only"))
        concat(chevron_right(class: styles[:pagination][:icon]))
      end
    end

    def render_page_info
      tag.div(class: styles[:pagination][:info]) do
        "#{@current_page} of #{@total_pages}"
      end
    end
  end

  ##
  # ButtonGroup component for bottom navigation
  class ButtonGroup < Fluxbit::Component
    include Fluxbit::Config::BottomNavigationComponent

    renders_many :buttons, lambda { |**props, &block|
      Button.new(**props, parent_config: self, &block)
    }

    ##
    # Initializes the button group component.
    #
    # @param [Hash] **props The properties to customize the button group.
    # @option props [Integer] :columns (3) Number of columns for button grid (2-5).
    # @option props [Hash] **props Remaining options declared as HTML attributes.
    #
    # @return [ButtonGroup]
    def initialize(**props, &block)
      super(**props, &block)
      @props = props
      @parent_config = @props.delete(:parent_config)
      @columns = @props.delete(:columns) || 3
    end

    def call
      buttons # Ensure buttons are rendered

      tag.div(class: styles[:button_group][:container], role: "group") do
        tag.div(class: button_group_grid_classes) do
          safe_join(buttons)
        end
      end
    end

    private

    def button_group_grid_classes
      [
        styles[:button_group][:grid],
        "grid-cols-#{@columns}"
      ].compact.join(" ")
    end

    ##
    # Button component for button group
    class Button < Fluxbit::Component
      include Fluxbit::Config::BottomNavigationComponent

      ##
      # Initializes the button component.
      #
      # @param [Hash] **props The properties to customize the button.
      # @option props [String] :href The URL the button links to.
      # @option props [Boolean] :active (false) Whether the button is currently active.
      # @option props [Hash] **props Remaining options declared as HTML attributes.
      #
      # @return [Button]
      def initialize(**props, &block)
        super(**props, &block)
        @props = props
        @parent_config = @props.delete(:parent_config)

        @href = @props.delete(:href) || "#"
        @active = options(@props.delete(:active), default: false)

        add(class: styles[:button_group][:button], to: @props, first_element: true)
        add(class: styles[:button_group][:button_active], to: @props) if @active
        add(class: styles[:button_group][:button_inactive], to: @props) unless @active

        @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
      end

      def call
        @props[:data] ||= {}
        @props[:data][:href] = @href

        tag.button(type: "button", **@props) do
          content
        end
      end
    end
  end
end
