# frozen_string_literal: true

require "test_helper"

class Fluxbit::TextComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::TextComponent

  def test_renders_text_with_default_styles
    render_inline(Fluxbit::TextComponent.new) { "Default Text" }

    assert_selector "span", text: "Default Text"
  end

  def test_renders_text_with_custom_tag
    render_inline(Fluxbit::TextComponent.new(as: :div)) { "Custom Tag Text" }

    assert_selector "div", text: "Custom Tag Text"
  end

  def test_renders_text_with_custom_color
    render_inline(Fluxbit::TextComponent.new(color: :blue_to_green)) { "Primary Color Text" }

    assert_selector styled(:color, :blue_to_green)
    assert_selector "span", text: "Primary Color Text"
  end

  def test_renders_text_with_custom_bg_color
    render_inline(Fluxbit::TextComponent.new(bg_color: :blue_to_purple)) { "Primary Color Text" }

    assert_selector styled(:bg_color, :blue_to_purple)
    assert_selector "span", text: "Primary Color Text"
  end

  def test_renders_text_with_custom_size
    render_inline(Fluxbit::TextComponent.new(size: :lg)) { "Large Text" }

    assert_selector styled(:size, :lg)
    assert_selector "span", text: "Large Text"
  end

  def test_renders_text_with_custom_weight
    render_inline(Fluxbit::TextComponent.new(weight: :bold)) { "Bold Text" }

    assert_selector styled(:weight, :bold)
    assert_selector "span", text: "Bold Text"
  end

  def test_renders_text_with_custom_transformation
    render_inline(Fluxbit::TextComponent.new(transform: :uppercase)) { "Uppercase" }

    assert_selector styled(:transform, :uppercase)
    assert_selector "span", text: "Uppercase"
  end

  def test_renders_text_with_custom_decoration_line
    render_inline(Fluxbit::TextComponent.new(decoration_line: :underline)) { "Underline Text" }

    assert_selector styled(:decoration_line, :underline)
    assert_selector "span", text: "Underline Text"
  end

  def test_renders_text_with_custom_decoration_type
    render_inline(Fluxbit::TextComponent.new(decoration_type: :double)) { "Double decoration type" }

    assert_selector styled(:decoration_type, :double)
    assert_selector "span", text: "Double decoration type"
  end

  def test_renders_text_with_custom_html_attributes
    render_inline(Fluxbit::TextComponent.new(id: "custom-id", class: "custom-class")) { "Custom HTML Attributes Text" }

    assert_selector "#custom-id"
    assert_selector ".custom-class"
    assert_selector "span", text: "Custom HTML Attributes Text"
  end
end
