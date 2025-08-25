# frozen_string_literal: true

# The `Fluxbit::BreadcrumbComponent` renders a breadcrumb navigation following Flowbite styles.
# It uses slots for items, allowing each breadcrumb item to have an optional icon and a current_page flag.
class Fluxbit::BreadcrumbComponent < Fluxbit::Component
  # Include configuration (default classes, etc.) for Breadcrumb, if defined
  include Fluxbit::Config::BreadcrumbComponent

  renders_many :items, lambda { |**attrs, &block|
    item = Item.new(**attrs)
    item.with_content(block.call) if block_given?
    item
  }

  # Initialize with any HTML attributes (e.g., custom class or aria-label for the <nav>)
  def initialize(**props)
    super
    @props = props 
    @props["aria-label"] ||= "Breadcrumb"
  end

  def call
    tag.nav(**@props) do
      tag.ol(safe_join(items), class: styles[:root][:list])
    end
  end

  class Item < Fluxbit::Component
    include Fluxbit::Config::BreadcrumbComponent
    renders_one :dropdown, Fluxbit::DropdownComponent

    def initialize(**props)
      super
      @props = props
      @current_page = @props.delete(:current_page)
      @href = @props.delete(:href)
      @icon = @props.delete(:icon)
      @remove_dropdown_arrow = options(@props.delete(:remove_dropdown_arrow), default: false)
    end

    def call
      item_content = content || ""
      add class: styles[:item][:href][(@current_page || @href.blank?) ? :off : :on], to: @props
      if dropdown? && !@remove_dropdown_arrow
        item_content += chevron_down(class: "ms-3")
        add class: styles[:item][:click_cursor], to: @props
      end

      @props["data-dropdown-toggle"] = dropdown.get_item if dropdown?

      tag.li(class: styles[:item][:base]) do
        concat chevron_right(class: styles[:item][:chevron], stroke_width: 1)
        if @current_page || @href.blank?
          concat anyicon(@icon, class: styles[:item][:icon]) if @icon
          concat tag.span(item_content, **@props)
        else
          concat(tag.a(href: @href, **@props) do
            concat(anyicon(@icon, class: styles[:item][:icon])) if @icon
            concat item_content
          end)
        end
        concat(dropdown&.to_s || "")
      end
    end
  end
end
