# frozen_string_literal: true

require "test_helper"

class Fluxbit::SpinnerComponentTest < ViewComponent::TestCase
  def test_renders_default_spinner
    render_inline(Fluxbit::SpinnerComponent.new)

    assert_selector "svg[role='status']"
    assert_selector "svg[aria-label='Loading...']"
    assert_selector "svg.animate-spin"
    assert_selector "svg.w-6.h-6"
    assert_selector "svg.text-gray-200.fill-blue-600"
    assert_selector "span.sr-only", text: "Loading..."
  end

  def test_renders_spinner_with_custom_color
    render_inline(Fluxbit::SpinnerComponent.new(color: :success))

    assert_selector "svg.text-gray-200.fill-green-500"
  end

  def test_renders_spinner_with_info_color
    render_inline(Fluxbit::SpinnerComponent.new(color: :info))

    assert_selector "svg.text-gray-200.fill-cyan-600"
  end

  def test_renders_spinner_with_failure_color
    render_inline(Fluxbit::SpinnerComponent.new(color: :failure))

    assert_selector "svg.text-gray-200.fill-red-600"
  end

  def test_renders_spinner_with_warning_color
    render_inline(Fluxbit::SpinnerComponent.new(color: :warning))

    assert_selector "svg.text-gray-200.fill-yellow-400"
  end

  def test_renders_spinner_with_pink_color
    render_inline(Fluxbit::SpinnerComponent.new(color: :pink))

    assert_selector "svg.text-gray-200.fill-pink-600"
  end

  def test_renders_spinner_with_purple_color
    render_inline(Fluxbit::SpinnerComponent.new(color: :purple))

    assert_selector "svg.text-gray-200.fill-purple-600"
  end

  def test_renders_spinner_with_different_sizes
    # Test xs size (0)
    render_inline(Fluxbit::SpinnerComponent.new(size: 0))
    assert_selector "svg.w-4.h-4"

    # Test sm size (1) - default
    render_inline(Fluxbit::SpinnerComponent.new(size: 1))
    assert_selector "svg.w-6.h-6"

    # Test md size (2)
    render_inline(Fluxbit::SpinnerComponent.new(size: 2))
    assert_selector "svg.w-8.h-8"

    # Test lg size (3)
    render_inline(Fluxbit::SpinnerComponent.new(size: 3))
    assert_selector "svg.w-10.h-10"

    # Test xl size (4)
    render_inline(Fluxbit::SpinnerComponent.new(size: 4))
    assert_selector "svg.w-12.h-12"
  end

  def test_renders_spinner_with_custom_label
    render_inline(Fluxbit::SpinnerComponent.new(label: "Processing..."))

    assert_selector "svg[aria-label='Processing...']"
    assert_selector "span.sr-only", text: "Processing..."
  end

  def test_renders_spinner_with_additional_html_attributes
    render_inline(Fluxbit::SpinnerComponent.new(id: "custom-spinner", data: { testid: "spinner" }))

    assert_selector "svg#custom-spinner"
    assert_selector "svg[data-testid='spinner']"
  end

  def test_renders_spinner_with_custom_classes
    render_inline(Fluxbit::SpinnerComponent.new(class: "custom-class"))

    assert_selector "svg.custom-class"
    assert_selector "svg.animate-spin" # Should still have base classes
  end

  def test_renders_spinner_with_removed_classes
    render_inline(Fluxbit::SpinnerComponent.new(remove_class: "animate-spin"))

    assert_selector "svg.w-6.h-6" # Should still have size classes
    assert_no_selector "svg.animate-spin" # Should not have removed class
  end

  def test_spinner_has_correct_svg_structure
    render_inline(Fluxbit::SpinnerComponent.new)

    assert_selector "svg"
    assert_selector "svg path", count: 2
    assert_selector "svg path[fill='currentColor']"
    assert_selector "svg path[fill='currentFill']"
    assert_selector "svg span.sr-only"
  end

  def test_spinner_accessibility_attributes
    render_inline(Fluxbit::SpinnerComponent.new(label: "Custom loading text"))

    assert_selector "svg[role='status']"
    assert_selector "svg[aria-label='Custom loading text']"
    assert_selector "span.sr-only", text: "Custom loading text"
  end

  def test_invalid_color_defaults_to_default
    render_inline(Fluxbit::SpinnerComponent.new(color: :invalid))

    assert_selector "svg.text-gray-200.fill-blue-600" # Should default to :default color
  end

  def test_invalid_size_defaults_to_default
    render_inline(Fluxbit::SpinnerComponent.new(size: 99))

    assert_selector "svg.w-6.h-6" # Should default to size 1
  end

  def test_combines_multiple_options
    render_inline(Fluxbit::SpinnerComponent.new(
      color: :success,
      size: 3,
      label: "Saving changes...",
      class: "ml-2",
      id: "save-spinner"
    ))

    assert_selector "svg#save-spinner.ml-2.animate-spin.w-10.h-10.text-gray-200.fill-green-500"
    assert_selector "svg[aria-label='Saving changes...']"
    assert_selector "span.sr-only", text: "Saving changes..."
  end
end
