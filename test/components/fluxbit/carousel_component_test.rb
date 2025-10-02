# frozen_string_literal: true

require "test_helper"

class Fluxbit::CarouselComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::CarouselComponent

  def test_renders_carousel_with_default_styles
    render_inline(Fluxbit::CarouselComponent.new) do |carousel|
      carousel.with_slide { "Slide 1" }
      carousel.with_slide { "Slide 2" }
      carousel.with_slide { "Slide 3" }
    end

    assert_selector styled(:base)
    assert_selector styled(:slides_container)
    assert_selector "div[data-carousel='slide']"
    assert_selector "div[data-carousel-item]", count: 3
  end

  def test_renders_carousel_with_slides
    render_inline(Fluxbit::CarouselComponent.new) do |carousel|
      carousel.with_slide { "First Slide" }
      carousel.with_slide { "Second Slide" }
    end

    assert_text "First Slide"
    assert_text "Second Slide"
    assert_selector styled(:slide, :base), count: 2
  end

  def test_renders_carousel_with_indicators_enabled
    render_inline(Fluxbit::CarouselComponent.new(indicators: true)) do |carousel|
      carousel.with_slide { "Slide 1" }
      carousel.with_slide { "Slide 2" }
      carousel.with_slide { "Slide 3" }
    end

    assert_selector styled(:indicators, :container)
    assert_selector "button[aria-label*='Slide']", count: 3
  end

  def test_renders_carousel_without_indicators
    render_inline(Fluxbit::CarouselComponent.new(indicators: false)) do |carousel|
      carousel.with_slide { "Slide 1" }
      carousel.with_slide { "Slide 2" }
    end

    assert_no_selector styled(:indicators, :container)
  end

  def test_renders_carousel_with_controls_enabled
    render_inline(Fluxbit::CarouselComponent.new(controls: true)) do |carousel|
      carousel.with_slide { "Slide 1" }
      carousel.with_slide { "Slide 2" }
    end

    assert_selector "button[data-carousel-prev]"
    assert_selector "button[data-carousel-next]"
  end

  def test_renders_carousel_without_controls
    render_inline(Fluxbit::CarouselComponent.new(controls: false)) do |carousel|
      carousel.with_slide { "Slide 1" }
      carousel.with_slide { "Slide 2" }
    end

    assert_no_selector "button[data-carousel-prev]"
    assert_no_selector "button[data-carousel-next]"
  end

  def test_renders_carousel_with_slide_disabled
    render_inline(Fluxbit::CarouselComponent.new(slide: false)) do |carousel|
      carousel.with_slide { "Slide 1" }
    end

    assert_selector "div[data-carousel='static']"
  end

  def test_renders_carousel_with_slide_enabled
    render_inline(Fluxbit::CarouselComponent.new(slide: true)) do |carousel|
      carousel.with_slide { "Slide 1" }
    end

    assert_selector "div[data-carousel='slide']"
  end

  def test_renders_carousel_with_custom_controls
    render_inline(Fluxbit::CarouselComponent.new(
      left_control: "Previous",
      right_control: "Next"
    )) do |carousel|
      carousel.with_slide { "Slide 1" }
      carousel.with_slide { "Slide 2" }
    end

    assert_text "Previous"
    assert_text "Next"
  end

  def test_renders_carousel_with_custom_html_attributes
    render_inline(Fluxbit::CarouselComponent.new(id: "custom-carousel", class: "custom-class")) do |carousel|
      carousel.with_slide { "Slide 1" }
    end

    assert_selector "#custom-carousel"
    assert_selector ".custom-class"
  end

  def test_renders_carousel_with_removed_classes
    render_inline(Fluxbit::CarouselComponent.new(remove_class: styles[:base])) do |carousel|
      carousel.with_slide { "Slide 1" }
    end

    assert_selector "div[data-carousel='slide']"
  end

  def test_first_slide_is_visible_by_default
    render_inline(Fluxbit::CarouselComponent.new) do |carousel|
      carousel.with_slide { "Slide 1" }
      carousel.with_slide { "Slide 2" }
      carousel.with_slide { "Slide 3" }
    end

    # The first slide should have data-carousel-item="active"
    assert_selector "div[data-carousel-item='active']", count: 1

    # All slides should have data-carousel-item attribute
    assert_selector "div[data-carousel-item]", count: 3

    # Other slides should have the hidden class
    slides = page.all("div[data-carousel-item]")
    slides[1..-1].each do |slide|
      assert slide[:class].include?("hidden")
    end
  end
end
