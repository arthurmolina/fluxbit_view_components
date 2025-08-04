require "test_helper"

class Fluxbit::Form::ToggleComponentTest < ViewComponent::TestCase
  def test_renders_default_toggle
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "notify"))
    assert_selector "input[type='checkbox'][name='notify'].sr-only.peer"
    assert_selector "span"
  end

  def test_renders_with_label
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "terms", label: "Accept terms"))
    assert_text "Accept terms"
  end

  def test_renders_with_other_label
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "status", label: "Label", other_label: "Other label"))
    assert_text "Other label"
  end

  def test_renders_with_invert_label
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "active", label: "Active", invert_label: true))
    assert_selector ".ms-3"
    assert_text "Active"
  end

  def test_renders_with_help_text
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "visible", help_text: "Will be shown"))
    assert_text "Will be shown"
  end

  def test_renders_disabled
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "promo", disabled: true))
    assert_selector "input[disabled]"
    assert_selector ".opacity-50"
  end

  def test_renders_with_custom_color
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "danger", color: :danger))
    assert_selector "span", class: /bg-red-600|peer-checked:bg-red-600/
  end

  def test_renders_with_unchecked_color
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "info", unchecked_color: :info))
    assert_selector "span", class: /bg-cyan-600/
  end

  def test_renders_with_button_color
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "special", button_color: :success))
    assert_selector "span", class: /after:bg-green-500/
  end

  def test_renders_with_custom_sizing
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "huge", sizing: 2))
    assert_selector "span.w-14.h-7"
  end

  def test_renders_with_custom_class
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "tag", class: "toggle-custom"))
    assert_selector "input.toggle-custom"
  end
end
