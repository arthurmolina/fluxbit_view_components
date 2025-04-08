# frozen_string_literal: true

require "test_helper"

class Fluxbit::TabComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::TabComponent

  def test_renders_tab_with_default_styles
    render_inline(Fluxbit::TabComponent.new) do |tab|
      tab.with_tab(title: "Tab 1") { "Content 1" }
      tab.with_tab(title: "Tab 2") { "Content 2" }
    end

    assert_selector styled(:tab_list, :ul, :horizontal)
    assert_selector styled(:tab_list, :tab_item, :base), text: "Tab 1"
    assert_selector styled(:tab_list, :tab_item, :base), text: "Tab 2"
    assert_selector styled(:tabpanel, :horizontal, :default, :active), text: "Content 1"
    assert_selector styled(:tabpanel, :horizontal, :default, :inactive), text: "Content 2"
  end

  def test_renders_tab_with_vertical_orientation
    render_inline(Fluxbit::TabComponent.new(vertical: true)) do |tab|
      tab.with_tab(title: "Tab 1") { "Content 1" }
      tab.with_tab(title: "Tab 2") { "Content 2" }
    end

    assert_selector styled(:div, :vertical)
    assert_selector styled(:tab_list, :ul, :vertical)
    assert_selector styled(:tabpanel_container, :vertical)
    assert_selector styled(:tabpanel, :vertical, :default, :active), text: "Content 1"
    assert_selector styled(:tabpanel, :vertical, :default, :inactive), text: "Content 2"
  end

  def test_renders_tab_with_custom_variant
    render_inline(Fluxbit::TabComponent.new(variant: :pills)) do |tab|
      tab.with_tab(title: "Tab 1") { "Content 1" }
    end

    assert_selector styled(:tab_list, :variant, :pills)
    assert_selector styled(:tab_list, :tab_item, :variant, :pills, :base), text: "Tab 1"
  end

  def test_renders_tab_with_active_tab
    render_inline(Fluxbit::TabComponent.new) do |tab|
      tab.with_tab(title: "Tab 1", active: true) { "Content 1" }
      tab.with_tab(title: "Tab 2") { "Content 2" }
    end

    assert_selector styled(:tab_list, :tab_item, :variant, :default, :active, :blue), text: "Tab 1"
    assert_selector styled(:tab_list, :tab_item, :variant, :default, :inactive), text: "Tab 2"
    assert_selector styled(:tabpanel, :horizontal, :default, :active), text: "Content 1"
    assert_selector styled(:tabpanel, :horizontal, :default, :inactive), text: "Content 2"
  end

  def test_renders_tab_with_disabled_tab
    render_inline(Fluxbit::TabComponent.new) do |tab|
      tab.with_tab(title: "Tab 1", disabled: true) { "Content 1" }
    end

    assert_selector styled(:tab_list, :tab_item, :variant, :default, :disabled), text: "Tab 1"
    assert_selector styled(:tabpanel, :horizontal, :default, :inactive), text: "Content 1"
  end

  def test_renders_tab_with_custom_color
    render_inline(Fluxbit::TabComponent.new(color: :blue)) do |tab|
      tab.with_tab(title: "Tab 1", active: true) { "Content 1" }
    end

    assert_selector styled(:tab_list, :tab_item, :variant, :default, :active, :blue), text: "Tab 1"
  end

  def test_renders_tab_with_custom_html_attributes
    render_inline(Fluxbit::TabComponent.new(id: "custom-id", class: "custom-class")) do |tab|
      tab.with_tab(title: "Tab 1") { "Content 1" }
    end

    assert_selector "#custom-id"
    assert_selector ".custom-class"
    assert_selector styled(:tab_list, :tab_item, :base), text: "Tab 1"
  end

  def test_renders_tab_with_removed_classes
    render_inline(Fluxbit::TabComponent.new(remove_class: styles[:div][:horizontal])) do |tab|
      tab.with_tab(title: "Tab 1") { "Content 1" }
    end

    assert_selector styled(:tab_list, :tab_item, :base), text: "Tab 1"
  end
end
