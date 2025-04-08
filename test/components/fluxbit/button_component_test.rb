# frozen_string_literal: true

require "test_helper"

class Fluxbit::ButtonComponentTest < ViewComponent::TestCase
  # rendered_content
  include Fluxbit::Config::ButtonComponent

  def test_renders_button_with_default_styles
    render_inline(Fluxbit::ButtonComponent.new) { "Click me" }

    assert_selector "button", text: "Click me"
    assert_selector styled(:base)
    assert_selector styled(:colors, :default)
  end

  def test_applies_correct_size_class
    render_inline(Fluxbit::ButtonComponent.new(size: 4)) { "Click me" }

    assert_selector ".text-base"
  end

  def test_applies_pill_class_when_pill_is_true
    render_inline(Fluxbit::ButtonComponent.new(pill: true)) { "Click me" }

    assert_selector styled(:pill, :on)
  end

  def test_applies_outline_class_when_color_ends_with_outline
    render_inline(Fluxbit::ButtonComponent.new(color: "default_outline")) { "Click me" }

    assert_selector styled(:outline, :on)
  end

  def test_disables_button_when_disabled_is_true
    render_inline(Fluxbit::ButtonComponent.new(disabled: true)) { "Click me" }

    assert_selector styled(:disabled)
  end
end
