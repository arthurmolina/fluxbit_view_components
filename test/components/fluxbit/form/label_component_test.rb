require "test_helper"

class Fluxbit::Form::LabelComponentTest < ViewComponent::TestCase
  def test_renders_with_content
    render_inline(Fluxbit::Form::LabelComponent.new) { "First Name" }
    assert_selector "label", text: "First Name"
  end

  def test_renders_with_content_param
    render_inline(Fluxbit::Form::LabelComponent.new(with_content: "Username"))
    assert_selector "label", text: "Username"
  end

  def test_renders_with_help_text
    render_inline(Fluxbit::Form::LabelComponent.new(with_content: "E-mail", help_text: "Used for notifications"))
    assert_text "Used for notifications"
  end

  def test_renders_with_array_help_text
    render_inline(Fluxbit::Form::LabelComponent.new(with_content: "Field", help_text: [ "First hint", "Second hint" ]))
    assert_text "First hint"
    assert_text "Second hint"
  end

  def test_renders_with_color
    render_inline(Fluxbit::Form::LabelComponent.new(with_content: "Nome", color: :success))
    assert_selector "label.text-green-700"
  end

  def test_renders_with_custom_size
    render_inline(Fluxbit::Form::LabelComponent.new(with_content: "Big Label", sizing: 2))
    assert_selector "label.text-lg"
  end

  def test_renders_with_helper_popover
    render_inline(Fluxbit::Form::LabelComponent.new(with_content: "Field", helper_popover: "More info"))
    assert_selector "span[data-popover-target]", text: ""
    assert_text "More info"
  end

  def test_renders_with_custom_classes
    render_inline(Fluxbit::Form::LabelComponent.new(with_content: "Title", class: "my-custom-label"))
    assert_selector "label.my-custom-label", text: "Title"
  end

  def test_renders_popover_with_custom_placement
    render_inline(Fluxbit::Form::LabelComponent.new(with_content: "Info", helper_popover: "Tip", helper_popover_placement: "bottom"))
    assert_selector "span[data-popover-placement='bottom']"
  end
end
