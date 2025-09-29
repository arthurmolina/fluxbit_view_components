# frozen_string_literal: true

require "test_helper"

class Fluxbit::SpinnerPercentComponentTest < ViewComponent::TestCase
  def test_renders_default_spinner_percent
    render_inline(Fluxbit::SpinnerPercentComponent.new)

    assert_selector "div[role='progressbar']"
    assert_selector "div[aria-label='Loading...']"
    assert_selector "div[aria-valuenow='10']"
    assert_selector "div[aria-valuemin='0']"
    assert_selector "div[aria-valuemax='100']"
    assert_selector "div.relative.w-20.h-20"
    assert_selector "svg"
    assert_selector "div.absolute.inset-0", text: "0%"
    assert_selector "span.sr-only", text: "Loading..."
  end

  def test_renders_spinner_percent_with_custom_percent
    render_inline(Fluxbit::SpinnerPercentComponent.new(percent: 75))

    assert_selector "div[aria-valuenow='75']"
    assert_selector "div.absolute.inset-0", text: "75%"
  end

  def test_renders_spinner_percent_with_custom_color
    render_inline(Fluxbit::SpinnerPercentComponent.new(color: :success))

    assert_selector "circle.text-gray-200"
    assert_selector "circle.stroke-green-500"
    assert_selector "div.text-green-500"
  end

  def test_renders_spinner_percent_with_info_color
    render_inline(Fluxbit::SpinnerPercentComponent.new(color: :info))

    assert_selector "circle.text-gray-200"
    assert_selector "circle.stroke-cyan-600"
    assert_selector "div.text-cyan-600"
  end

  def test_renders_spinner_percent_with_failure_color
    render_inline(Fluxbit::SpinnerPercentComponent.new(color: :failure))

    assert_selector "circle.text-gray-200"
    assert_selector "circle.stroke-red-600"
    assert_selector "div.text-red-600"
  end

  def test_renders_spinner_percent_with_warning_color
    render_inline(Fluxbit::SpinnerPercentComponent.new(color: :warning))

    assert_selector "circle.text-gray-200"
    assert_selector "circle.stroke-yellow-400"
    assert_selector "div.text-yellow-400"
  end

  def test_renders_spinner_percent_with_pink_color
    render_inline(Fluxbit::SpinnerPercentComponent.new(color: :pink))

    assert_selector "circle.text-gray-200"
    assert_selector "circle.stroke-pink-600"
    assert_selector "div.text-pink-600"
  end

  def test_renders_spinner_percent_with_purple_color
    render_inline(Fluxbit::SpinnerPercentComponent.new(color: :purple))

    assert_selector "circle.text-gray-200"
    assert_selector "circle.stroke-purple-600"
    assert_selector "div.text-purple-600"
  end

  def test_renders_spinner_percent_with_different_sizes
    # Test xxs size (0)
    render_inline(Fluxbit::SpinnerPercentComponent.new(size: 0))
    assert_selector "div.w-12.h-12"
    assert_selector "svg.w-12.h-12"

    # Test xs size (1)
    render_inline(Fluxbit::SpinnerPercentComponent.new(size: 1))
    assert_selector "div.w-16.h-16"
    assert_selector "svg.w-16.h-16"

    # Test sm size (2) - default
    render_inline(Fluxbit::SpinnerPercentComponent.new(size: 2))
    assert_selector "div.w-20.h-20"
    assert_selector "svg.w-20.h-20"

    # Test md size (3)
    render_inline(Fluxbit::SpinnerPercentComponent.new(size: 3))
    assert_selector "div.w-24.h-24"
    assert_selector "svg.w-24.h-24"

    # Test lg size (4)
    render_inline(Fluxbit::SpinnerPercentComponent.new(size: 4))
    assert_selector "div.w-32.h-32"
    assert_selector "svg.w-32.h-32"
  end

  def test_renders_spinner_percent_with_custom_label
    render_inline(Fluxbit::SpinnerPercentComponent.new(label: "Processing..."))

    assert_selector "div[aria-label='Processing...']"
    assert_selector "span.sr-only", text: "Processing..."
  end

  def test_renders_spinner_percent_without_percentage_text
    render_inline(Fluxbit::SpinnerPercentComponent.new(show_percent: false))

    assert_no_selector "div.absolute.inset-0"
    assert_selector "svg"
    assert_selector "span.sr-only"
  end

  def test_renders_spinner_percent_with_percentage_text_enabled
    render_inline(Fluxbit::SpinnerPercentComponent.new(show_percent: true, percent: 50))

    assert_selector "div.absolute.inset-0", text: "50%"
  end

  def test_clamps_percent_value_to_valid_range
    # Test negative value
    render_inline(Fluxbit::SpinnerPercentComponent.new(percent: -10))
    assert_selector "div[aria-valuenow='0']"
    assert_selector "div.absolute.inset-0", text: "0%"

    # Test value over 100
    render_inline(Fluxbit::SpinnerPercentComponent.new(percent: 150))
    assert_selector "div[aria-valuenow='100']"
    assert_selector "div.absolute.inset-0", text: "100%"
  end

  def test_renders_spinner_percent_with_additional_html_attributes
    render_inline(Fluxbit::SpinnerPercentComponent.new(id: "custom-spinner", data: { testid: "spinner" }))

    assert_selector "div#custom-spinner"
    assert_selector "div[data-testid='spinner']"
  end

  def test_renders_spinner_percent_with_custom_classes
    render_inline(Fluxbit::SpinnerPercentComponent.new(class: "custom-class"))

    assert_selector "div.custom-class"
    assert_selector "div.relative" # Should still have base classes
  end

  def test_renders_spinner_percent_with_removed_classes
    render_inline(Fluxbit::SpinnerPercentComponent.new(remove_class: "relative"))

    assert_selector "div.w-20.h-20" # Should still have size classes
    assert_no_selector "div.relative" # Should not have removed class
  end

  def test_spinner_percent_has_correct_svg_structure
    render_inline(Fluxbit::SpinnerPercentComponent.new)

    assert_selector "svg"
    assert_selector "svg circle", count: 2
    assert_selector "svg circle[stroke='currentColor']", count: 2
    assert_selector "svg circle[fill='transparent']", count: 2
    assert_selector "circle[stroke-linecap='round']", count: 1 # Only progress circle
  end

  def test_spinner_percent_accessibility_attributes
    render_inline(Fluxbit::SpinnerPercentComponent.new(label: "Custom loading text", percent: 25))

    assert_selector "div[role='progressbar']"
    assert_selector "div[aria-label='Custom loading text']"
    assert_selector "div[aria-valuenow='25']"
    assert_selector "div[aria-valuemin='0']"
    assert_selector "div[aria-valuemax='100']"
    assert_selector "span.sr-only", text: "Custom loading text"
  end

  def test_stimulus_controller_attributes
    render_inline(Fluxbit::SpinnerPercentComponent.new(percent: 30))

    assert_selector "div[data-controller='fx-spinner-percent']"
    assert_selector "div[data-fx-spinner-percent-percent-value='30']"
    assert_selector "circle[data-fx-spinner-percent-target='progress']"
    assert_selector "div[data-fx-spinner-percent-target='text']"
  end

  def test_invalid_color_defaults_to_default
    render_inline(Fluxbit::SpinnerPercentComponent.new(color: :invalid))

    assert_selector "circle.text-gray-200"
    assert_selector "circle.stroke-blue-600"
    assert_selector "div.text-blue-600"
  end

  def test_invalid_size_defaults_to_default
    render_inline(Fluxbit::SpinnerPercentComponent.new(size: 99))

    assert_selector "div.w-20.h-20" # Should default to size 1
  end

  def test_combines_multiple_options
    render_inline(Fluxbit::SpinnerPercentComponent.new(
      color: :success,
      size: 4,
      percent: 85,
      label: "Uploading...",
      show_percent: true,
      class: "ml-2",
      id: "upload-progress"
    ))

    assert_selector "div#upload-progress.ml-2.relative.w-32.h-32"
    assert_selector "div[aria-label='Uploading...']"
    assert_selector "div[aria-valuenow='85']"
    assert_selector "circle.text-gray-200"
    assert_selector "circle.stroke-green-500"
    assert_selector "div.text-green-500", text: "85%"
    assert_selector "span.sr-only", text: "Uploading..."
  end

  def test_stroke_dash_calculations
    component = Fluxbit::SpinnerPercentComponent.new(percent: 50)

    # Access private methods for testing calculations
    circumference = component.send(:circumference)
    assert_equal 2 * Math::PI * 45, circumference

    stroke_dasharray = component.send(:stroke_dasharray)
    assert_equal circumference, stroke_dasharray

    stroke_dashoffset = component.send(:stroke_dashoffset)
    expected_offset = circumference - (50 / 100.0) * circumference
    assert_equal expected_offset, stroke_dashoffset
  end

  def test_percentage_calculations_at_different_values
    # 0% should show full gray circle
    component_0 = Fluxbit::SpinnerPercentComponent.new(percent: 0)
    circumference = component_0.send(:circumference)
    assert_equal circumference, component_0.send(:stroke_dashoffset)

    # 100% should show full colored circle
    component_100 = Fluxbit::SpinnerPercentComponent.new(percent: 100)
    assert_equal 0, component_100.send(:stroke_dashoffset)

    # 25% should show quarter colored circle
    component_25 = Fluxbit::SpinnerPercentComponent.new(percent: 25)
    expected_offset = circumference - (25 / 100.0) * circumference
    assert_equal expected_offset, component_25.send(:stroke_dashoffset)
  end

  def test_renders_spinner_percent_with_custom_text
    render_inline(Fluxbit::SpinnerPercentComponent.new(percent: 50, text: "Loading..."))

    assert_selector "div.absolute.inset-0", text: "Loading..."
    assert_no_selector "div", text: "50%"
  end

  def test_custom_text_overrides_percentage_display
    render_inline(Fluxbit::SpinnerPercentComponent.new(percent: 75, text: "Custom", show_percent: true))

    assert_selector "div.absolute.inset-0", text: "Custom"
    assert_no_selector "div", text: "75%"
  end

  def test_no_text_displayed_when_text_false_and_show_percent_false
    render_inline(Fluxbit::SpinnerPercentComponent.new(percent: 50, text: nil, show_percent: false))

    assert_no_selector "div.absolute.inset-0"
    assert_no_selector "div", text: "50%"
  end

  def test_empty_string_text_displays_nothing
    render_inline(Fluxbit::SpinnerPercentComponent.new(percent: 50, text: ""))

    assert_selector "div.absolute.inset-0", text: ""
    assert_no_selector "div", text: "50%"
  end

  def test_html_content_in_custom_text
    render_inline(Fluxbit::SpinnerPercentComponent.new(percent: 50, text: "✓ Done"))

    assert_selector "div.absolute.inset-0", text: "✓ Done"
  end

  def test_renders_spinner_percent_with_smallest_size
    render_inline(Fluxbit::SpinnerPercentComponent.new(size: 0, percent: 50))

    assert_selector "div.relative.w-12.h-12"
    assert_selector "svg.w-12.h-12"
  end

  def test_renders_spinner_percent_with_label_html_attributes
    render_inline(Fluxbit::SpinnerPercentComponent.new(
      percent: 75,
      label_html: { class: "font-bold text-lg", id: "custom-label" }
    ))

    assert_selector "div#custom-label", text: "75%"
    assert_selector "div.font-bold", text: "75%"
    assert_selector "div.text-lg", text: "75%"
  end

  def test_label_html_merges_with_default_classes
    render_inline(Fluxbit::SpinnerPercentComponent.new(
      percent: 50,
      text: "Custom",
      label_html: { class: "extra-class" }
    ))

    assert_selector "div.extra-class", text: "Custom"
    assert_selector "div.absolute", text: "Custom"
    assert_selector "div[data-fx-spinner-percent-target='text']", text: "Custom"
  end

  def test_label_html_remove_class_removes_default_classes
    render_inline(Fluxbit::SpinnerPercentComponent.new(
      percent: 75,
      text: "Custom",
      label_html: {
        class: "text-lg text-purple-600 font-bold",
        remove_class: "text-sm"
      }
    ))

    assert_selector "div.text-lg", text: "Custom"
    assert_selector "div.text-purple-600", text: "Custom"
    assert_selector "div.font-bold", text: "Custom"
    assert_no_selector "div.text-sm"
    assert_selector "div.absolute", text: "Custom" # other default classes should remain
  end

  def test_label_html_remove_class_with_multiple_classes
    render_inline(Fluxbit::SpinnerPercentComponent.new(
      percent: 80,
      label_html: {
        class: "text-xl custom-class",
        remove_class: "text-sm font-semibold"
      }
    ))

    assert_selector "div.text-xl"
    assert_selector "div.custom-class"
    assert_no_selector "div.text-sm"
    assert_no_selector "div.font-semibold"
    assert_selector "div.absolute" # should keep other default classes
  end

  def test_label_html_remove_class_with_string_key
    render_inline(Fluxbit::SpinnerPercentComponent.new(
      percent: 60,
      label_html: {
        "class" => "text-lg font-bold",
        "remove_class" => "text-sm"
      }
    ))

    assert_selector "div.text-lg", text: "60%"
    assert_selector "div.font-bold", text: "60%"
    assert_no_selector "div.text-sm"
    # Just verify the main functionality without checking for all default classes
    assert_selector "div[data-fx-spinner-percent-target='text']", text: "60%"
  end
end
