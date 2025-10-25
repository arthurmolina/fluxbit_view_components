# frozen_string_literal: true

class Fluxbit::Form::RadioGroupButtonComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::RadioGroupButtonComponent
  # ------------------------
  # You can use this component to display a radio button group styled as buttons
  #
  # @param color select "Color" :color_options
  # @param size select "Size" :size_options
  # @param pill [Boolean] toggle "Pill"
  def playground(color: :default, size: '1', pill: false)
    render Fluxbit::Form::RadioGroupButtonComponent.new(
      name: "view_mode",
      color: color,
      size: size.to_i,
      pill: pill
    ) do |radio|
      radio.with_radio_option(value: "list", checked: true) { "List View" }
      radio.with_radio_option(value: "grid") { "Grid View" }
      radio.with_radio_option(value: "table") { "Table View" }
    end
  end

  def basic_radio_group; end
  def colored_radio_groups; end
  def sized_radio_groups; end
  def pill_radio_groups; end
  def with_icons; end
  def with_disabled; end

  private

  def color_options
    Fluxbit::Config::ButtonComponent.styles[:colors].keys
  end

  def size_options
    (0..Fluxbit::Config::ButtonComponent.styles[:size].count - 1).map(&:to_s)
  end
end
