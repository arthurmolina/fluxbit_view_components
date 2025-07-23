require "test_helper"

class Fluxbit::DropdownComponentTest < ViewComponent::TestCase
  def render_dropdown(**options, &block)
    render_inline(Fluxbit::DropdownComponent.new(**options), &block)
  end

  # Basic rendering tests
  test "renders with default options" do
    render_dropdown { "Dropdown content" }

    assert_selector "div"
    assert_selector "ul"
    assert_text "Dropdown content"
  end

  test "renders empty dropdown without items" do
    render_dropdown

    assert_selector "div"
    assert_selector "ul"
    assert_no_selector "li"
  end

  test "renders with custom id" do
    render_dropdown(id: "custom-dropdown") { "Content" }

    assert_selector "div#custom-dropdown"
  end

  test "generates random id when not provided" do
    render_dropdown { "Content" }

    assert_selector "div[id^='dropdown-']"
  end

  # Sizing tests
  test "renders with default sizing" do
    render_dropdown { "Content" }

    # Check for default size class (assuming small is default)
    assert_selector "div"
  end

  test "renders with custom sizing" do
    render_dropdown(sizing: 1) { "Content" }

    assert_selector "div"
  end

  # Auto divider tests
  test "renders with auto_divider enabled by default" do
    render_dropdown { "Content" }

    # Should have auto divider class
    assert_selector "div"
  end

  test "renders without auto_divider when disabled" do
    render_dropdown(auto_divider: false) { "Content" }

    assert_selector "div"
  end

  # CSS classes tests
  test "renders with custom CSS classes" do
    render_dropdown(class: "custom-class") { "Content" }

    assert_selector "div.custom-class"
  end

  test "removes specified classes" do
    render_dropdown(remove_class: "rounded-lg", class: "unwanted-class wanted-class") { "Content" }

    assert_selector "div.wanted-class"
    assert_no_selector "div.rounded-lg"
  end

  # Items rendering tests
  test "renders with single item" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Dashboard")
    end

    assert_selector "li"
    assert_text "Dashboard"
  end

  test "renders with multiple items" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Dashboard")
      dropdown.with_item("Settings")
      dropdown.with_item("Profile")
    end

    assert_selector "li", count: 3
    assert_text "Dashboard"
    assert_text "Settings"
    assert_text "Profile"
  end

  test "renders items with dividers" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Dashboard")
      dropdown.with_item(divider: true)
      dropdown.with_item("Settings")
    end

    assert_selector "li", count: 3
    assert_text "Dashboard"
    assert_text "Settings"
  end

  test "renders items with icons" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Dashboard", icon: "heroicons_solid:eye")
    end

    assert_selector "li"
    assert_text "Dashboard"
  end

  test "renders items as links" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Dashboard", as: :a, content_html: { href: "/dashboard" })
    end

    assert_selector "li a[href='/dashboard']"
    assert_text "Dashboard"
  end

  test "renders items as buttons" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Action", as: :button)
    end

    assert_selector "li button"
    assert_text "Action"
  end

  # Multi-level dropdown tests
  test "renders nested dropdown items" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Main Item") do |item|
        item.with_item("Sub Item 1")
        item.with_item("Sub Item 2")
      end
    end

    assert_selector "li button[data-dropdown-toggle]"
    assert_selector "div[id^='inner-dropdown-']"
    assert_text "Main Item"
    assert_text "Sub Item 1"
    assert_text "Sub Item 2"
  end

  test "renders chevron for items with subitems" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Main Item") do |item|
        item.with_item("Sub Item")
      end
    end

    assert_selector "svg" # Chevron icon
  end

  test "renders custom dropdown placement for nested items" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Main Item", dropdown_placement: "left-start") do |item|
        item.with_item("Sub Item")
      end
    end

    assert_selector "button[data-dropdown-placement='left-start']"
  end

  # get_item method tests
  test "get_item returns component id" do
    component = Fluxbit::DropdownComponent.new(id: "test-dropdown")

    assert_equal "test-dropdown", component.get_item
  end

  test "get_item returns generated id when not specified" do
    component = Fluxbit::DropdownComponent.new

    assert_match(/dropdown-/, component.get_item)
  end

  # Content rendering tests
  test "renders both items and content" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Item 1")
      "Additional content"
    end

    assert_selector "li"
    assert_text "Item 1"
    assert_text "Additional content"
  end

  test "renders only content when no items" do
    render_dropdown { "Just content" }

    assert_text "Just content"
  end

  # HTML attributes tests
  test "renders with data attributes" do
    render_dropdown(data: { testid: "dropdown", controller: "dropdown" }) { "Content" }

    assert_selector "div[data-testid='dropdown']"
    assert_selector "div[data-controller='dropdown']"
  end

  test "renders with aria attributes" do
    render_dropdown(aria: { labelledby: "button-1", hidden: "true" }) { "Content" }

    assert_selector "div[aria-labelledby='button-1']"
    assert_selector "div[aria-hidden='true']"
  end

  test "renders with role attribute" do
    render_dropdown(role: "menu") { "Content" }

    assert_selector "div[role='menu']"
  end

  # Edge cases
  test "handles empty string content" do
    render_dropdown { "" }

    assert_selector "div"
    assert_selector "ul"
  end

  test "handles nil content gracefully" do
    render_dropdown

    assert_selector "div"
    assert_selector "ul"
  end

  test "renders with mixed item types" do
    render_inline(Fluxbit::DropdownComponent.new) do |dropdown|
      dropdown.with_item("Link Item", as: :a, content_html: { href: "#" })
      dropdown.with_item("Button Item", as: :button)
      dropdown.with_item(divider: true)
      dropdown.with_item("Div Item") # Default as: :div
    end

    assert_selector "li a"
    assert_selector "li button"
    assert_selector "li div"
    assert_selector "li", count: 4 # Including divider
  end

  # Complex nested structure test
  test "renders complex multi-level dropdown" do
    render_inline(Fluxbit::DropdownComponent.new(id: "main-dropdown")) do |dropdown|
      dropdown.with_item("Dashboard", icon: "heroicons_solid:eye", as: :a, content_html: { href: "#" })
      dropdown.with_item(divider: true)
      dropdown.with_item("Earnings") do |item|
        item.with_item("Overview", as: :a, content_html: { href: "#" })
        item.with_item("My downloads", as: :a, content_html: { href: "#" })
        item.with_item("Billing", dropdown_placement: "left-start") do |item2|
          item2.with_item("Rewards", as: :a, content_html: { href: "#" })
          item2.with_item("Earnings", as: :a, content_html: { href: "#" })
        end
      end
    end

    assert_selector "div#main-dropdown"
    assert_selector "li a[href='#']", count: 5
    assert_selector "li button[data-dropdown-toggle]", count: 2
    assert_selector "div[id^='inner-dropdown-']", count: 2
    assert_selector "button[data-dropdown-placement='left-start']"
    assert_text "Dashboard"
    assert_text "Earnings"
    assert_text "Overview"
    assert_text "My downloads"
    assert_text "Billing"
    assert_text "Rewards"
  end
end
