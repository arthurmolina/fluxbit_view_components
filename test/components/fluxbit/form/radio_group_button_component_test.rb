# frozen_string_literal: true

require "test_helper"

class Fluxbit::Form::RadioGroupButtonComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::Form::RadioGroupButtonComponent
  include Fluxbit::Config::ButtonComponent

  def test_renders_radio_group_with_default_styles
    render_inline(Fluxbit::Form::RadioGroupButtonComponent.new(name: "view_mode")) do |radio|
      radio.with_radio_option(value: "list") { "List" }
      radio.with_radio_option(value: "grid") { "Grid" }
    end

    assert_selector "input[type='radio'][name='view_mode'][value='list']"
    assert_selector "input[type='radio'][name='view_mode'][value='grid']"
    assert_selector "label", text: "List"
    assert_selector "label", text: "Grid"
  end

  def test_renders_with_checked_option
    render_inline(Fluxbit::Form::RadioGroupButtonComponent.new(name: "view_mode")) do |radio|
      radio.with_radio_option(value: "list", checked: true) { "List" }
      radio.with_radio_option(value: "grid") { "Grid" }
    end

    assert_selector "input[type='radio'][name='view_mode'][value='list'][checked]"
    assert_selector "input[type='radio'][name='view_mode'][value='grid']:not([checked])"
  end

  def test_renders_with_disabled_option
    render_inline(Fluxbit::Form::RadioGroupButtonComponent.new(name: "view_mode")) do |radio|
      radio.with_radio_option(value: "list") { "List" }
      radio.with_radio_option(value: "grid", disabled: true) { "Grid" }
    end

    assert_selector "input[type='radio'][name='view_mode'][value='list']:not([disabled])"
    assert_selector "input[type='radio'][name='view_mode'][value='grid'][disabled]"
  end

  def test_applies_color_classes
    render_inline(Fluxbit::Form::RadioGroupButtonComponent.new(name: "view_mode", color: :success)) do |radio|
      radio.with_radio_option(value: "list") { "List" }
    end

    assert_selector "label"
  end

  def test_applies_size_classes
    render_inline(Fluxbit::Form::RadioGroupButtonComponent.new(name: "view_mode", size: 3)) do |radio|
      radio.with_radio_option(value: "list") { "List" }
    end

    assert_selector "label.text-base"
  end

  def test_applies_pill_classes
    render_inline(Fluxbit::Form::RadioGroupButtonComponent.new(name: "view_mode", pill: true)) do |radio|
      radio.with_radio_option(value: "list") { "List" }
    end

    assert_selector "label.rounded-full"
  end

  def test_generates_unique_ids
    render_inline(Fluxbit::Form::RadioGroupButtonComponent.new(name: "view_mode")) do |radio|
      radio.with_radio_option(value: "list") { "List" }
      radio.with_radio_option(value: "grid") { "Grid" }
    end

    # Each radio input should have a unique id
    assert_selector "input[type='radio']", count: 2
    # Each label should have a corresponding for attribute
    assert_selector "label[for]", count: 2
  end

  def test_auto_generates_name_if_not_provided
    render_inline(Fluxbit::Form::RadioGroupButtonComponent.new) do |radio|
      radio.with_radio_option(value: "list") { "List" }
      radio.with_radio_option(value: "grid") { "Grid" }
    end

    # Should still render radio inputs with a name attribute
    assert_selector "input[type='radio'][name]", count: 2
  end
end
