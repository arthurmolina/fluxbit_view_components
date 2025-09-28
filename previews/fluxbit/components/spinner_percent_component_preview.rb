# frozen_string_literal: true

class Fluxbit::Components::SpinnerPercentComponentPreview < ViewComponent::Preview
  # Default spinner percent with basic configuration
  def default
  end

  # Interactive playground for testing different configurations
  # @param color [Symbol] select { choices: [default, info, success, failure, warning, pink, purple] }
  # @param size [Integer] select { choices: [-1, 0, 1, 2, 3, 4] }
  # @param percent [Integer] range { min: 0, max: 100, step: 5 }
  # @param label [String] text
  # @param show_percent [Boolean] toggle
  # @param text [String] text
  # @param animate [Boolean] toggle
  # @param speed [Symbol] select { choices: [slow, normal, fast, very_fast] }
  def playground(color: :default, size: 1, percent: 0, label: "Loading...", show_percent: true, text: nil, animate: false, speed: :normal)
    render Fluxbit::SpinnerPercentComponent.new(
      color: color,
      size: size,
      percent: percent,
      label: label,
      show_percent: show_percent,
      text: text,
      animate: animate,
      speed: speed
    )
  end

  # Different color variants
  def colors
  end

  # Different sizes
  def sizes
  end

  # Different percentage values
  def percentages
  end

  # With and without percentage text
  def percentage_text_options
  end

  # SpinnerPercent in different contexts
  def in_cards
  end

  # SpinnerPercent with custom labels and accessibility
  def custom_labels
  end

  # Adding custom classes
  def adding_removing_classes
  end

  # Additional HTML properties
  def adding_other_properties
  end

  # JavaScript interaction examples
  def javascript_control
  end

  # Animation examples
  def animation_examples
  end
end