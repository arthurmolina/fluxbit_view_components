# frozen_string_literal: true

class Fluxbit::Components::ProgressComponentPreview < ViewComponent::Preview
  # Interactive playground
  # @param progress [Integer] select { choices: [0, 25, 45, 60, 75, 100] }
  # @param color [Symbol] select { choices: [default, dark, blue, red, green, yellow, indigo, purple, cyan, gray, lime, pink, teal] }
  # @param size [Integer] select { choices: [0, 1, 2, 3] }
  # @param text_label [String] text
  # @param label_progress [Boolean] toggle
  # @param label_text [Boolean] toggle
  # @param progress_label_position [Symbol] select { choices: [inside, outside] }
  # @param text_label_position [Symbol] select { choices: [inside, outside] }
  def playground(
    progress: 45,
    color: :default,
    size: 1,
    text_label: "Flowbite",
    label_progress: true,
    label_text: true,
    progress_label_position: :inside,
    text_label_position: :outside
  )
    render Fluxbit::ProgressComponent.new(
      progress: progress,
      color: color,
      size: size,
      text_label: text_label,
      label_progress: label_progress,
      label_text: label_text,
      progress_label_position: progress_label_position,
      text_label_position: text_label_position
    )
  end

  # Default progress bars
  def default; end

  # Progress colors
  def progress_colors; end

  # Progress sizes
  def progress_sizes; end

  # Progress with outside labels
  def progress_with_outside_labels; end

  # Progress with inside labels
  def progress_with_inside_labels; end

  # Progress with mixed label positions
  def progress_with_mixed_labels; end

  # Adding and removing classes
  def adding_removing_classes; end

  # Adding other properties
  def adding_other_properties; end

  # Interactive JavaScript controls
  def interactive_javascript; end
end