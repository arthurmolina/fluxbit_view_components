require "test_helper"

class Fluxbit::Form::RangeComponentTest < ViewComponent::TestCase
  def test_renders_default
    render_inline(Fluxbit::Form::RangeComponent.new(name: "volume"))
    assert_selector "input[type='range'][name='volume']"
  end

  def test_renders_with_value
    render_inline(Fluxbit::Form::RangeComponent.new(name: "opacity", value: 42))
    assert_selector "input[type='range'][value='42']"
  end

  def test_renders_with_label
    render_inline(Fluxbit::Form::RangeComponent.new(name: "size", label: "Size"))
    assert_text "Size"
    assert_selector "input[type='range'][name='size']"
  end

  def test_renders_with_help_text
    render_inline(Fluxbit::Form::RangeComponent.new(name: "brightness", help_text: "Drag to set brightness"))
    assert_text "Drag to set brightness"
  end

  def test_renders_with_vertical_true
    render_inline(Fluxbit::Form::RangeComponent.new(name: "temp", vertical: true))
    assert_selector "input[type='range'][name='temp'][style*='rotate(270deg)']"
  end

  def test_renders_with_sizing
    render_inline(Fluxbit::Form::RangeComponent.new(name: "weight", sizing: 2))
    assert_selector "input[type='range'].h-3.range-lg"
  end

  def test_renders_with_custom_class
    render_inline(Fluxbit::Form::RangeComponent.new(name: "custom", class: "custom-range"))
    assert_selector "input[type='range'].custom-range"
  end

  def test_respects_min_and_max
    render_inline(Fluxbit::Form::RangeComponent.new(name: "score", min: 1, max: 10))
    assert_selector "input[type='range'][min='1'][max='10']"
  end
end
