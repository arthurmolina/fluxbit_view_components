# frozen_string_literal: true

class Fluxbit::Form::CheckBoxComponentPreview < ViewComponent::Preview
  # Fluxbit::CheckBoxComponent
  # --------------------------
  #
  # @param id [String] "The id of the input element (optional)"
  # @param label [String] "The label for the input field (optional)"
  # @param help_text [String] "Additional help text for the input field (optional)"
  # @param helper_popover [String] "Content for a popover helper (optional)"
  # @param helper_popover_placement select "Placement of the popover (default: right)" :helper_popover_placement_options
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param value [String] "Value for the field (optional)"
  # @param type select "Type" :type_options
  # @param disabled [Boolean] toggle "Disables the input if true"
  # @param checked [Boolean] toggle "Marks the input as checked if true"
  def playground(
    id: 'text_field_playground', label: "Full Name",
    help_text: "Help text", helper_popover: "Helper popover", helper_popover_placement: "right",
    name: "full_name", value: nil, type: :text,
    disabled: false, checked: false)
    render Fluxbit::Form::CheckBoxComponent.new(
      id: id,
      label: label,
      help_text: help_text,
      helper_popover: helper_popover,
      helper_popover_placement: helper_popover_placement,
      name: name,
      value: value,
      type: type,
      disabled: disabled,
      checked: checked,
    )
  end

  # Renders a basic text input.
  def default
    render(Fluxbit::Form::CheckBoxComponent.new(
      label: "Full Name",
      name: "full_name",
      placeholder: "Enter your full name",
      help_text: "Help text",
      helper_popover: "Helper popover",
      color: :failure,
      shadow: true
    ))
  end

  # Renders a text input that displays error messages.
  def with_errors
    render(Fluxbit::Form::CheckBoxComponent.new(
      label: "Email",
      name: "email",
      placeholder: "Enter your email address",
      errors: [ "is invalid", "cannot be blank" ]
    ))
  end

  private

  def color_options
    Fluxbit::Config::Form::TextFieldComponent.styles[:text].keys
  end

  def type_options
    Fluxbit::Form::CheckBoxComponent::TYPE_OPTIONS
  end

  def icon_options
    [ nil ] + %w[heroicons_solid:eye heroicons_solid:user heroicons_solid:check heroicons_solid:pencil heroicons_solid:x-mark]
  end

  def helper_popover_placement_options
    %w[top right bottom left]
  end
end
