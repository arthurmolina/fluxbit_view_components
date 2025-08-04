# frozen_string_literal: true

class Fluxbit::TabComponent < Fluxbit::Component
  include Fluxbit::Config::TabComponent

  attr_reader :variant, :lazy_load

  renders_many :tabs, lambda { |**props, &block|
    begin
      @tabs_group << ComponentObj.new(props, view_context.capture(&block))
    rescue
      @tabs_group << ComponentObj.new(props, nil)
    end
  }

  def initialize(**props)
    @variant = (props.delete(:variant) || @@variant).to_sym
    @color = props.delete(:color) || @@color
    @vertical = props.delete(:vertical) || @@vertical
    @tab_panel = (props.delete(:tab_panel) || @@tab_panel).to_sym
    @tabs_group = []
    @ul_html = props.delete(:ul_html) || {}
    @props = props
    @vertical = false if @variant == :full_width
    super
  end

  def call
    tabs
    @has_panels = @tabs_group.map(&:content).compact.present?
    add class: styles[:div][@vertical ? :vertical : :horizontal], to: @props, first_element: true

    if @has_panels
      content_tag :div, **@props do
        concat(render_tab_list)
        concat(render_tab_panels)
      end
    else
      concat(render_tab_list)
    end
  end

  private

  def render_tab_list
    add class: styles[:tab_list][:ul][@vertical ? :vertical : :horizontal], to: @ul_html, first_element: true
    add class: styles[:tab_list][:variant][variant], to: @ul_html
    @ul_html[:role] = "tablist"

    if @has_panels
      @ul_html[:data] = {
        "tabs-toggle": "##{fx_id}-content",
        "tabs-active-classes": styles[:tab_list][:tab_item][:variant][variant][:active][@color],
        "tabs-inactive-classes": styles[:tab_list][:tab_item][:variant][variant][:inactive]
      }
    end

    @ul_html[:id] = fx_id

    content_tag :ul, **@ul_html do
      safe_join(@tabs_group.map.with_index { |tab, index| render_tab(tab, index) })
    end
  end

  def variant_color_style(active, disabled)
    if active
      styles[:tab_list][:tab_item][:variant][variant][:active][@color]
    elsif disabled
      styles[:tab_list][:tab_item][:variant][variant][:disabled]
    else
      styles[:tab_list][:tab_item][:variant][variant][:inactive]
    end
  end

  def render_tab(tab, index)
    tab_icon = tab.props.delete(:icon)
    tab_title = tab.props.delete(:title)
    tab_active = tab.props.delete(:active)

    add class: [
      styles[:tab_list][:tab_item][:base],
      styles[:tab_list][:tab_item][:variant][variant][:base],
      variant_color_style(tab_active, tab.props[:disabled])
    ], to: tab.props, first_element: true

    add(class: styles[:tab_list][:tab_item][:variant][variant][:first], to: tab.props) if index.zero? && styles[:tab_list][:tab_item][:variant][variant][:first].present?
    add(class: styles[:tab_list][:tab_item][:variant][variant][:last], to: tab.props) if index == @tabs_group.size - 1 && styles[:tab_list][:tab_item][:variant][variant][:last].present?
    add(class: styles[:tab_list][:tab_item][:variant][variant][:middle], to: tab.props) if index > 0 && index < @tabs_group.size - 1 && styles[:tab_list][:tab_item][:variant][variant][:middle].present?

    tab.props[:role] = "tab"
    tab.props[:"aria-selected"] = tab.props[:active].to_s
    tab.props[:"aria-controls"] = "#{fx_id}-tabpanel-#{index}"
    tab.props[:id] = "#{fx_id}-#{index}"
    tab.props[:type] = "button"
    tab.props[:data] = { "tabs-target": "##{fx_id}-tabpanel-#{index}" }
    tab.props[:href] = "#" if tab.props[:href].blank?

    if tab.props[:disabled].present? && tab.props[:disabled]
      tab.props.delete :href
      tab.props.delete :role
      tab.props.delete :"aria-selected"
      tab.props.delete :"aria-controls"
    end

    li_html = tab.props.delete(:li_html) || {}
    li_html[:role] = "presentation"
    li_html[:id] = "#{fx_id}-#{index}-li"
    add class: styles[:tab_list][:li], to: li_html, first_element: true

    content_tag :li, **li_html do
      content_tag :a, **tab.props do
        concat(render_icon(tab_icon)) if tab_icon
        concat(content_tag(:span, tab_title))
      end
    end
  end

  def render_icon(icon)
    if icon.include?('class="')
      icon.gsub("class=\"", "class=\"#{styles[:tab_list][:tab_item][:icon]} ")
    else
      icon.gsub("<svg", "<svg class=\"#{styles[:tab_list][:tab_item][:icon]}\"")
    end.html_safe
  end

  def render_tab_panels
    content_tag :div, id: "##{fx_id}-content", class: styles[:tabpanel_container][@vertical ? :vertical : :horizontal] do
      safe_join(@tabs_group.map.with_index { |tab, index| render_tabpanel(tab, index) })
    end
  end

  def render_tabpanel(tab, index)
    content_html = tab.props[:content_html] || {}
    add class: styles[:tabpanel][@vertical ? :vertical : :horizontal][@tab_panel][tab.props[:active] ? :active : :inactive], to: content_html, first_element: true

    content_html[:id] = "#{fx_id}-tabpanel-#{index}"
    content_html[:role] = "tabpanel"
    content_html[:"aria-labelledby"] = "#{fx_id}-#{index}"

    content_tag :div, tab.content, **content_html
  end
end
