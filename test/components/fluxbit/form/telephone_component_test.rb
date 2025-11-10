require "test_helper"

class Fluxbit::Form::TelephoneComponentTest < ViewComponent::TestCase
  def test_renders_basic
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", label: "Phone Number"))
    assert_text "Phone Number"
    assert_selector "input[name='phone']"
    assert_selector "select[name='phone_country']"
  end

  def test_renders_with_default_country
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", default_country: "US"))
    assert_selector "option[value='US'][selected]"
  end

  def test_renders_with_brazil_as_default
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone"))
    assert_selector "option[value='BR'][selected]"
  end

  def test_renders_country_select_with_flags
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone"))
    # Check for Brazil flag and dial code
    assert_selector "option[value='BR']", text: /🇧🇷.*\+55/
  end

  def test_renders_with_stimulus_controller
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone"))
    assert_selector "input[data-controller='fx-telephone']"
  end

  def test_renders_with_mask_value
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", default_country: "BR"))
    assert_selector "input[data-fx-telephone-mask-value]"
  end

  def test_country_select_has_target
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone"))
    assert_selector "select[data-fx-telephone-target='countrySelect']"
  end

  def test_country_select_has_action
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone"))
    assert_selector "select[data-action='change->fx-telephone#updateMask']"
  end

  def test_renders_with_value
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", value: "11999998888"))
    assert_selector "input[value='11999998888']"
  end

  def test_renders_with_placeholder
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", placeholder: "Enter phone"))
    assert_selector "input[placeholder='Enter phone']"
  end

  def test_renders_with_help_text
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", help_text: "Required field"))
    assert_text "Required field"
  end

  def test_renders_disabled
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", disabled: true))
    assert_selector "input[disabled]"
  end

  def test_renders_readonly
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", readonly: true))
    assert_selector "input[readonly]"
  end

  def test_renders_required
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", required: true))
    assert_selector ".required"
  end

  def test_type_is_forced_to_tel
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", type: :text))
    assert_selector "input[type='tel']"
  end

  def test_renders_with_color
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", color: :success))
    assert_selector "input"
  end

  def test_country_options_have_mask_data
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone"))
    assert_selector "option[data-mask]"
  end

  def test_country_options_have_dial_code_data
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone"))
    assert_selector "option[data-dial-code]"
  end

  def test_all_countries_are_rendered
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone"))
    Fluxbit::Form::TelephoneComponent::COUNTRIES.each do |country|
      assert_selector "option[value='#{country[:code]}']"
    end
  end

  def test_custom_country_field_name
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone", country_field_name: "custom_country"))
    assert_selector "select[name='custom_country']"
  end

  def test_input_has_flex_container
    render_inline(Fluxbit::Form::TelephoneComponent.new(name: "phone"))
    assert_selector "div.flex.w-full"
  end
end
