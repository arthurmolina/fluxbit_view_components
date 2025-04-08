# frozen_string_literal: true

require "test_helper"

class Fluxbit::ButtonGroupComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::ButtonComponent

  def test_renders_button_group_with_default_styles
    render_inline(Fluxbit::ButtonGroupComponent.new) do |group|
      group.with_button { "Button 1" }
      group.with_button { "Button 2" }
    end

    assert_selector styled(:group)
    assert_selector "button", text: "Button 1"
    assert_selector "button", text: "Button 2"
  end

  def test_renders_button_group_with_custom_classes
    render_inline(Fluxbit::ButtonGroupComponent.new(class: "custom-class")) do |group|
      group.with_button { "Button 1" }
    end

    assert_selector ".custom-class"
    assert_selector "button", text: "Button 1"
  end

  def test_renders_button_group_with_first_and_last_with_button
    render_inline(Fluxbit::ButtonGroupComponent.new) do |group|
      group.with_button { "First Button" }
      group.with_button { "Middle Button" }
      group.with_button { "Last Button" }
    end

    assert_selector styled(:group)
    assert_selector "button:first-child#{styled(:inner, :position, :start)}", text: "First Button"
    assert_selector "button:last-child#{styled(:inner, :position, :end)}", text: "Last Button"
  end

  def test_renders_button_group_with_grouped_with_button
    render_inline(Fluxbit::ButtonGroupComponent.new) do |group|
      group.with_button { "Grouped Button 1" }
      group.with_button { "Grouped Button 2" }
    end

    assert_selector styled(:group)
    assert_selector "button#{styled(:inner, :base)}", text: "Grouped Button 1"
    assert_selector "button#{styled(:inner, :base)}", text: "Grouped Button 2"
  end

  def test_renders_button_group_with_custom_button_styles
    render_inline(Fluxbit::ButtonGroupComponent.new) do |group|
      group.with_button(color: :success) { "Primary Button" }
      group.with_button(size: 0) { "Large Button" }
    end

    assert_selector styled(:colors, :success), text: "Primary Button"
    assert_selector styled(:size, 0), text: "Large Button"
  end

  def test_renders_empty_button_group
    render_inline(Fluxbit::ButtonGroupComponent.new)

    assert_selector styled(:group)
    assert_no_selector "button"
  end
end
