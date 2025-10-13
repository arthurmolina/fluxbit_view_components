# frozen_string_literal: true

class Fluxbit::Components::ThemeButtonComponentPreview < ViewComponent::Preview
  # Fluxbit::ThemeButtonComponent
  # ------------------------
  # A round button that toggles between dark, light, and system themes.
  # Click the button to cycle through the available themes.
  #
  # @param color select "Color" :color_options
  # @param size select "size" :size_options
  def playground(color: :transparent, size: '2')
    render Fluxbit::ThemeButtonComponent.new(
      color: color,
      size: size.to_i
    )
  end

  # Default theme button
  # ----
  # The theme button with default styling (transparent, round, size 2).
  def default; end

  # Theme button with tooltip
  # ----
  # Shows the theme button with a tooltip indicating the current action.
  def with_tooltip; end

  # Theme button sizes
  # ----
  # Different sizes for the theme button.
  def sizes; end

  # Theme button colors
  # ----
  # Different color variants for the theme button.
  def colors; end

  private

  def color_options
    Fluxbit::Config::ButtonComponent.styles[:colors].keys
  end

  def size_options
    (0..Fluxbit::Config::ButtonComponent.styles[:size].count - 1).map(&:to_s)
  end
end
