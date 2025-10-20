# frozen_string_literal: true

class Fluxbit::Components::ButtonComponentPreview < ViewComponent::Preview
  # Fluxbit::ButtonComponent
  # ------------------------
  # You can use this component to display a message to the user
  #
  # @param color select "Color" :color_options
  # @param pill [Boolean] toggle "Pill"
  # @param size select "size" :size_options
  # @param selected [Boolean] toggle "Selected"
  def playground(color: :default, pill: false, size: '1', selected: false)
    render Fluxbit::ButtonComponent.new(
      color: color,
      pill: pill,
      size: size.to_i,
      selected: selected,
      class: 'w-full'
    ).with_content("A button")
  end

  def default_buttons; end
  def button_pills; end
  def gradient_monochrome; end
  def gradient_duotone; end
  def outline_buttons; end
  def button_sizes; end
  def disabled_buttons; end
  def selected_buttons; end
  def with_popover; end
  def with_tooltip; end
  def button_with_icon; end
  def adding_removing_classes; end
  def adding_other_properties; end
  def override_button_base_component; end
  def button_group; end

  private

  def color_options
    Fluxbit::Config::ButtonComponent.styles[:colors].keys
  end

  def size_options
    (0..Fluxbit::Config::ButtonComponent.styles[:size].count - 1).map(&:to_s)
  end
end
