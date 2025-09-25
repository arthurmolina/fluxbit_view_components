# frozen_string_literal: true

require "test_helper"

class Fluxbit::StepperComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::StepperComponent

  def test_renders_stepper_with_default_styles
    render_inline(Fluxbit::StepperComponent.new) do |stepper|
      stepper.with_step(title: "Step 1", number: "1")
      stepper.with_step(title: "Step 2", number: "2")
    end

    assert_selector "div ol", count: 1
    assert_selector styled(:base, :horizontal)
    assert_selector styled(:list, :default, :horizontal)
    assert_selector "li", count: 2
  end

  def test_renders_vertical_orientation
    render_inline(Fluxbit::StepperComponent.new(orientation: :vertical)) do |stepper|
      stepper.with_step(title: "Step 1", number: "1")
      stepper.with_step(title: "Step 2", number: "2")
    end

    assert_selector styled(:base, :vertical)
    assert_selector styled(:list, :default, :vertical)
  end

  def test_applies_correct_color_for_active_step
    render_inline(Fluxbit::StepperComponent.new(color: :green)) do |stepper|
      stepper.with_step(title: "Step 1", state: :active, number: "1")
    end

    step_classes = styles[:step][:default][:active][:green].gsub(":", "\\:").gsub(".", "\\.").gsub(" ", ".")
    assert_selector ".#{step_classes}"
  end

  def test_renders_completed_step_with_checkmark
    render_inline(Fluxbit::StepperComponent.new) do |stepper|
      stepper.with_step(title: "Step 1", state: :completed, number: "1")
    end

    assert_selector styled(:step, :default, :completed)
    assert_selector "svg" # Check icon should be rendered
  end

  def test_renders_pending_step_with_number
    render_inline(Fluxbit::StepperComponent.new) do |stepper|
      stepper.with_step(title: "Step 1", state: :pending, number: "1")
    end

    assert_selector styled(:step, :default, :base)
    assert_selector "span", text: "1"
  end

  def test_renders_step_with_title_and_description
    render_inline(Fluxbit::StepperComponent.new) do |stepper|
      stepper.with_step(
        title: "Personal Info",
        description: "Enter your details",
        number: "1"
      )
    end

    assert_selector "h3", text: "Personal Info"
    assert_selector "p", text: "Enter your details"
  end

  def test_renders_connectors_between_steps
    render_inline(Fluxbit::StepperComponent.new) do |stepper|
      stepper.with_step(title: "Step 1", number: "1")
      stepper.with_step(title: "Step 2", number: "2")
      stepper.with_step(title: "Step 3", number: "3")
    end

    # Should have 2 connectors for 3 steps
    connector_classes = styles[:connector][:default][:horizontal].gsub(":", "\\:").gsub(".", "\\.").gsub(" ", ".")
    assert_selector ".#{connector_classes}", count: 2
  end

  def test_does_not_render_connector_for_last_step
    render_inline(Fluxbit::StepperComponent.new) do |stepper|
      stepper.with_step(title: "Step 1", number: "1")
    end

    # Should have no connectors for single step
    connector_classes = styles[:connector][:default][:horizontal].gsub(":", "\\:").gsub(".", "\\.").gsub(" ", ".")
    assert_no_selector ".#{connector_classes}"
  end

  def test_handles_custom_step_number
    render_inline(Fluxbit::StepperComponent.new) do |stepper|
      stepper.with_step(title: "Step A", number: "A")
      stepper.with_step(title: "Step B", number: "B")
    end

    assert_selector "span", text: "A"
    assert_selector "span", text: "B"
  end

  def test_step_states
    %i[pending active completed].each do |state|
      render_inline(Fluxbit::StepperComponent.new) do |stepper|
        stepper.with_step(title: "Step 1", state: state, number: "1")
      end

      case state
      when :completed
        assert_selector styled(:step, :default, :completed)
      when :active
        assert_selector styled(:step, :default, :active, :blue) # Default color is blue
      else
        assert_selector styled(:step, :default, :base)
      end
    end
  end

  def test_different_color_options
    %i[blue green red yellow indigo purple].each do |color|
      render_inline(Fluxbit::StepperComponent.new(color: color)) do |stepper|
        stepper.with_step(title: "Step 1", state: :active, number: "1")
      end

      step_classes = styles[:step][:default][:active][color].gsub(":", "\\:").gsub(".", "\\.").gsub(" ", ".")
      assert_selector ".#{step_classes}"
    end
  end

  def test_removes_custom_classes
    render_inline(Fluxbit::StepperComponent.new(remove_class: "items-center")) do |stepper|
      stepper.with_step(title: "Step 1", number: "1")
    end

    # The main div should not contain the removed class
    assert_no_selector "div.items-center", text: "", exact: false
  end

  def test_applies_custom_html_attributes
    render_inline(Fluxbit::StepperComponent.new(
      id: "my-stepper",
      data: { controller: "stepper" }
    )) do |stepper|
      stepper.with_step(title: "Step 1", number: "1")
    end

    assert_selector "div#my-stepper[data-controller='stepper']"
  end

  def test_variant_options
    %i[default progress detailed].each do |variant|
      render_inline(Fluxbit::StepperComponent.new(variant: variant)) do |stepper|
        stepper.with_step(title: "Step 1", number: "1")
      end

      # All variants should render the basic structure
      assert_selector "div ol"
      assert_selector "li"
    end
  end
end