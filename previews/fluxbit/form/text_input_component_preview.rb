# frozen_string_literal: true

class Fluxbit::Form::TextInputComponentPreview < ViewComponent::Preview
  # Renders a basic text input.
  def default
    render(Fluxbit::Form::TextInputComponent.new(
      label: "Full Name",
      name: "full_name",
      placeholder: "Enter your full name",
      helper_text: "Helper text",
      helper_popover: "Helper popover",
      color: :failure,
      shadow: true
    ))
  end

  # Renders a text input that displays error messages.
  def with_errors
    render(Fluxbit::Form::TextInputComponent.new(
      label: "Email",
      name: "email",
      placeholder: "Enter your email address",
      errors: [ "is invalid", "cannot be blank" ]
    ))
  end
end
