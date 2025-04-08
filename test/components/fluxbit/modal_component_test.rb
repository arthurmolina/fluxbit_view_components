# frozen_string_literal: true

require "test_helper"

class Fluxbit::ModalComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::ModalComponent

  def test_renders_modal_with_default_styles
    render_inline(Fluxbit::ModalComponent.new) { "Default Modal Content" }

    assert_selector styled(:root, :base)
    assert_selector styled(:root, :show, :off)
    assert_selector styled(:content, :base)
    assert_selector "div", text: "Default Modal Content"
  end

  def test_renders_modal_with_custom_size
    render_inline(Fluxbit::ModalComponent.new(size: 3)) { "Sized Modal Content" }

    assert_selector styled(:root, :size, 3)
    assert_selector "div", text: "Sized Modal Content"
  end

  def test_renders_modal_with_custom_placement
    render_inline(Fluxbit::ModalComponent.new(placement: :"top-left")) { "Top Modal Content" }

    assert_selector "[data-modal-placement=\"top-left\"]"
    assert_selector "div", text: "Top Modal Content"
  end

  def test_renders_modal_with_flat_style
    render_inline(Fluxbit::ModalComponent.new(flat: true)) { "Flat Modal Content" }

    assert_selector styled(:body, :flat)
    assert_selector "div", text: "Flat Modal Content"
  end

  def test_renders_modal_with_title
    render_inline(Fluxbit::ModalComponent.new(title: "Modal Title")) { "Modal Content" }

    assert_selector styled(:header, :title), text: "Modal Title"
    assert_selector "div", text: "Modal Content"
  end

  def test_renders_modal_with_close_button
    render_inline(Fluxbit::ModalComponent.new(close_button: true)) { "Modal Content with Close Button" }

    assert_selector styled(:header, :close, :base)
    assert_selector "button[aria-label='Close']"
    assert_selector "div", text: "Modal Content with Close Button"
  end

  def test_renders_modal_without_close_button
    render_inline(Fluxbit::ModalComponent.new(close_button: false)) { "Modal Content without Close Button" }

    assert_no_selector styled(:header, :close, :base)
    assert_selector "div", text: "Modal Content without Close Button"
  end

  def test_renders_modal_with_static_backdrop
    render_inline(Fluxbit::ModalComponent.new(static: true)) { "Static Modal Content" }

    assert_selector "[data-modal-backdrop='static']"
    assert_selector "div", text: "Static Modal Content"
  end

  def test_renders_modal_with_only_css_closing
    render_inline(Fluxbit::ModalComponent.new(only_css: true)) { "CSS Modal Content" }

    assert_selector styled(:root, :backdrop)
    assert_selector styled(:root, :placements, :center)
    assert_selector "div", text: "CSS Modal Content"
  end

  def test_renders_modal_with_custom_footer
    render_inline(Fluxbit::ModalComponent.new) do |modal|
      modal.with_footer { "Custom Footer Content" }
    end

    assert_selector styled(:footer, :base), text: "Custom Footer Content"
  end

  def test_renders_modal_with_removed_classes
    render_inline(Fluxbit::ModalComponent.new(remove_class: styles[:root][:base])) { "Modal without Base Class" }

    assert_no_selector styled(:root, :base)
    assert_selector "div", text: "Modal without Base Class"
  end
end
