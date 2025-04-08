# frozen_string_literal: true

require "test_helper"

class Fluxbit::HeadingComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::HeadingComponent

  def test_renders_heading_with_default_styles
    render_inline(Fluxbit::HeadingComponent.new) { "Default Heading" }

    assert_selector styled(:base)
    assert_selector styled(:sizes, :h1)
    assert_selector styled(:spacings, :tight)
    assert_selector styled(:line_heights, :none)
    assert_selector "h1", text: "Default Heading"
  end

  def test_renders_heading_with_custom_size
    render_inline(Fluxbit::HeadingComponent.new(size: 3)) { "Heading Level 3" }

    assert_selector styled(:sizes, :h3)
    assert_selector "h3", text: "Heading Level 3"
  end

  def test_renders_heading_with_custom_spacing
    render_inline(Fluxbit::HeadingComponent.new(spacing: :wider)) { "Heading with Wider Spacing" }

    assert_selector styled(:spacings, :wider)
    assert_selector "h1", text: "Heading with Wider Spacing"
  end

  def test_renders_heading_with_custom_line_height
    render_inline(Fluxbit::HeadingComponent.new(line_height: :relaxed)) { "Heading with Relaxed Line Height" }

    assert_selector styled(:line_heights, :relaxed)
    assert_selector "h1", text: "Heading with Relaxed Line Height"
  end

  def test_renders_heading_with_custom_html_attributes
    render_inline(Fluxbit::HeadingComponent.new(id: "custom-id", class: "custom-class")) { "Custom Heading" }

    assert_selector "#custom-id"
    assert_selector ".custom-class"
    assert_selector "h1", text: "Custom Heading"
  end

  def test_renders_heading_with_custom_combined_styles
    render_inline(Fluxbit::HeadingComponent.new(size: 2, spacing: :wide, line_height: :snug)) { "Custom Combined Heading" }

    assert_selector styled(:sizes, :h2)
    assert_selector styled(:spacings, :wide)
    assert_selector styled(:line_heights, :snug)
    assert_selector "h2", text: "Custom Combined Heading"
  end

  def test_renders_heading_with_removed_classes
    render_inline(Fluxbit::HeadingComponent.new(remove_class: styles[:base])) { "Heading without Base Class" }

    assert_no_selector styled(:base)
    assert_selector "h1", text: "Heading without Base Class"
  end
end
