# frozen_string_literal: true

# The `Fluxbit::DropdownItemComponent` is a component for rendering customizable Dropdown item containers.
class Fluxbit::DropdownItemComponent < Fluxbit::Component
  include Fluxbit::Config::DropdownComponent

  renders_many :items, Fluxbit::DropdownItemComponent

  def initialize(param_content = "", **props)
    @param_content = param_content
    @item_props = props
    @type = @item_props.delete(:as) || :div
    @height = @item_props.delete(:height) || @@height
    @icon = @item_props.delete(:icon)
    add to: @item_props, class: styles[:items][:heights][@height]
    remove_class_from_props(@item_props)

    @content_html = @item_props.delete(:content_html) || {}

    @icon_html = @item_props.delete(:icon_html) || {}
    add to: @icon_html, class: styles[:icon] if @icon.present?

    @divider = @item_props.delete(:divider) || false
  end

  def call
    return content_tag(:li, "", class: styles[:divider]) if @divider

    if items.any?
      @content_html["data-dropdown-toggle"] = @item_props.delete(:dropdown_id) || "inner-dropdown-#{random_id}"
      @content_html["data-dropdown-placement"] = @item_props.delete(:dropdown_placement) || "right-start"
      height = @item_props.delete(:sizing) || 0
      auto_divider = @item_props.delete(:auto_divider) || true
      @type = :button
      @content_html[:type] = "button"
    end

    add to: @content_html, class: styles[:items][:types][@type]
    remove_class_from_props(@content_html)

    content_tag(:li, **@item_props) do
      concat(content_tag(@type.to_sym, **@content_html) do
        concat(content_tag :div, class: "flex" do
          concat(anyicon(@icon, **@icon_html)) if @icon.present?
          concat(content || @param_content)
        end)
        concat(chevron_right(class: "ms-3 ml-auto")) if items.any?
      end)
      concat(
        inner_dropdown(items, id: @content_html["data-dropdown-toggle"], sizing: height, auto_divider: auto_divider)
      ) if items.any?
    end
  end

  private

  def inner_dropdown(items, id: "a", sizing: 0, auto_divider: true)
    props = { id: id, class: styles[:base] }
    add to: props, class: [
      styles[:sizes][sizing],
      auto_divider ? styles[:auto_divider] : nil
    ]

    content_tag :div, **props do
      content_tag :ul, items.join.html_safe, class: styles[:ul]
    end
  end
end
