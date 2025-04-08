# frozen_string_literal: true

require "test_helper"

class Fluxbit::PopoverComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::PopoverComponent

  def test_renders_popover_with_default_styles
    render_inline(Fluxbit::PopoverComponent.new) { "Default Popover Content" }

    assert_selector styled(:base)
    assert_selector styled(:size, 2)
    assert_selector "[data-popover='data-popover']"
    assert_selector "[role='tooltip']"
    assert_selector "div", text: "Default Popover Content"
  end

  def test_renders_popover_with_title
    render_inline(Fluxbit::PopoverComponent.new(title: "Popover Title")) { "Popover Content" }

    assert_selector styled(:title, :div)
    assert_selector styled(:title, :h3), text: "Popover Title"
    assert_selector "div", text: "Popover Content"
  end

  def test_renders_popover_with_arrow
    render_inline(Fluxbit::PopoverComponent.new(has_arrow: true)) { "Popover with Arrow" }

    assert_selector "[data-popper-arrow]"
    assert_selector "div", text: "Popover with Arrow"
  end

  def test_renders_popover_without_arrow
    render_inline(Fluxbit::PopoverComponent.new(has_arrow: false)) { "Popover without Arrow" }

    assert_no_selector "[data-popper-arrow]"
    assert_selector "div", text: "Popover without Arrow"
  end

  def test_renders_popover_with_custom_size
    render_inline(Fluxbit::PopoverComponent.new(size: 4)) { "Large Popover Content" }

    assert_selector styled(:size, 4)
    assert_selector "div", text: "Large Popover Content"
  end

  def test_renders_popover_with_image_on_left
    render_inline(Fluxbit::PopoverComponent.new(image: "https://example.com/image.jpg", image_position: :left)) { "Popover with Image" }

    assert_selector styled(:image_content, :image)
    assert_selector "img[src='https://example.com/image.jpg']"
    assert_selector styled(:image_content, :text), text: "Popover with Image"
  end

  def test_renders_popover_with_image_on_right
    render_inline(Fluxbit::PopoverComponent.new(image: "https://example.com/image.jpg", image_position: :right)) { "Popover with Image" }

    assert_selector styled(:image_content, :image)
    assert_selector "img[src='https://example.com/image.jpg']"
    assert_selector styled(:image_content, :text), text: "Popover with Image"
  end

  def test_renders_popover_with_removed_classes
    render_inline(Fluxbit::PopoverComponent.new(remove_class: styles[:base])) { "Popover without Base Class" }

    assert_no_selector styled(:base)
    assert_selector "div", text: "Popover without Base Class"
  end

  def test_renders_popover_with_custom_html_attributes
    render_inline(Fluxbit::PopoverComponent.new(id: "custom-id", class: "custom-class")) { "Custom Popover" }

    assert_selector "#custom-id"
    assert_selector ".custom-class"
    assert_selector "div", text: "Custom Popover"
  end
end
