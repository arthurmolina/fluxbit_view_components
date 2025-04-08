# frozen_string_literal: true

require "test_helper"

class Fluxbit::AlertComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::AlertComponent

  def test_renders_alert_with_default_styles
    render_inline(Fluxbit::AlertComponent.new) { "Default Alert" }

    assert_selector styled(:base)
    assert_selector styled(:colors, :info)
    assert_selector "div[role='alert']", text: "Default Alert"
  end

  def test_renders_alert_with_custom_color
    render_inline(Fluxbit::AlertComponent.new(color: :success)) { "Success Alert" }

    assert_selector styled(:colors, :success)
    assert_selector "div[role='alert']", text: "Success Alert"
  end

  def test_renders_alert_with_icon
    render_inline(Fluxbit::AlertComponent.new(icon: "check")) { "Alert with Icon" }

    assert_selector "svg"
    assert_selector "div", text: "Alert with Icon"
  end

  def test_renders_alert_with_close_button
    render_inline(Fluxbit::AlertComponent.new(can_close: true)) { "Closable Alert" }

    assert_selector styled(:close_button, :base)
    assert_selector styled(:close_button, :colors, :info)
    assert_selector "button[aria-label='Close']"
  end

  def test_renders_alert_without_close_button
    render_inline(Fluxbit::AlertComponent.new(can_close: false)) { "Non-Closable Alert" }

    assert_no_selector "button[aria-label='Close']"
    assert_selector "div", text: "Non-Closable Alert"
  end

  def test_renders_alert_with_rounded_corners
    render_inline(Fluxbit::AlertComponent.new(all_rounded: true)) { "Rounded Alert" }

    assert_selector styled(:all_rounded, :on)
  end

  def test_renders_alert_with_square_corners
    render_inline(Fluxbit::AlertComponent.new(all_rounded: false)) { "Square Alert" }

    assert_selector styled(:all_rounded, :off)
  end

  def test_renders_alert_with_fade_in_animation
    render_inline(Fluxbit::AlertComponent.new(fade_in_animation: true)) { "Animated Alert" }

    assert_selector "[data-transition-enter-from='opacity-0']"
    assert_selector "[data-transition-enter-to='opacity-100']"
  end

  def test_renders_alert_without_fade_in_animation
    render_inline(Fluxbit::AlertComponent.new(fade_in_animation: false)) { "Non-Animated Alert" }

    assert_selector "[data-transition-enter-from='opacity-100']"
    assert_selector "[data-transition-enter-to='opacity-100']"
  end

  def test_renders_alert_with_dismiss_timeout
    render_inline(Fluxbit::AlertComponent.new(dismiss_timeout: 5000)) { "Timed Alert" }

    assert_selector "[data-notification-delay-value='5000']"
    assert_selector "[data-controller='notification']"
    assert_selector "[data-action='notification#hide']"
  end

  def test_renders_alert_without_dismiss_timeout
    render_inline(Fluxbit::AlertComponent.new(dismiss_timeout: 0)) { "Persistent Alert" }

    assert_no_selector "[data-notification-delay-value]"
    assert_selector "div", text: "Persistent Alert"
  end
end
