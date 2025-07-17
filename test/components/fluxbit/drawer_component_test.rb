require "test_helper"

class Fluxbit::DrawerComponentTest < ViewComponent::TestCase
  def render_drawer(**options, &block)
    render_inline(Fluxbit::DrawerComponent.new(**options), &block)
  end

  test "renders with default options" do
    render_drawer { "Drawer content" }
    assert_selector "div.fixed.z-40.p-4"
    assert_text "Drawer content"
    assert_selector "button[aria-controls]"
  end

  test "renders with custom placement" do
    render_drawer(placement: :right) { "Right drawer" }
    assert_selector ".right-0"
    assert_text "Right drawer"
  end

  test "renders with custom sizing" do
    render_drawer(sizing: :lg) { "Large drawer" }
    assert_selector ".w-96"
  end

  test "renders without close button" do
    render_drawer(show_close_button: false) { "No close" }
    assert_no_selector "button[aria-controls]"
  end

  test "renders with swipeable option" do
    render_drawer(swipeable: true) { "Swipeable drawer" }
    assert_selector ".border-t"
    assert_no_selector "button[aria-controls]"
  end

  test "renders with shadow disabled" do
    render_drawer(shadow: false) { "No shadow" }
    assert_no_selector ".shadow-lg"
  end

  test "renders with backdrop disabled" do
    render_drawer(backdrop: false, data: { "fluxbit-drawer-target": "drawer" }) { "No backdrop" }
    # backdrop is a JS/Stimulus option, check data attribute
    assert_selector "[data-backdrop='false']"
  end

  test "renders with auto_show disabled" do
    render_drawer(auto_show: false, data: { controller: "fluxbit-drawer" }) { "No auto show" }
    assert_selector "[data-fluxbit-drawer-auto-show-value='false']"
  end

  test "renders with auto_show disabled, second way" do
    render_drawer(auto_show: false, data: { "fluxbit-drawer-target": "drawer" }) { "No auto show" }
    assert_selector "[data-auto-show='false']"
  end

  test "renders with body_scrolling enabled" do
    render_drawer(body_scrolling: true, data: { "fluxbit-drawer-target": "drawer" }) { "Body scrolling" }
    assert_selector "[data-body-scrolling='true']"
  end

  test "renders with edge_offset and swipeable" do
    render_drawer(swipeable: true, edge_offset: "60px", data: { "fluxbit-drawer-target": "drawer" }) { "Edge offset" }
    assert_selector "[data-edge-offset='60px']"
  end

  test "renders with custom backdrop_classes" do
    render_drawer(backdrop_classes: "custom-backdrop", data: { "fluxbit-drawer-target": "drawer" }) { "Backdrop classes" }
    assert_selector "[data-backdrop-classes='custom-backdrop']"
  end

  test "renders with header slot" do
    render_inline(Fluxbit::DrawerComponent.new) do |drawer|
      drawer.with_header { "Header Content" }
      "Drawer body"
    end
    assert_selector "h5", text: "Header Content"
    assert_text "Drawer body"
  end

  test "renders with stimulus data attributes" do
    render_drawer(data: { controller: "fluxbit-drawer", "fluxbit-drawer-target": "drawer-default" }) { "Stimulus drawer" }
    assert_selector "[data-controller='fluxbit-drawer']"
    assert_selector "[data-fluxbit-drawer-target='drawer-default']"
    assert_selector "[data-fluxbit-drawer-auto-show-value]"
    assert_selector "[data-fluxbit-drawer-placement-value]"
  end

  test "renders with non-stimulus data attributes" do
    render_drawer(data: { auto_show: true, placement: "left" }) { "Non-stimulus drawer" }
    assert_selector "[data-auto-show='true']"
    assert_selector "[data-placement='left']"
  end
end
