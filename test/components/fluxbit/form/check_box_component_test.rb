require "test_helper"

class Fluxbit::Form::CheckBoxComponentTest < ViewComponent::TestCase
  def test_renders_basic_checkbox
    render_inline(Fluxbit::Form::CheckBoxComponent.new(name: "accept_terms", label: "Accept terms"))
    assert_selector "input[type='checkbox'][name='accept_terms']"
    assert_text "Accept terms"
  end

  def test_renders_with_value
    render_inline(Fluxbit::Form::CheckBoxComponent.new(name: "subscribe", value: "1"))
    assert_selector "input[type='checkbox'][name='subscribe'][value='1']"
  end

  def test_renders_radio_button_type
    render_inline(Fluxbit::Form::CheckBoxComponent.new(name: "gender", type: :radio_button, value: "male", label: "Male"))
    assert_selector "input[type='radio'][name='gender'][value='male']"
    assert_text "Male"
  end

  def test_renders_with_help_text
    render_inline(Fluxbit::Form::CheckBoxComponent.new(name: "updates", label: "Email me updates", help_text: "You can unsubscribe at any time."))
    assert_text "You can unsubscribe at any time."
  end

  def test_renders_disabled
    render_inline(Fluxbit::Form::CheckBoxComponent.new(name: "newsletter", disabled: true))
    assert_selector "input[disabled]"
  end

  def test_renders_checked
    render_inline(Fluxbit::Form::CheckBoxComponent.new(name: "accept", value: "1", checked: true))
    assert_selector "input[checked]"
  end

  def test_renders_label_and_input_in_flex
    render_inline(Fluxbit::Form::CheckBoxComponent.new(name: "promo", label: "Promo", help_text: "Optional"))
    assert_selector ".flex"
    assert_text "Promo"
    assert_text "Optional"
  end

  def test_renders_label_with_no_helper_div
    render_inline(Fluxbit::Form::CheckBoxComponent.new(name: "tos", label: "TOS"))
    assert_selector ".flex.items-center"
    assert_text "TOS"
  end

  def test_renders_custom_classes
    render_inline(Fluxbit::Form::CheckBoxComponent.new(name: "privacy", class: "custom-class"))
    assert_selector ".custom-class"
  end
end
