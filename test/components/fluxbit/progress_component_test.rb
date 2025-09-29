# frozen_string_literal: true

require "test_helper"

class Fluxbit::ProgressComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::ProgressComponent
  include Fluxbit::ComponentsHelper

  def test_renders_with_default_behavior
    render_inline(Fluxbit::ProgressComponent.new)

    assert_selector styled(:base)
    assert_selector styled(:sizes, 1)
    assert_selector "[style*='width: 0%']"
  end

  def test_renders_progress_bar_with_custom_progress
    render_inline(Fluxbit::ProgressComponent.new(progress: 45))

    assert_selector "[style*='width: 45%']"
  end

  def test_clamps_progress_value_to_valid_range
    # Test progress below 0
    render_inline(Fluxbit::ProgressComponent.new(progress: -10))
    assert_selector "[style*='width: 0%']"

    # Test progress above 100
    render_inline(Fluxbit::ProgressComponent.new(progress: 150))
    assert_selector "[style*='width: 100%']"
  end

  def test_colors
    %i[default dark blue red green yellow indigo purple cyan gray lime pink teal].each do |color|
      render_inline(Fluxbit::ProgressComponent.new(color: color, progress: 50))
      assert_selector styled(:bar, :colors, color)
    end
  end

  def test_sizes
    (0..3).each do |size|
      render_inline(Fluxbit::ProgressComponent.new(size: size, progress: 50))
      assert_selector styled(:sizes, size)
    end
  end

  def test_renders_outside_text_label
    render_inline(Fluxbit::ProgressComponent.new(
      text_label: "Loading",
      label_text: true,
      text_label_position: :outside,
      progress: 75
    ))

    assert_selector styled(:labels, :outside, :base)
    assert_selector styled(:labels, :outside, :text), text: "Loading"
  end

  def test_renders_outside_progress_label
    render_inline(Fluxbit::ProgressComponent.new(
      label_progress: true,
      progress_label_position: :outside,
      progress: 75
    ))

    assert_selector styled(:labels, :outside, :base)
    assert_selector styled(:labels, :outside, :progress), text: "75%"
  end

  def test_renders_inside_text_label
    render_inline(Fluxbit::ProgressComponent.new(
      text_label: "Loading",
      label_text: true,
      text_label_position: :inside,
      progress: 75
    ))

    assert_selector styled(:labels, :inside, :text), text: "Loading"
  end

  def test_renders_inside_progress_label
    render_inline(Fluxbit::ProgressComponent.new(
      label_progress: true,
      progress_label_position: :inside,
      progress: 75
    ))

    assert_selector styled(:labels, :inside, :progress), text: "75%"
  end

  def test_renders_both_labels_outside
    render_inline(Fluxbit::ProgressComponent.new(
      text_label: "Flowbite",
      label_text: true,
      text_label_position: :outside,
      label_progress: true,
      progress_label_position: :outside,
      progress: 45
    ))

    assert_selector styled(:labels, :outside, :base)
    assert_selector styled(:labels, :outside, :text), text: "Flowbite"
    assert_selector styled(:labels, :outside, :progress), text: "45%"
  end

  def test_renders_both_labels_inside
    render_inline(Fluxbit::ProgressComponent.new(
      text_label: "Flowbite",
      label_text: true,
      text_label_position: :inside,
      label_progress: true,
      progress_label_position: :inside,
      progress: 45
    ))

    assert_selector styled(:labels, :inside, :text), text: "Flowbite"
    assert_selector styled(:labels, :inside, :progress), text: "45%"
  end

  def test_renders_mixed_label_positions
    render_inline(Fluxbit::ProgressComponent.new(
      text_label: "Flowbite",
      label_text: true,
      text_label_position: :outside,
      label_progress: true,
      progress_label_position: :inside,
      progress: 60
    ))

    assert_selector styled(:labels, :outside, :base)
    assert_selector styled(:labels, :outside, :text), text: "Flowbite"
    assert_selector styled(:labels, :inside, :progress), text: "60%"
  end

  def test_does_not_render_labels_when_disabled
    render_inline(Fluxbit::ProgressComponent.new(
      text_label: "Flowbite",
      label_text: false,
      label_progress: false,
      progress: 45
    ))

    assert_no_selector styled(:labels, :outside, :base)
    assert_no_selector ".#{styles.dig(:labels, :outside, :text).gsub(' ', '.')}"
    assert_no_selector ".#{styles.dig(:labels, :outside, :progress).gsub(' ', '.')}"
  end

  def test_does_not_render_text_label_when_text_is_blank
    render_inline(Fluxbit::ProgressComponent.new(
      text_label: "",
      label_text: true,
      progress: 45
    ))

    assert_no_selector styled(:labels, :outside, :base)
  end

  def test_applies_custom_html_attributes
    render_inline(Fluxbit::ProgressComponent.new(
      progress: 50,
      id: "custom-progress",
      "data-testid" => "progress-bar"
    ))

    assert_selector "#custom-progress"
    assert_selector "[data-testid='progress-bar']"
  end

  def test_removes_custom_classes
    render_inline(Fluxbit::ProgressComponent.new(
      progress: 50,
      class: "custom-class",
      remove_class: "bg-gray-200"
    ))

    assert_selector ".custom-class"
    assert_no_selector ".bg-gray-200"
  end

  def test_applies_text_sizing_for_inside_labels
    # Test that text sizing is applied when inside labels are present
    render_inline(Fluxbit::ProgressComponent.new(
      progress: 50,
      size: 0,
      label_progress: true,
      progress_label_position: :inside
    ))

    assert_selector ".text-xs.px-1" # size 0 text styling
  end

  def test_applies_larger_text_sizing_for_larger_progress_bars
    render_inline(Fluxbit::ProgressComponent.new(
      progress: 50,
      size: 3,
      label_progress: true,
      progress_label_position: :inside
    ))

    assert_selector ".text-sm.px-2" # size 3 text styling
  end

  def test_label_html_parameter_adds_custom_attributes
    render_inline(Fluxbit::ProgressComponent.new(
      progress: 50,
      text_label: "Loading",
      label_text: true,
      text_label_position: :outside,
      label_html: {
        id: "custom-label",
        "data-testid" => "progress-label"
      }
    ))

    assert_selector "#custom-label", text: "Loading"
    assert_selector "[data-testid='progress-label']", text: "Loading"
  end

  def test_label_html_merges_custom_classes_with_base_classes
    render_inline(Fluxbit::ProgressComponent.new(
      progress: 90,
      text_label: "Almost Done",
      label_text: true,
      text_label_position: :inside,
      label_html: { class: "font-bold text-yellow-200" }
    ))

    # Should have both base classes and custom classes
    assert_selector ".font-bold.text-yellow-200", text: "Almost Done"
    assert_selector ".text-xs", text: "Almost Done" # base inside label class
  end

  def test_label_html_remove_class_functionality
    render_inline(Fluxbit::ProgressComponent.new(
      progress: 75,
      label_progress: true,
      progress_label_position: :outside,
      label_html: {
        remove_class: "text-blue-700"
      }
    ))

    # Should have the progress label but without the removed class
    assert_selector "span", text: "75%"
    assert_no_selector ".text-blue-700"
  end

  def test_flexbox_centering_for_inside_labels
    render_inline(Fluxbit::ProgressComponent.new(
      progress: 60,
      text_label: "Test",
      label_text: true,
      text_label_position: :inside
    ))

    # Should have flex centering classes
    assert_selector ".flex.items-center.justify-center"
  end

  def test_helper_method_integration
    assert_respond_to self, :fx_progress
  end
end