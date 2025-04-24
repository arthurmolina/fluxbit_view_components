# frozen_string_literal: true

class Fluxbit::Components::FlexComponentPreview < ViewComponent::Preview
  # Fluxbit::FlexComponent
  # ----------------------
  # This component is used to render a customizable flex container.
  # It allows you to control the flex direction, alignment, wrapping, gap,
  # and other layout properties. This is useful for creating responsive
  # and dynamic layouts.
  #
  # @param vertical [Boolean] toggle "vertical"
  # @param reverse [Boolean] toggle "reverse"
  # @param wrap [Boolean] toggle "wrap"
  # @param wrap_reverse [Boolean] toggle "wrap_reverse"
  # @param justify_content select "Justify Content" :justify_content_options
  # @param align_items select "Align Items" :align_items_options
  # @param gap select "Gap" :gap_options
  def default(vertical: false, reverse: false, justify_content: :center, align_items: :center, wrap: false, wrap_reverse: false, gap: 0)
    render_with_template(locals: { vertical: vertical, reverse: reverse, justify_content: justify_content, align_items: align_items, wrap: wrap, wrap_reverse: wrap_reverse, gap: gap })
  end

  private

  def justify_content_options
    Fluxbit::Config::FlexComponent.styles[:justify_content].keys
  end

  def align_items_options
    Fluxbit::Config::FlexComponent.styles[:align_items].keys
  end

  def gap_options
    (0..Fluxbit::Config::FlexComponent.styles[:gap].count-1).to_a
  end
end
