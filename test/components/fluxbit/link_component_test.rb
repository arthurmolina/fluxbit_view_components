# frozen_string_literal: true

require "test_helper"

class Fluxbit::LinkComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::LinkComponent

  def test_renders_link_with_default_styles
    render_inline(Fluxbit::LinkComponent.new) { "Click here" }

    assert_selector "a", text: "Click here"
    assert_selector styled(:base)
    assert_selector styled(:colors, :primary)
  end

  def test_renders_link_with_default_href
    render_inline(Fluxbit::LinkComponent.new) { "Click here" }

    assert_selector "a[href='#']"
  end

  def test_renders_link_with_custom_href
    render_inline(Fluxbit::LinkComponent.new(href: "/about")) { "About" }

    assert_selector "a[href='/about']", text: "About"
  end

  def test_renders_link_with_custom_color
    render_inline(Fluxbit::LinkComponent.new(color: :success)) { "Success Link" }

    assert_selector styled(:colors, :success)
    assert_selector "a", text: "Success Link"
  end

  def test_renders_link_with_danger_color
    render_inline(Fluxbit::LinkComponent.new(color: :danger)) { "Danger Link" }

    assert_selector styled(:colors, :danger)
    assert_selector "a", text: "Danger Link"
  end

  def test_renders_link_with_secondary_color
    render_inline(Fluxbit::LinkComponent.new(color: :secondary)) { "Secondary Link" }

    assert_selector styled(:colors, :secondary)
    assert_selector "a", text: "Secondary Link"
  end

  def test_renders_link_with_custom_html_attributes
    render_inline(Fluxbit::LinkComponent.new(id: "custom-link", target: "_blank", rel: "noopener")) { "External Link" }

    assert_selector "a#custom-link[target='_blank'][rel='noopener']", text: "External Link"
  end

  def test_renders_link_with_data_attributes
    render_inline(Fluxbit::LinkComponent.new(data: { turbo: false, action: "click->controller#method" })) { "Link" }

    assert_selector "a[data-turbo='false']"
    assert_selector "a[data-action='click->controller#method']"
  end

  def test_renders_link_with_custom_class
    render_inline(Fluxbit::LinkComponent.new(class: "custom-class")) { "Custom Link" }

    assert_selector "a.custom-class", text: "Custom Link"
  end

  def test_renders_link_with_removed_classes
    render_inline(Fluxbit::LinkComponent.new(remove_class: styles[:base])) { "Link without Base" }

    assert_no_selector styled(:base)
    assert_selector "a", text: "Link without Base"
  end

  def test_renders_link_with_all_color_options
    %i[default primary secondary success danger warning info light dark].each do |color|
      render_inline(Fluxbit::LinkComponent.new(color: color)) { "#{color.capitalize} Link" }

      assert_selector styled(:colors, color)
      assert_selector "a", text: "#{color.capitalize} Link"
    end
  end
end
