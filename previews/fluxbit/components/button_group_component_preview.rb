# frozen_string_literal: true

class Fluxbit::Components::ButtonGroupComponentPreview < ViewComponent::Preview
  # Fluxbit::ButtonGroupComponent
  # ------------------------
  # You can use this component to display _grouped_ buttons to the user
  #
  # @param color select "Color" :color_options
  # @param size select "Size" :size_options
  # @param pill [Boolean] toggle "Pill Shape?"
  # @param disabled [Boolean] toggle "Disabled?"
  def playground(color: :default, size: 1, pill: false, disabled: false)
    render Fluxbit::ButtonGroupComponent.new do |group|
      group.with_button(color: color, size: size, pill: pill, disabled: disabled) do
        "First Button"
      end

      group.with_button(color: color, size: size, pill: pill, disabled: disabled) do
        "Second Button"
      end

      group.with_button(color: color, size: size, pill: pill, disabled: disabled) do
        "Third Button"
      end
    end
  end

  def default; end
  def basic_groups; end
  def outlined_groups; end
  def groups_with_icons; end
  def different_sizes; end
  def toolbar_style; end
  def navigation_groups; end
  def mixed_button_types; end
  def active_states; end
  def disabled_buttons; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def anyicon(icon = "heroicons_solid:user", **props)
    Anyicon::Icon.render icon, **props
  end

  def color_options
    Fluxbit::Config::ButtonComponent.styles[:colors].keys
  end

  def size_options
    (0...Fluxbit::Config::ButtonComponent.styles[:size].size).to_a
  end
end
