require "test_helper"

class Fluxbit::SpeedDialComponentTest < ViewComponent::TestCase
  def render_speed_dial(**options, &block)
    render_inline(Fluxbit::SpeedDialComponent.new(**options), &block)
  end

  # Basic rendering tests
  test "renders with default options" do
    render_speed_dial

    assert_selector "div[data-dial-init]"
    assert_selector "div[id$='-menu']"
    assert_selector "button[data-dial-toggle]"
  end

  test "renders with custom id" do
    render_speed_dial(id: "custom-speed-dial")

    assert_selector "div#custom-speed-dial"
    assert_selector "div#custom-speed-dial-menu"
    assert_selector "button[data-dial-toggle='custom-speed-dial-menu']"
  end

  test "generates random id when not provided" do
    render_speed_dial

    assert_selector "div[id^='speed-dial-']"
    assert_selector "div[id$='-menu']"
  end

  # Position tests
  test "renders with default bottom_right position" do
    render_speed_dial

    assert_selector "div.bottom-6.end-6"
  end

  test "renders with top_left position" do
    render_speed_dial(position: :top_left)

    assert_selector "div.top-6.start-6"
  end

  test "renders with top_right position" do
    render_speed_dial(position: :top_right)

    assert_selector "div.top-6.end-6"
  end

  test "renders with bottom_left position" do
    render_speed_dial(position: :bottom_left)

    assert_selector "div.bottom-6.start-6"
  end

  # Shape tests
  test "renders with default rounded shape" do
    render_speed_dial

    assert_selector "button.rounded-full"
    assert_no_selector "button.rounded-lg"
  end

  test "renders with square shape" do
    render_speed_dial(square: true)

    assert_selector "button.rounded-lg"
    assert_no_selector "button.rounded-full"
  end

  # Trigger icon tests
  test "renders with default plus icon" do
    render_speed_dial

    assert_selector "button svg"
  end

  test "renders with custom trigger icon" do
    render_speed_dial(trigger_icon: "heroicons_solid:x-mark")

    assert_selector "button svg"
  end

  # Accessibility tests
  test "includes proper accessibility attributes" do
    render_speed_dial

    assert_selector "button[aria-controls]"
    assert_selector "button[aria-expanded='false']"
    assert_selector "span.sr-only"
    assert_text "Open actions menu"
  end

  # CSS classes tests
  test "renders with custom CSS classes" do
    render_speed_dial(class: "custom-class")

    assert_selector "div.custom-class"
  end

  test "removes specified classes" do
    render_speed_dial(remove_class: "z-50", class: "z-50 wanted-class")

    assert_selector "div.wanted-class"
    assert_no_selector "div.z-50"
  end

  # Action items tests
  test "renders with no actions" do
    render_speed_dial

    assert_selector "div[id$='-menu'].hidden"
    assert_no_selector "button[data-tooltip-target]"
  end

  test "renders with single action" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", text: "Add", tooltip: "Add new item")
    end

    assert_selector "div[id$='-menu'] button[data-tooltip-target]"
    assert_selector "div[role='tooltip']"
    assert_text "Add new item"
  end

  test "renders with multiple actions" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", text: "Add", tooltip: "Add item")
      speed_dial.with_action(icon: "heroicons_solid:pencil", text: "Edit", tooltip: "Edit item")
      speed_dial.with_action(icon: "heroicons_solid:trash", text: "Delete", tooltip: "Delete item")
    end

    assert_selector "div[id$='-menu'] button[data-tooltip-target]", count: 3
    assert_selector "div[role='tooltip']", count: 3
    assert_text "Add item"
    assert_text "Edit item"
    assert_text "Delete item"
  end

  test "renders action as link when href provided" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", text: "Add", href: "/add")
    end

    assert_selector "div[id$='-menu'] a[href='/add']"
    assert_no_selector "div[id$='-menu'] button[type='button']"
  end

  test "renders action as button by default" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", text: "Add")
    end

    assert_selector "div[id$='-menu'] button[type='button']"
    assert_no_selector "div[id$='-menu'] a"
  end

  # Text outside tests
  test "renders with text_outside disabled by default" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", text: "Add")
    end

    assert_no_selector "span.text-sm.font-medium"
  end

  test "renders with text_outside enabled" do
    render_inline(Fluxbit::SpeedDialComponent.new(text_outside: true)) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", text: "Add")
    end

    assert_selector "span.text-sm.font-medium"
    assert_text "Add"
  end

  # Tooltip tests
  test "renders tooltip with default placement" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", tooltip: "Add item")
    end

    assert_selector "button[data-tooltip-placement='left']"
  end

  test "uses text as tooltip when tooltip not specified" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", text: "Add item")
    end

    assert_selector "div[role='tooltip']"
    assert_text "Add item"
  end

  # HTML attributes tests
  test "renders with data attributes" do
    render_speed_dial(data: { testid: "speed-dial", controller: "speed-dial" })

    assert_selector "div[data-testid='speed-dial']"
    assert_selector "div[data-controller='speed-dial']"
  end

  test "renders with aria attributes" do
    render_speed_dial(aria: { label: "Speed dial actions" })

    assert_selector "div[aria-label='Speed dial actions']"
  end

  test "renders action with custom attributes" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(
        icon: "heroicons_solid:plus",
        text: "Add",
        data: { action: "add-item" },
        class: "custom-action-class"
      )
    end

    assert_selector "button[data-action='add-item'].custom-action-class"
  end

  # Complex composition tests
  test "renders complex speed dial with mixed actions" do
    render_inline(Fluxbit::SpeedDialComponent.new(
      id: "complex-speed-dial",
      position: :top_right,
      square: true,
      text_outside: true,
      trigger_icon: "heroicons_solid:ellipsis-vertical"
    )) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", text: "Add", tooltip: "Add new item", href: "/add")
      speed_dial.with_action(icon: "heroicons_solid:pencil", text: "Edit", tooltip: "Edit item", data: { action: "edit" })
      speed_dial.with_action(icon: "heroicons_solid:trash", text: "Delete", tooltip: "Delete item", class: "text-red-600")
    end

    # Container tests
    assert_selector "div#complex-speed-dial.top-6.end-6"
    assert_selector "button.rounded-lg"
    assert_selector "div#complex-speed-dial-menu"

    # Actions tests
    assert_selector "a[href='/add']"
    assert_selector "button[data-action='edit']"
    assert_selector "button.text-red-600"

    # Text outside tests
    assert_selector "span.text-sm.font-medium", count: 3

    # Tooltips tests
    assert_selector "div[role='tooltip']", count: 3
    assert_text "Add new item"
    assert_text "Edit item"
    assert_text "Delete item"
  end

  # Edge cases
  test "handles empty actions gracefully" do
    render_speed_dial

    assert_selector "div[data-dial-init]"
    assert_selector "div[id$='-menu'].hidden"
    assert_selector "button[data-dial-toggle]"
  end

  test "handles action without icon" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(text: "Text Only")
    end

    assert_selector "button"
    assert_no_selector "div[id$='-menu'] svg"
    assert_text "Text Only"
  end

  test "handles action without text or tooltip" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus")
    end

    assert_selector "button"
    assert_no_selector "button[data-tooltip-target]"
    assert_no_selector "div[role='tooltip']"
  end

  # Menu structure tests
  test "menu has proper structure and classes" do
    render_inline(Fluxbit::SpeedDialComponent.new) do |speed_dial|
      speed_dial.with_action(icon: "heroicons_solid:plus", text: "Add")
    end

    assert_selector "div[id$='-menu'].flex.flex-col.items-center.mb-4.space-y-2.hidden"
  end

  test "trigger button has proper data attributes" do
    render_speed_dial(id: "test-dial")

    assert_selector "button[data-dial-toggle='test-dial-menu']"
    assert_selector "button[aria-controls='test-dial-menu']"
  end
end
