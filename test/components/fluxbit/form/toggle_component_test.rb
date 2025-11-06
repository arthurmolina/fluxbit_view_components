require "test_helper"

class Fluxbit::Form::ToggleComponentTest < ViewComponent::TestCase
  def test_renders_default_toggle
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "notify"))
    assert_selector "input[type='checkbox'][name='notify'].sr-only.peer"
    assert_selector "span"
  end

  def test_renders_with_label
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "terms", label: "Accept terms"))
    assert_text "Accept terms"
  end

  def test_renders_with_other_label
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "status", label: "Label", other_label: "Other label"))
    assert_text "Other label"
  end

  def test_renders_with_invert_label
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "active", label: "Active", invert_label: true))
    assert_selector ".ms-3"
    assert_text "Active"
  end

  def test_renders_with_help_text
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "visible", help_text: "Will be shown"))
    assert_text "Will be shown"
  end

  def test_renders_disabled
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "promo", disabled: true))
    assert_selector "input[disabled]"
    assert_selector ".opacity-50"
  end

  def test_renders_with_custom_color
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "danger", color: :danger))
    assert_selector "span", class: /bg-red-600|peer-checked:bg-red-600/
  end

  def test_renders_with_unchecked_color
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "info", unchecked_color: :info))
    assert_selector "span", class: /bg-cyan-600/
  end

  def test_renders_with_button_color
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "special", button_color: :success))
    assert_selector "span", class: /after:bg-green-500/
  end

  def test_renders_with_custom_sizing
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "huge", sizing: 2))
    assert_selector "span.w-14.h-7"
  end

  def test_renders_with_custom_class
    render_inline(Fluxbit::Form::ToggleComponent.new(name: "tag", class: "toggle-custom"))
    assert_selector "input.toggle-custom"
  end

  def test_does_not_wrap_checkbox_with_field_with_errors_div
    # Create a mock object with errors
    user_class = Struct.new(:enabled, :errors) do
      def self.model_name
        ActiveModel::Name.new(self, nil, "User")
      end

      def self.name
        "User"
      end

      def self.human_attribute_name(attr, options = {})
        attr.to_s.humanize
      end
    end

    user = user_class.new(false, ActiveModel::Errors.new(user_class.new))
    user.errors.add(:enabled, "must be accepted")

    # Create a form builder
    form = ActionView::Helpers::FormBuilder.new(:user, user, vc_test_controller.view_context, {})

    render_inline(Fluxbit::Form::ToggleComponent.new(form: form, attribute: :enabled, label: "Enable"))

    # Should NOT have field_with_errors wrapper around the checkbox
    refute_selector "div.field_with_errors input[type='checkbox']"

    # Should have the checkbox directly in the label
    assert_selector "label > input[type='checkbox'][name='user[enabled]']"

    # Should still display the error in help text
    assert_text "must be accepted"
  end

  def test_checkbox_without_wrapper_with_form_and_no_errors
    user_class = Struct.new(:enabled) do
      def self.model_name
        ActiveModel::Name.new(self, nil, "User")
      end

      def self.name
        "User"
      end

      def self.human_attribute_name(attr, options = {})
        attr.to_s.humanize
      end

      def errors
        ActiveModel::Errors.new(self)
      end
    end

    user = user_class.new(true)

    form = ActionView::Helpers::FormBuilder.new(:user, user, vc_test_controller.view_context, {})

    render_inline(Fluxbit::Form::ToggleComponent.new(form: form, attribute: :enabled, label: "Enable"))

    # Should render checkbox normally
    assert_selector "label > input[type='checkbox'][name='user[enabled]']"
    refute_selector "div.field_with_errors"
  end
end
