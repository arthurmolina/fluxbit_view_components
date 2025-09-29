# frozen_string_literal: true

require "test_helper"

class Fluxbit::BannerComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::BannerComponent

  def test_renders_banner_with_default_styles
    render_inline(Fluxbit::BannerComponent.new) { "Default Banner" }

    assert_selector styled(:base)
    assert_selector styled(:positions, :top)
    assert_selector styled(:colors, :info)
    assert_selector "div", text: "Default Banner"
  end

  def test_renders_banner_with_custom_color
    render_inline(Fluxbit::BannerComponent.new(color: :success)) { "Success Banner" }

    assert_selector styled(:colors, :success)
    assert_selector "div", text: "Success Banner"
  end

  def test_renders_banner_with_custom_position
    render_inline(Fluxbit::BannerComponent.new(position: :sticky_top)) { "Sticky Banner" }

    assert_selector styled(:positions, :sticky_top)
    assert_selector "div", text: "Sticky Banner"
  end

  def test_renders_banner_with_icon
    render_inline(Fluxbit::BannerComponent.new(icon: "check")) { "Banner with Icon" }

    assert_selector "svg"
    assert_selector "div", text: "Banner with Icon"
  end

  def test_renders_banner_without_icon
    render_inline(Fluxbit::BannerComponent.new(icon: false, dismissible: false)) { "Banner without Icon" }

    # Debug: puts rendered_content
    assert_no_selector "svg"
    assert_selector "div", text: "Banner without Icon"
  end

  def test_renders_banner_with_dismiss_button
    render_inline(Fluxbit::BannerComponent.new(dismissible: true)) { "Dismissible Banner" }

    assert_selector "button[aria-label='Close']"
    assert_selector "button[data-dismiss-target]"
    assert_selector "div", text: "Dismissible Banner"
  end

  def test_renders_banner_without_dismiss_button
    render_inline(Fluxbit::BannerComponent.new(dismissible: false)) { "Non-Dismissible Banner" }

    assert_no_selector "button[aria-label='Close']"
    assert_selector "div", text: "Non-Dismissible Banner"
  end

  def test_renders_banner_with_full_width
    render_inline(Fluxbit::BannerComponent.new(full_width: true)) { "Full Width Banner" }

    assert_selector ".w-full"
    assert_selector "div", text: "Full Width Banner"
  end

  def test_renders_banner_with_constrained_width
    render_inline(Fluxbit::BannerComponent.new(full_width: false)) { "Constrained Banner" }

    assert_selector ".max-w-screen-xl"
    assert_selector "div", text: "Constrained Banner"
  end

  def test_renders_banner_with_cta_button
    render_inline(Fluxbit::BannerComponent.new) do |component|
      component.with_cta_button(href: "#") { "Action" }
      "Banner with CTA"
    end

    assert_text "Action"
    assert_selector "div", text: "Banner with CTA"
  end

  def test_renders_banner_with_logo
    render_inline(Fluxbit::BannerComponent.new) do |component|
      component.with_logo(src: "logo.png", alt: "Logo")
      "Banner with Logo"
    end

    assert_selector "img[src='logo.png'][alt='Logo']"
    assert_selector "div", text: "Banner with Logo"
  end

  def test_renders_banner_with_custom_attributes
    render_inline(Fluxbit::BannerComponent.new("data-testid": "custom-banner")) { "Custom Banner" }

    assert_selector "[data-testid='custom-banner']"
    assert_selector "div", text: "Custom Banner"
  end

  def test_renders_banner_with_removed_classes
    render_inline(Fluxbit::BannerComponent.new(remove_class: "border-b")) { "Custom Classes Banner" }

    # Should have base classes but not the removed one
    assert_selector styled(:base).gsub(".border.border-b", ".border")
    assert_selector "div", text: "Custom Classes Banner"
  end

  def test_banner_generates_unique_id
    banner1 = Fluxbit::BannerComponent.new
    banner2 = Fluxbit::BannerComponent.new

    refute_equal banner1.instance_variable_get(:@props)["id"],
                 banner2.instance_variable_get(:@props)["id"]
  end

  def test_banner_respects_provided_id
    render_inline(Fluxbit::BannerComponent.new(id: "custom-id")) { "Banner with ID" }

    assert_selector "#custom-id"
    assert_selector "div", text: "Banner with ID"
  end
end
