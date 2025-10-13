# frozen_string_literal: true

require "test_helper"

class Fluxbit::ThemeButtonComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::ThemeButtonComponent

  def test_renders_theme_button_with_default_styles
    render_inline(Fluxbit::ThemeButtonComponent.new)

    assert_selector "button"
    assert_selector styled(:base)
    assert_selector styled(:pill, :on)
  end

  def test_has_stimulus_controller_attached
    render_inline(Fluxbit::ThemeButtonComponent.new)

    assert_selector "button[data-controller*='fx-theme-button']"
    assert_selector "button[data-action*='click->fx-theme-button#toggle']"
  end

  def test_renders_all_three_theme_icons
    render_inline(Fluxbit::ThemeButtonComponent.new)

    # Should have targets for all three theme icons
    assert_selector "[data-fx-theme-button-target='lightIcon']"
    assert_selector "[data-fx-theme-button-target='darkIcon']"
    assert_selector "[data-fx-theme-button-target='systemIcon']"
  end

  def test_applies_correct_size_class
    render_inline(Fluxbit::ThemeButtonComponent.new(size: 4))

    assert_selector ".text-base"
  end

  def test_default_color_is_transparent
    render_inline(Fluxbit::ThemeButtonComponent.new)

    assert_selector styled(:colors, :transparent)
  end

  def test_applies_custom_color
    render_inline(Fluxbit::ThemeButtonComponent.new(color: :info))

    assert_selector styled(:colors, :info)
  end

  def test_is_round_by_default
    render_inline(Fluxbit::ThemeButtonComponent.new)

    assert_selector styled(:pill, :on)
  end

  def test_can_override_pill_setting
    render_inline(Fluxbit::ThemeButtonComponent.new(pill: false))

    assert_selector styled(:pill, :off)
  end

  def test_supports_tooltip
    render_inline(Fluxbit::ThemeButtonComponent.new(
      tooltip_text: "Toggle theme",
      tooltip_placement: :bottom
    ))

    assert_selector "button[data-tooltip-target]"
    assert_selector "button[data-tooltip-placement='bottom']"
  end

  def test_supports_custom_classes
    render_inline(Fluxbit::ThemeButtonComponent.new(class: "custom-class"))

    assert_selector "button.custom-class"
  end

  def test_inherits_button_component_functionality
    # Verify that ThemeButtonComponent inherits from ButtonComponent
    assert Fluxbit::ThemeButtonComponent < Fluxbit::ButtonComponent
  end
end
