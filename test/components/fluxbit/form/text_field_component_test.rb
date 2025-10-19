require "test_helper"
require "ostruct"

class Fluxbit::Form::TextFieldComponentTest < ViewComponent::TestCase
  def test_renders_basic
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "username", label: "Username"))
    assert_text "Username"
    assert_selector "input[name='username']"
  end

  def test_renders_placeholder
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "nickname", placeholder: "Type here"))
    assert_selector "input[placeholder='Type here']"
  end

  def test_placeholder_disabled_with_false
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "nickname", placeholder: false))
    assert_no_selector "input[placeholder]"
  end

  def test_placeholder_explicit_overrides_i18n
    # Even if I18n is set up, an explicit placeholder value should be used
    render_inline(Fluxbit::Form::TextFieldComponent.new(
      name: "email",
      placeholder: "Custom placeholder"
    ))

    assert_selector "input[placeholder='Custom placeholder']"
  end

  def test_no_placeholder_when_not_provided
    # When no placeholder is provided and no I18n is available, no placeholder should be rendered
    result = render_inline(Fluxbit::Form::TextFieldComponent.new(name: "email"))

    # The input should be rendered but without a placeholder attribute (or empty placeholder)
    assert_selector "input[name='email']"
    refute_match /placeholder=["'][^"']+["']/, result.to_html
  end

  def test_renders_value
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "first_name", value: "Arthur"))
    assert_selector "input[value='Arthur']"
  end

  def test_multiline_renders_textarea
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "bio", multiline: true))
    assert_selector "textarea[name='bio']"
  end

  def test_type_email
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "user_email", type: :email))
    assert_selector "input[type='email']"
  end

  def test_with_icon
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "email", icon: :mail))
    assert_selector ".pl-10"
  end

  def test_with_right_icon
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "email", right_icon: :eye))
    assert_selector ".pr-10"
  end

  def test_with_addon
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "amount", addon: "heroicons_solid:check"))
    assert_selector "svg[data-slot]"
  end

  def test_disabled
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "disabled_field", disabled: true))
    assert_selector "input[disabled]"
  end

  def test_help_text
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "username", help_text: "Required"))
    assert_text "Required"
  end

  def test_colors
    %i[default success danger warning info].each do |color|
      render_inline(Fluxbit::Form::TextFieldComponent.new(name: "c#{color}", color: color))
      assert_selector ".border"
    end
  end

  def test_sizing
    (0..2).each do |size|
      render_inline(Fluxbit::Form::TextFieldComponent.new(name: "s#{size}", sizing: size))
      assert_selector ("input[name=\"s#{size}\"]." + Fluxbit::Config::Form::TextFieldComponent.styles[:sizes][size].gsub(":", "\\:").gsub(".", "\\.").gsub(" ", "."))
    end
  end
end
