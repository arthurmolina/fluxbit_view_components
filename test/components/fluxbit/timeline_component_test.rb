# frozen_string_literal: true

require "test_helper"

class Fluxbit::TimelineComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::TimelineComponent

  def test_renders_timeline_with_default_styles
    render_inline(Fluxbit::TimelineComponent.new) do |timeline|
      timeline.with_item(title: "Item 1", description: "First item")
      timeline.with_item(title: "Item 2", description: "Second item")
    end

    assert_selector "ul.relative.space-y-8.ml-3"
    assert_selector "li", count: 2
  end

  def test_renders_vertical_variant
    render_inline(Fluxbit::TimelineComponent.new(variant: :vertical)) do |timeline|
      timeline.with_item(title: "Item 1")
      timeline.with_item(title: "Item 2")
    end

    assert_selector "ul.relative.space-y-6.ml-3"
  end

  def test_renders_stepper_variant
    render_inline(Fluxbit::TimelineComponent.new(variant: :stepper)) do |timeline|
      timeline.with_item(title: "Step 1")
      timeline.with_item(title: "Step 2")
    end

    assert_selector "ol.relative"
    assert_selector "li", count: 2
  end

  def test_renders_activity_variant
    render_inline(Fluxbit::TimelineComponent.new(variant: :activity)) do |timeline|
      timeline.with_item(title: "Activity 1", date: "Jan 1, 2024")
      timeline.with_item(title: "Activity 2", date: "Jan 2, 2024")
    end

    assert_selector "ul.relative.space-y-4.border-l"
  end

  def test_renders_center_position
    render_inline(Fluxbit::TimelineComponent.new(position: :center)) do |timeline|
      timeline.with_item(title: "Item 1")
    end

    assert_selector "ul.relative.space-y-8"
    assert_no_selector "ul.ml-3"
    assert_no_selector "ul.mr-3"
  end

  def test_renders_right_position
    render_inline(Fluxbit::TimelineComponent.new(position: :right)) do |timeline|
      timeline.with_item(title: "Item 1")
    end

    assert_selector "ul.relative.space-y-8.mr-3"
  end

  def test_renders_item_with_title_and_description
    render_inline(Fluxbit::TimelineComponent.new) do |timeline|
      timeline.with_item(
        title: "Project Started",
        description: "The project has been initiated and planning is underway."
      )
    end

    assert_selector "h3", text: "Project Started"
    assert_selector "p", text: "The project has been initiated and planning is underway."
  end

  def test_renders_item_with_date
    render_inline(Fluxbit::TimelineComponent.new) do |timeline|
      timeline.with_item(
        title: "Release",
        date: "January 13th, 2022"
      )
    end

    assert_selector "time", text: "January 13th, 2022"
  end

  def test_renders_item_with_icon
    render_inline(Fluxbit::TimelineComponent.new) do |timeline|
      timeline.with_item(
        title: "Release",
        icon: "heroicons_solid:rocket-launch"
      )
    end

    assert_selector "svg"
  end

  def test_renders_completed_status_with_checkmark
    render_inline(Fluxbit::TimelineComponent.new) do |timeline|
      timeline.with_item(
        title: "Completed Task",
        status: :completed
      )
    end

    assert_selector "svg" # Check icon should be rendered
  end

  def test_renders_different_color_themes
    %i[blue green red yellow purple indigo].each do |color|
      render_inline(Fluxbit::TimelineComponent.new) do |timeline|
        timeline.with_item(
          title: "Colored Item",
          color: color
        )
      end

      color_class = "text-#{color}-800"
      assert_selector ".#{color_class.gsub('-', '\\-')}"
    end
  end

  def test_renders_item_as_link_when_href_provided
    render_inline(Fluxbit::TimelineComponent.new) do |timeline|
      timeline.with_item(
        title: "Linked Item",
        href: "/timeline/item/1"
      )
    end

    assert_selector "a[href='/timeline/item/1']", text: "Linked Item"
  end

  def test_applies_custom_html_attributes
    render_inline(Fluxbit::TimelineComponent.new(
      id: "my-timeline",
      data: { controller: "timeline" }
    )) do |timeline|
      timeline.with_item(title: "Item 1")
    end

    assert_selector "ul#my-timeline[data-controller='timeline']"
  end

  def test_removes_custom_classes
    render_inline(Fluxbit::TimelineComponent.new(
      remove_class: "space-y-8",
      class: "space-y-8 custom-class"
    )) do |timeline|
      timeline.with_item(title: "Item 1")
    end

    assert_selector "ul.custom-class"
    assert_no_selector "ul.space-y-8"
  end

  def test_stepper_variant_renders_ordered_list
    render_inline(Fluxbit::TimelineComponent.new(variant: :stepper)) do |timeline|
      timeline.with_item(title: "Step 1")
    end

    assert_selector "ol"
    assert_no_selector "ul"
  end

  def test_stepper_variant_is_horizontal
    render_inline(Fluxbit::TimelineComponent.new(variant: :stepper)) do |timeline|
      timeline.with_item(title: "Step 1", date: "January 2024", status: :completed)
      timeline.with_item(title: "Step 2", date: "February 2024")
    end

    assert_selector "ol.items-center.sm\\:flex"
    assert_selector "li", count: 2
    assert_selector "h3", text: "Step 1"
    assert_selector "h3", text: "Step 2"
    assert_selector "time", text: "January 2024"
    assert_selector "time", text: "February 2024"
    assert_selector ".hidden.sm\\:flex.w-full.bg-gray-200"  # Connector lines between items

    # Check for circular indicators with icons inside
    assert_selector ".z-10.flex.items-center.justify-center.w-6.h-6.rounded-full", count: 2
    assert_selector "svg", count: 2  # Icons inside the circles
  end

  def test_activity_variant_renders_time_element
    render_inline(Fluxbit::TimelineComponent.new(variant: :activity)) do |timeline|
      timeline.with_item(
        title: "Activity",
        date: "2 hours ago"
      )
    end

    assert_selector "time", text: "2 hours ago"
  end

  def test_all_variants_render_successfully
    variants = [ :default, :vertical, :stepper, :activity ]

    variants.each do |variant|
      render_inline(Fluxbit::TimelineComponent.new(variant: variant)) do |timeline|
        timeline.with_item(title: "Test Item", description: "Test description")
      end

      assert_selector "li"
    end
  end

  def test_all_positions_render_successfully
    positions = [ :left, :center, :right ]

    positions.each do |position|
      render_inline(Fluxbit::TimelineComponent.new(position: position)) do |timeline|
        timeline.with_item(title: "Test Item")
      end

      assert_selector "ul.relative"
    end
  end

  def test_all_statuses_render_successfully
    statuses = [ :default, :completed, :current, :pending ]

    statuses.each do |status|
      render_inline(Fluxbit::TimelineComponent.new) do |timeline|
        timeline.with_item(title: "Test Item", status: status)
      end

      assert_selector "li"
    end
  end

  def test_handles_empty_timeline
    render_inline(Fluxbit::TimelineComponent.new)

    assert_selector "ul.relative"
    assert_no_selector "li"
  end

  def test_item_with_custom_attributes
    render_inline(Fluxbit::TimelineComponent.new) do |timeline|
      timeline.with_item(
        title: "Custom Item",
        id: "timeline-item-1",
        data: { testid: "timeline-item" },
        class: "custom-item-class"
      )
    end

    assert_selector "li#timeline-item-1[data-testid='timeline-item'].custom-item-class"
  end

  def test_handles_invalid_variant_gracefully
    # Should fall back to default
    render_inline(Fluxbit::TimelineComponent.new(variant: :invalid)) do |timeline|
      timeline.with_item(title: "Test Item")
    end

    # Should render default variant
    assert_selector "ul.space-y-8"
  end

  def test_handles_invalid_position_gracefully
    # Should fall back to left
    render_inline(Fluxbit::TimelineComponent.new(position: :invalid)) do |timeline|
      timeline.with_item(title: "Test Item")
    end

    assert_selector "ul.ml-3"
  end
end
