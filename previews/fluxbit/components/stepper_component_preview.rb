# frozen_string_literal: true

class Fluxbit::Components::StepperComponentPreview < ViewComponent::Preview
  # Fluxbit::StepperComponent
  # -------------------------
  # You can use this component to create a visual representation of a multi-step process
  #
  # @param orientation select "Orientation" :orientation_options
  # @param variant select "Variant" :variant_options
  # @param color select "Color" :color_options
  def playground(orientation: :horizontal, variant: :default, color: :blue)
    render Fluxbit::StepperComponent.new(
      orientation: orientation,
      variant: variant,
      color: color
    ) do |stepper|
      stepper.with_step(
        title: "Personal Info",
        description: "Provide your personal details",
        state: :completed,
        number: "1"
      )
      stepper.with_step(
        title: "Account Info",
        description: "Create your account",
        state: :active,
        number: "2"
      )
      stepper.with_step(
        title: "Confirmation",
        description: "Review and confirm",
        state: :pending,
        number: "3"
      )
    end
  end

  def default_horizontal; end
  def vertical_stepper; end
  def different_colors; end
  def completed_steps; end
  def step_states; end
  def with_descriptions; end
  def custom_numbers; end
  def progress_variant; end
  def detailed_variant; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def orientation_options
    [:horizontal, :vertical]
  end

  def variant_options
    [:default, :progress, :detailed]
  end

  def color_options
    [:blue, :green, :red, :yellow, :indigo, :purple]
  end
end