# frozen_string_literal: true

class Fluxbit::Form::HelpTextComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::HelpTextComponent
  # --------------------------------
  # You can use this component to display helper text with various color schemes for different message types
  #
  # @param content [String] "The help text content to display"
  # @param color select "Color scheme" :color_options
  def playground(
    content: "Your password must be at least 8 characters long and contain at least one number.",
    color: :default)
    render Fluxbit::Form::HelpTextComponent.new(
      color: color
    ).with_content(content)
  end

  def default_help_text; end
  def color_states; end
  def success_messages; end
  def error_messages; end
  def warning_messages; end
  def info_messages; end
  def multiline_text; end
  def with_form_fields; end
  def rich_content; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def color_options
    Fluxbit::Config::Form::HelpTextComponent.styles[:colors].keys
  end
end
