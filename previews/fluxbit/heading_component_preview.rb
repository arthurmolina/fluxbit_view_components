# frozen_string_literal: true

class Fluxbit::HeadingComponentPreview < ViewComponent::Preview
  # Fluxbit::HeadingComponent
  # ------------------------
  # You can use this component to display _a_ message to the user
  #
  # @param size select "Sizes" :size_options
  # @param spacing select "Letter spacing" :spacing_options
  # @param line_height select "Line height" :line_height_options
  def playground(size: 1, spacing: :tight, line_height: :none)
    render Fluxbit::HeadingComponent.new(
      size: size,
      spacing: spacing,
      line_height: line_height,
    ).with_content("My Header")
  end

  def heading_sizes; end
  def heading_spacing; end
  def heading_line_height; end
  def adding_other_attributes; end

  private

  def size_options
    (1..6).to_a
  end

  def spacing_options
    Fluxbit::Config::HeadingComponent.styles[:spacings].keys
  end

  def line_height_options
    Fluxbit::Config::HeadingComponent.styles[:line_heights].keys
  end
end
