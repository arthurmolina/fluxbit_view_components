# frozen_string_literal: true

require "test_helper"

class Fluxbit::BottomNavigationComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::BottomNavigationComponent

  def test_renders_bottom_navigation_with_default_styles
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/", icon: "heroicons_solid:home") { "Home" }
      nav.with_item(href: "/search", icon: "heroicons_solid:magnifying-glass") { "Search" }
    end

    assert_selector styled(:variants, :default, :base)
    assert_selector styled(:variants, :default, :border)
    assert_selector "button", count: 2
  end

  def test_renders_without_border
    render_inline(Fluxbit::BottomNavigationComponent.new(border: false)) do |nav|
      nav.with_item(href: "/") { "Home" }
    end

    assert_no_selector styled(:variants, :default, :border)
  end

  def test_auto_calculates_columns_based_on_item_count
    [2, 3, 4, 5].each do |cols|
      render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
        cols.times { |i| nav.with_item(href: "/#{i}") { "Item #{i}" } }
      end

      # Columns should auto-calculate based on item count
      assert_selector styled(:container, :columns, cols - 2)
    end
  end

  def test_renders_items_with_icons
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/", icon: "heroicons_solid:home") { "Home" }
    end

    assert_selector styled(:item, :icon_wrapper)
    assert_text "Home"
  end

  def test_renders_items_without_icons
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/") { "Home" }
    end

    assert_no_selector styled(:item, :icon_wrapper)
    assert_text "Home"
  end

  def test_renders_active_item
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/", active: true) { "Home" }
      nav.with_item(href: "/search") { "Search" }
    end

    buttons = page.all("button")
    assert buttons.first[:class].include?(styles[:item][:active].split.first)
    assert buttons.last[:class].include?(styles[:item][:inactive].split.first)
  end

  def test_renders_inactive_items_by_default
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/") { "Home" }
    end

    assert_selector styled(:item, :inactive)
  end

  def test_renders_with_custom_href
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/custom") { "Custom" }
    end

    assert_selector "button[data-href='/custom']"
  end

  def test_renders_with_default_href
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item { "Home" }
    end

    assert_selector "button[data-href='#']"
  end

  def test_renders_with_custom_html_attributes
    render_inline(Fluxbit::BottomNavigationComponent.new(id: "custom-nav", class: "custom-class")) do |nav|
      nav.with_item(href: "/") { "Home" }
    end

    assert_selector "#custom-nav.custom-class"
  end

  def test_renders_items_with_custom_classes
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/", class: "custom-item") { "Home" }
    end

    assert_selector "button.custom-item"
  end

  def test_renders_with_removed_classes
    render_inline(Fluxbit::BottomNavigationComponent.new(remove_class: styles[:variants][:default][:border])) do |nav|
      nav.with_item(href: "/") { "Home" }
    end

    assert_no_selector styled(:variants, :default, :border)
  end

  def test_auto_calculates_columns_with_single_item
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/") { "Home" }
      nav.with_item(href: "/search") { "Search" }
      nav.with_item(href: "/profile") { "Profile" }
    end

    assert_selector styled(:container, :base)
    # 3 items = grid-cols-3 (index 1)
    assert_selector styled(:container, :columns, 1)
  end

  def test_renders_item_text_with_correct_classes
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/") { "Home" }
    end

    assert_selector styled(:item, :text), text: "Home"
  end

  def test_renders_app_bar_variant
    render_inline(Fluxbit::BottomNavigationComponent.new(variant: :app_bar)) do |nav|
      nav.with_item(href: "/") { "Home" }
    end

    assert_selector styled(:variants, :app_bar, :base)
  end

  def test_renders_default_variant
    render_inline(Fluxbit::BottomNavigationComponent.new(variant: :default)) do |nav|
      nav.with_item(href: "/") { "Home" }
    end

    assert_selector styled(:variants, :default, :base)
  end

  def test_renders_with_cta_button
    component = Fluxbit::BottomNavigationComponent.new(variant: :app_bar)

    render_inline(component) do |nav|
      nav.with_item(href: "/", icon: "heroicons_solid:home") { "Home" }
      nav.with_item(href: "/wallet", icon: "heroicons_solid:wallet") { "Wallet" }
      nav.with_cta(href: "/new", icon: "heroicons_solid:plus") { "New" }
      nav.with_item(href: "/settings", icon: "heroicons_solid:cog-6-tooth") { "Settings" }
      nav.with_item(href: "/profile", icon: "heroicons_solid:user") { "Profile" }
    end

    # Test that we have items
    assert_selector "button", minimum: 4
    # 4 items + 1 CTA = 5 columns (index 3)
    assert_selector styled(:container, :columns, 3)
  end

  def test_items_have_sr_only_text_in_app_bar_variant
    render_inline(Fluxbit::BottomNavigationComponent.new(variant: :app_bar)) do |nav|
      nav.with_item(href: "/", icon: "heroicons_solid:home") { "Home" }
    end

    assert_selector styled(:item, :sr_only), text: "Home"
  end

  def test_items_have_visible_text_in_default_variant
    render_inline(Fluxbit::BottomNavigationComponent.new(variant: :default)) do |nav|
      nav.with_item(href: "/", icon: "heroicons_solid:home") { "Home" }
    end

    assert_selector styled(:item, :text), text: "Home"
    assert_no_selector styled(:item, :sr_only)
  end

  def test_items_with_tooltip_text
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/", icon: "heroicons_solid:home", tooltip_text: "Go to home") { "Home" }
    end

    assert_selector styled(:tooltip, :base), text: "Go to home"
  end

  def test_items_with_tooltip_have_data_attribute
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/", icon: "heroicons_solid:home", tooltip_text: "Go home") { "Home" }
    end

    # Test tooltip data attribute exists on item
    assert_selector "button[data-tooltip-target]"
  end

  def test_auto_calculates_columns_with_pagination
    render_inline(Fluxbit::BottomNavigationComponent.new) do |nav|
      nav.with_item(href: "/") { "Home" }
      nav.with_item(href: "/search") { "Search" }
      nav.with_pagination(current_page: 1, total_pages: 10)
      nav.with_item(href: "/profile") { "Profile" }
    end

    # 3 items + 2 for pagination (col-span-2) = 5 columns (index 3)
    assert_selector styled(:container, :columns, 3)
  end
end
