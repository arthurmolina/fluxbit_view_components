require "test_helper"

class Fluxbit::Form::PasswordComponentTest < ViewComponent::TestCase
  def test_renders_basic
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", label: "Password"))
    assert_text "Password"
    assert_selector "input[type='password'][name='password']"
  end

  def test_renders_with_eye_icon
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password"))
    assert_selector "svg" # Eye icon should be present
    assert_selector "[data-fx-password-target='eyeIcon']"
    assert_selector "[data-fx-password-target='eyeSlashIcon']"
  end

  def test_has_stimulus_controller
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password"))
    assert_selector "[data-controller*='fx-password']"
  end

  def test_toggle_icon_is_clickable
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password"))
    assert_selector "[data-action*='click->fx-password#toggleVisibility']"
  end

  def test_validates_on_input
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password"))
    assert_selector "input[data-action*='input->fx-password#validate']"
  end

  def test_without_strength_indicator
    result = render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: false))
    assert_no_selector "[data-fx-password-target='strengthIndicator']"
  end

  def test_with_strength_indicator
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true))
    assert_selector "[data-fx-password-target='strengthIndicator']"
    assert_selector "[data-fx-password-target='strengthBar']"
  end

  def test_length_check_displayed
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, min_length: 8))
    assert_selector "[data-fx-password-target='checkLength']"
    assert_selector "[data-fx-password-min-length-value='8']"
  end

  def test_uppercase_check_displayed_when_required
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, require_uppercase: true))
    assert_selector "[data-fx-password-target='checkUppercase']"
  end

  def test_uppercase_check_not_displayed_when_not_required
    result = render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, require_uppercase: false))
    assert_no_selector "[data-fx-password-target='checkUppercase']"
  end

  def test_lowercase_check_displayed_when_required
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, require_lowercase: true))
    assert_selector "[data-fx-password-target='checkLowercase']"
  end

  def test_lowercase_check_not_displayed_when_not_required
    result = render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, require_lowercase: false))
    assert_no_selector "[data-fx-password-target='checkLowercase']"
  end

  def test_numbers_check_displayed_when_required
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, require_numbers: true))
    assert_selector "[data-fx-password-target='checkNumbers']"
  end

  def test_numbers_check_not_displayed_when_not_required
    result = render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, require_numbers: false))
    assert_no_selector "[data-fx-password-target='checkNumbers']"
  end

  def test_special_check_displayed_when_required
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, require_special: true))
    assert_selector "[data-fx-password-target='checkSpecial']"
  end

  def test_special_check_not_displayed_when_not_required
    result = render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, require_special: false))
    assert_no_selector "[data-fx-password-target='checkSpecial']"
  end

  def test_custom_min_length
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true, min_length: 12))
    assert_selector "[data-fx-password-min-length-value='12']"
  end

  def test_default_min_length
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", show_strength: true))
    assert_selector "[data-fx-password-min-length-value='8']"
  end

  def test_help_text
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", help_text: "Create a strong password"))
    assert_text "Create a strong password"
  end

  def test_disabled
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", disabled: true))
    assert_selector "input[disabled]"
  end

  def test_placeholder
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", placeholder: "Enter password"))
    assert_selector "input[placeholder='Enter password']"
  end

  def test_colors
    %i[default success danger warning info].each do |color|
      render_inline(Fluxbit::Form::PasswordComponent.new(name: "pwd#{color}", color: color))
      assert_selector ".border"
    end
  end

  def test_sizing
    (0..2).each do |size|
      render_inline(Fluxbit::Form::PasswordComponent.new(name: "pwd#{size}", sizing: size))
      assert_selector "input[name='pwd#{size}']"
    end
  end

  def test_custom_strength_labels
    custom_labels = {
      length: "Custom length message",
      uppercase: "Custom uppercase message",
      lowercase: "Custom lowercase message",
      numbers: "Custom numbers message",
      special: "Custom special message",
      strength: "Custom strength label"
    }

    render_inline(Fluxbit::Form::PasswordComponent.new(
      name: "password",
      show_strength: true,
      require_special: true,
      strength_labels: custom_labels
    ))

    assert_text "Custom length message"
    assert_text "Custom uppercase message"
    assert_text "Custom lowercase message"
    assert_text "Custom numbers message"
    assert_text "Custom special message"
    assert_text "Custom strength label"
  end

  def test_data_attributes_for_requirements
    render_inline(Fluxbit::Form::PasswordComponent.new(
      name: "password",
      show_strength: true,
      require_uppercase: true,
      require_lowercase: false,
      require_numbers: true,
      require_special: false
    ))

    assert_selector "[data-fx-password-require-uppercase-value='true']"
    assert_selector "[data-fx-password-require-lowercase-value='false']"
    assert_selector "[data-fx-password-require-numbers-value='true']"
    assert_selector "[data-fx-password-require-special-value='false']"
  end

  def test_maxlength_attribute
    render_inline(Fluxbit::Form::PasswordComponent.new(name: "password", maxlength: 20))
    assert_selector "input[maxlength='20']"
  end
end
