# frozen_string_literal: true

require "test_helper"

class Fluxbit::BreadcrumbComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::BreadcrumbComponent

  test "render nav with default aria-label and <ol> with list class" do
    render_inline(Fluxbit::BreadcrumbComponent.new) do |c|
      c.with_item(href: "/") { "Home" }
    end

    assert_selector 'nav[aria-label="Breadcrumb"]'
    assert_selector styled(:root, :list)
  end

  test "allows overriding the aria-label of the nav" do
    render_inline(Fluxbit::BreadcrumbComponent.new("aria-label" => "Trail")) do |c|
      c.with_item(href: "/") { "Home" }
    end

    assert_selector 'nav[aria-label="Trail"]'
  end

  test "render items as links when there is an href" do
    render_inline(Fluxbit::BreadcrumbComponent.new) do |c|
      c.with_item(href: "/") { "Home" }
      c.with_item(href: "/projects") { "Projects" }
    end

    assert_selector "a#{styled(:item, :href, :on)}", text: "Home"
    assert_selector "a#{styled(:item, :href, :on)}", text: "Projects"
    assert_selector "a[href='/']", text: "Home"
    assert_selector "a[href='/projects']", text: "Projects"
  end

  test "render current item as <spam> without link when current_page: true" do
    render_inline(Fluxbit::BreadcrumbComponent.new) do |c|
      c.with_item(href: "/") { "Home" }
      c.with_item(current_page: true) { "Current Page" }
    end

    assert_selector "li#{styled(:item, :base)} span#{styled(:item, :href, :off)}", text: "Current Page"
    refute_selector "li#{styled(:item, :base)} a", text: "Current Page"
  end

  test "renders the item's icon when :icon is given" do
    render_inline(Fluxbit::BreadcrumbComponent.new) do |c|
      c.with_item(href: "/", icon: "heroicons_solid:home") { "Home" }
    end

    assert_selector "li#{styled(:item, :base)} #{styled(:item, :icon)}"
  end

  test "renders the separator (chevron-right) for subsequent items" do
    render_inline(Fluxbit::BreadcrumbComponent.new) do |c|
      c.with_item(href: "/") { "Home" }
      c.with_item(href: "/projects") { "Projects" }
    end

    # Ao menos um separador deve existir
    assert_selector "li#{styled(:item, :base)} #{styled(:item, :chevron)}"
  end

  test "merges extra classes into the item (propagated to <a> or <span>)" do
    render_inline(Fluxbit::BreadcrumbComponent.new) do |c|
      c.with_item(href: "/", class: "extra-class") { "Home" }
      c.with_item(current_page: true, class: "extra-class") { "Current" }
    end

    assert_selector "a#{styled(:item, :href, :on)}.extra-class", text: "Home"
    assert_selector "span#{styled(:item, :href, :off)}.extra-class", text: "Current"
  end

  test "with dropdown: adds data-dropdown-toggle and includes the dropdown in the HTML" do
    render_inline(Fluxbit::BreadcrumbComponent.new) do |c|
      c.with_item(href: "/projects") do |item|
        item.with_dropdown(id: "menu-1")
        "Projects"
      end
    end

    assert_selector "a#{styled(:item, :href, :on)}[data-dropdown-toggle='menu-1']", text: "Projects"
    assert_selector "#menu-1"
  end

  test "with dropdown: adds chevron-down (class ms-3) when remove_dropdown_arrow is false" do
    render_inline(Fluxbit::BreadcrumbComponent.new) do |c|
      c.with_item(href: "/projects") do |item|
        item.with_dropdown(id: "menu-2")
        "Projects"
      end
    end

    assert_selector "li#{styled(:item, :base)} .ms-3"
    assert_selector "a#{styled(:item, :href, :on)}#{styled(:item, :click_cursor)}", text: "Projects"
  end

  test "with dropdown: does not add chevron-down when remove_dropdown_arrow: true" do
    render_inline(Fluxbit::BreadcrumbComponent.new) do |c|
      c.with_item(href: "/projects", remove_dropdown_arrow: true) do |item|
        item.with_dropdown(id: "menu-3")
        "Projects"
      end
    end

    refute_selector "li#{styled(:item, :base)} .ms-3"
    assert_selector "a#{styled(:item, :href, :on)}[data-dropdown-toggle='menu-3']", text: "Projects"
  end
end
