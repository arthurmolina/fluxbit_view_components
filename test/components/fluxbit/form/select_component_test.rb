require "test_helper"

class Fluxbit::Form::SelectComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::FormOptionsHelper

  def test_renders_basic_select
    render_inline(Fluxbit::Form::SelectComponent.new(name: "role", options: [ "Admin", "User", "Guest" ]))
    assert_selector "select[name='role']"
    assert_selector "option", text: "Admin"
    assert_selector "option", text: "User"
    assert_selector "option", text: "Guest"
  end

  def test_renders_with_label
    render_inline(Fluxbit::Form::SelectComponent.new(name: "color", label: "Choose color", options: %w[Red Green Blue]))
    assert_text "Choose color"
    assert_selector "option", text: "Red"
    assert_selector "option", text: "Green"
    assert_selector "option", text: "Blue"
  end

  def test_renders_with_grouped_options
    grouped = { "Fruits" => [ [ "Apple", 1 ], [ "Banana", 2 ] ], "Vegetables" => [ [ "Carrot", 3 ], [ "Lettuce", 4 ] ] }
    render_inline(Fluxbit::Form::SelectComponent.new(name: "food", grouped: true, options: grouped))
    assert_selector "optgroup[label='Fruits']"
    assert_selector "option", text: "Apple"
    assert_selector "optgroup[label='Vegetables']"
    assert_selector "option", text: "Carrot"
  end

  def test_renders_with_time_zone
    render_inline(Fluxbit::Form::SelectComponent.new(name: "timezone", time_zone: true))
    assert_selector "option", text: /UTC|Eastern|Pacific/
  end

  def test_renders_with_select_options
    render_inline(Fluxbit::Form::SelectComponent.new(name: "lang", options: %w[en pt es], prompt: "Select language"))
    assert_selector "option", text: "Select language"
  end

  def test_renders_with_disabled_options
    render_inline(Fluxbit::Form::SelectComponent.new(
      name: "choice",
      options: options_for_select(%w[A B C], disabled: [ "B" ])
    ))
    assert_selector "option[disabled]", text: "B"
  end

  def test_renders_with_selected_option
    render_inline(Fluxbit::Form::SelectComponent.new(
      name: "pets",
      options: options_for_select(%w[Dog Cat Bird], selected: "Cat")
    ))
    assert_selector "option[selected]", text: "Cat"
  end

  def test_renders_with_prompt
    render_inline(Fluxbit::Form::SelectComponent.new(name: "number", options: [ 1, 2, 3 ], prompt: "Choose a number"))
    assert_selector "option", text: "Choose a number"
  end

  def test_prompt_disabled_with_false
    render_inline(Fluxbit::Form::SelectComponent.new(name: "number", options: [ 1, 2, 3 ], prompt: false))
    refute_selector "option[value='']"
  end

  def test_prompt_explicit_overrides_i18n
    # Even if I18n is set up, an explicit prompt value should be used
    render_inline(Fluxbit::Form::SelectComponent.new(
      name: "status",
      options: [ "Active", "Inactive" ],
      prompt: "Custom prompt"
    ))

    assert_selector "option", text: "Custom prompt"
  end

  def test_no_prompt_when_not_provided
    # When no prompt is provided and no I18n is available, no prompt should be rendered
    result = render_inline(Fluxbit::Form::SelectComponent.new(name: "status", options: [ "Active", "Inactive" ]))

    # Check that there's no empty value option (which would be the prompt)
    refute_match /<option value="">(?!Active|Inactive)/, result.to_html
  end

  def test_renders_with_custom_class
    render_inline(Fluxbit::Form::SelectComponent.new(name: "country", options: %w[BR US], class: "my-select"))
    assert_selector "select.my-select"
  end
end
