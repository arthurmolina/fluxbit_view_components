# frozen_string_literal: true

require "test_helper"

class Fluxbit::BadgeComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::BadgeComponent

  def test_renders_badge_with_default_styles
    render_inline(Fluxbit::BadgeComponent.new) { "Default Badge" }

    assert_selector styled(:base)
    assert_selector styled(:colors, :info)
    assert_selector "div", text: "Default Badge"
  end

  def test_renders_badge_with_custom_color
    render_inline(Fluxbit::BadgeComponent.new(color: :success)) { "Success Badge" }

    assert_selector styled(:colors, :success)
    assert_selector "div", text: "Success Badge"
  end

  def test_renders_badge_with_custom_size
    render_inline(Fluxbit::BadgeComponent.new(size: 1)) { "Sized Badge" }

    assert_selector styled(:sizes, 1)
    assert_selector "div", text: "Sized Badge"
  end

  def test_renders_badge_with_pill_shape
    render_inline(Fluxbit::BadgeComponent.new(pill: true)) { "Pill Badge" }

    assert_selector ".rounded-full"
    assert_selector "div", text: "Pill Badge"
  end

  def test_renders_badge_with_perfect_rounded
    render_inline(Fluxbit::BadgeComponent.new(as: :span, perfect_rounded: 3)) { "Rounded Badge" }

    assert_selector styled(:perfect_rounded, 3)
    assert_selector "span", text: "Rounded Badge"
  end

  def test_renders_badge_with_notification_classes
    render_inline(Fluxbit::BadgeComponent.new(notification: "top right")) { "Notification Badge" }

    assert_selector styled(:notification, :default)
    assert_selector styled(:notification, :positions, :top)
    assert_selector styled(:notification, :positions, :right)
    assert_selector "div", text: "Notification Badge"
  end

  def test_renders_badge_with_tooltip
    render_inline(Fluxbit::BadgeComponent.new(as: :span, tooltip_text: "Tooltip", tooltip_placement: :top)) { "Badge with Tooltip" }

    assert_selector "div", text: "Tooltip"
    assert_selector "[data-tooltip-placement=\"top\"]"
    assert_selector "span", text: "Badge with Tooltip"
  end

  def test_renders_badge_with_popover
    render_inline(Fluxbit::BadgeComponent.new(popover_text: "Popover", popover_placement: :bottom)) { "Badge with Popover" }

    assert_selector "div", text: "Popover"
    assert_selector "[data-popover-placement='bottom']"
    assert_selector "div", text: "Badge with Popover"
  end

  def test_renders_badge_with_custom_html_tag
    render_inline(Fluxbit::BadgeComponent.new(as: :div)) { "Div Badge" }

    assert_selector "div", text: "Div Badge"
  end

  def test_renders_badge_with_removed_classes
    render_inline(Fluxbit::BadgeComponent.new(remove_class: styles[:base])) { "Badge without Base Class" }

    assert_no_selector styled(:base)
    assert_selector "div", text: "Badge without Base Class"
  end
end
