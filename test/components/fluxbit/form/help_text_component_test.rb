require "test_helper"

class Fluxbit::Form::HelpTextComponentTest < ViewComponent::TestCase
  def test_renders_default
    render_inline(Fluxbit::Form::HelpTextComponent.new) { "Some help text" }
    assert_selector "p", text: "Some help text"
  end

  def test_renders_with_info_color
    render_inline(Fluxbit::Form::HelpTextComponent.new(color: :info)) { "Info help" }
    assert_selector "p.text-cyan-600", text: "Info help"
  end

  def test_renders_with_success_color
    render_inline(Fluxbit::Form::HelpTextComponent.new(color: :success)) { "Success!" }
    assert_selector "p.text-green-600", text: "Success!"
  end

  def test_renders_with_failure_color
    render_inline(Fluxbit::Form::HelpTextComponent.new(color: :failure)) { "Failed" }
    assert_selector "p.text-red-600", text: "Failed"
  end

  def test_renders_with_warning_color
    render_inline(Fluxbit::Form::HelpTextComponent.new(color: :warning)) { "Careful!" }
    assert_selector "p.text-yellow-600", text: "Careful!"
  end

  def test_renders_with_custom_class
    render_inline(Fluxbit::Form::HelpTextComponent.new(class: "extra-help")) { "Extra help" }
    assert_selector "p.extra-help", text: "Extra help"
  end

  def test_renders_html_attributes
    render_inline(Fluxbit::Form::HelpTextComponent.new(id: "my-help")) { "Has ID" }
    assert_selector "p#my-help", text: "Has ID"
  end

  def test_ignores_invalid_color
    render_inline(Fluxbit::Form::HelpTextComponent.new(color: :foobar)) { "Fallback" }
    assert_selector "p.text-gray-500", text: "Fallback"
  end
end
