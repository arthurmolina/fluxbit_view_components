# frozen_string_literal: true

class Fluxbit::Components::SpinnerComponentPreview < ViewComponent::Preview
  # Default spinner with basic configuration
  def default
  end

  # Interactive playground for testing different configurations
  # @param color [Symbol] select { choices: [default, info, success, failure, warning, pink, purple] }
  # @param size [Integer] select { choices: [0, 1, 2, 3, 4] }
  # @param label [String] text
  def playground(color: :default, size: 1, label: "Loading...")
    render Fluxbit::SpinnerComponent.new(
      color: color,
      size: size,
      label: label
    )
  end

  # Different color variants
  def colors
  end

  # Different sizes
  def sizes
  end

  # Spinner in different contexts
  def in_buttons
  end

  # Spinner with cards
  def with_cards
  end

  # Custom labels and accessibility
  def custom_labels
  end

  # Adding custom classes
  def adding_removing_classes
  end

  # Additional HTML properties
  def adding_other_properties
  end
end