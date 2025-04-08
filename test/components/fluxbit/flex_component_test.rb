# frozen_string_literal: true

require "test_helper"

class Fluxbit::FlexComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::FlexComponent

  def test_renders_flex_with_default_styles
    render_inline(Fluxbit::FlexComponent.new) { "Default Flex" }

    assert_selector styled(:base)
    assert_no_selector styled(:direction, :horizontal)
    assert_no_selector styled(:justify_content, :center)
    assert_no_selector styled(:align_items, :center)
    assert_selector "div", text: "Default Flex"
  end

  def test_renders_flex_with_vertical_direction
    render_inline(Fluxbit::FlexComponent.new(vertical: true)) { "Vertical Flex" }

    assert_selector styled(:direction, :vertical)
    assert_selector "div", text: "Vertical Flex"
  end

  def test_renders_flex_with_reverse_true_but_no_direction_defined
    render_inline(Fluxbit::FlexComponent.new(reverse: true)) { "Reversed Flex" }

    assert_no_selector styled(:direction, :horizontal_reverse)
    assert_selector "div", text: "Reversed Flex"
  end

  def test_renders_flex_with_wrap
    render_inline(Fluxbit::FlexComponent.new(wrap: true)) { "Wrapped Flex" }

    assert_selector styled(:wrap, :wrap)
    assert_selector "div", text: "Wrapped Flex"
  end

  def test_renders_flex_with_wrap_reverse
    render_inline(Fluxbit::FlexComponent.new(wrap: true, wrap_reverse: true)) { "Wrap Reverse Flex" }

    assert_selector styled(:wrap, :wrap_reverse)
    assert_selector "div", text: "Wrap Reverse Flex"
  end

  def test_renders_flex_with_custom_justify_content
    render_inline(Fluxbit::FlexComponent.new(justify_content: :space_between)) { "Justified Flex" }

    assert_selector styled(:justify_content, :space_between)
    assert_selector "div", text: "Justified Flex"
  end

  def test_renders_flex_with_custom_align_items
    render_inline(Fluxbit::FlexComponent.new(align_items: :stretch)) { "Aligned Flex" }

    assert_selector styled(:align_items, :stretch)
    assert_selector "div", text: "Aligned Flex"
  end

  def test_renders_flex_with_gap
    render_inline(Fluxbit::FlexComponent.new(gap: 4)) { "Flex with Gap" }

    assert_selector styled(:gap, 4)
    assert_selector "div", text: "Flex with Gap"
  end

  def test_renders_flex_with_responsive_styles
    render_inline(Fluxbit::FlexComponent.new(sm: { vertical: true, gap: 2 }, lg: { justify_content: :space_around })) { "Responsive Flex" }

    assert_selector ".sm\\:flex-col"
    assert_selector ".sm\\:gap-4"
    assert_selector ".lg\\:justify-around"
    assert_selector "div", text: "Responsive Flex"
  end
end
