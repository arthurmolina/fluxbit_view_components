# frozen_string_literal: true

class Fluxbit::Form::LabelComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::LabelComponent
  # --------------------------------
  # You can use this component to create accessible form labels with various color schemes, sizes, and helper features
  #
  # @param content [String] "The label text to display"
  # @param color select "Color scheme" :color_options
  # @param sizing select "Label size" :sizing_options
  # @param help_text [String] "Help text to show below the label"
  # @param helper_popover [String] "Content for helper popover"
  # @param helper_popover_placement select "Popover placement" :placement_options
  def playground(
    content: "Email Address",
    color: :default,
    sizing: 1,
    help_text: "We'll use this to send you important updates",
    helper_popover: "This should be a valid email address that you check regularly",
    helper_popover_placement: "right")
    render Fluxbit::Form::LabelComponent.new(
      color: color,
      sizing: sizing,
      help_text: help_text.present? ? help_text : nil,
      helper_popover: helper_popover.present? ? helper_popover : nil,
      helper_popover_placement: helper_popover_placement,
      for: "email_field"
    ).with_content(content)
  end

  def basic_labels; end
  def label_sizes; end
  def color_variations; end
  def with_help_text; end
  def with_helper_popover; end
  def multiple_help_text; end
  def popover_placements; end
  def complete_form_field; end
  def validation_states; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def color_options
    Fluxbit::Config::Form::LabelComponent.styles[:colors].keys
  end

  def sizing_options
    (0...Fluxbit::Config::Form::LabelComponent.styles[:sizes].count).to_a
  end

  def placement_options
    %w[top right bottom left]
  end
end