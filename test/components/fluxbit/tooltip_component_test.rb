# frozen_string_literal: true

require "test_helper"

class Fluxbit::TooltipComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::TooltipComponent

  def test_renders_tooltip_with_default_styles
    render_inline(Fluxbit::TooltipComponent.new) { "Default Tooltip" }

    assert_selector styled(:base)
    assert_selector "[role='tooltip']"
    assert_selector "div", text: "Default Tooltip"
  end

  def test_renders_tooltip_with_arrow
    render_inline(Fluxbit::TooltipComponent.new(has_arrow: true)) { "Tooltip with Arrow" }

    assert_selector "[data-popper-arrow]"
    assert_selector "div", text: "Tooltip with Arrow"
  end

  def test_renders_tooltip_without_arrow
    render_inline(Fluxbit::TooltipComponent.new(has_arrow: false)) { "Tooltip without Arrow" }

    assert_no_selector "[data-popper-arrow]"
    assert_selector "div", text: "Tooltip without Arrow"
  end

  def test_renders_tooltip_with_custom_html_attributes
    render_inline(Fluxbit::TooltipComponent.new(id: "custom-id", class: "custom-class")) { "Hover me" }

    assert_selector "#custom-id"
    assert_selector ".custom-class"
    assert_selector "div", text: "Hover me"
  end

  def test_renders_tooltip_with_removed_classes
    render_inline(Fluxbit::TooltipComponent.new(remove_class: "absolute")) { "Hover me" }

    assert_no_selector "absolute"
    assert_selector "div", text: "Hover me"
  end
end
