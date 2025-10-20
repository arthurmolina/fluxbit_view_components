# frozen_string_literal: true

class Fluxbit::Components::TabComponentPreview < ViewComponent::Preview
  # Fluxbit::TabComponent
  # ------------------------
  # You can use this component to display _a_ message to the user
  #
  # @param variant select "variant" :variant_options
  # @param color select "Color" :color_options
  # @param tab_panel select "Tab Panel" :tab_panel_options
  # @param align select "Alignment" :align_options
  # @param vertical [Boolean] toggle "vertical?"
  def playground(variant: :default, color: :blue, tab_panel: :default, align: :left, vertical: false)
    render Fluxbit::TabComponent.new(
      variant: variant,
      color: color,
      tab_panel: tab_panel,
      align: align,
      vertical: vertical,
    ) do |tabs|
      tabs.with_tab title: "Profile", active: true, icon: anyicon("heroicons_solid:user") do |content|
        'Profile details'
      end

      tabs.with_tab title: "Settings", icon: anyicon("heroicons_solid:pencil") do |content|
        'Settings details'
      end

      tabs.with_tab title: "Disabled", icon: anyicon("heroicons_solid:exclamation-triangle"), disabled: true
    end
  end

  def default; end
  def basic_tabs; end
  def underline_tabs; end
  def pills_tabs; end
  def full_width_tabs; end
  def vertical_tabs; end
  def tabs_with_icons; end
  def colored_tabs; end
  def navigation_only; end
  def disabled_tabs; end
  def tab_alignment; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def anyicon(icon = "heroicons_solid:user", **props)
    Anyicon::Icon.render icon, **props
  end

  def variant_options
    Fluxbit::Config::TabComponent.styles[:tab_list][:variant].keys
  end

  def color_options
    Fluxbit::Config::TabComponent.styles[:tab_list][:tab_item][:variant][:default][:active].keys
  end

  def tab_panel_options
    Fluxbit::Config::TabComponent.styles[:tabpanel][:horizontal].keys
  end

  def align_options
    Fluxbit::Config::TabComponent.styles[:tab_list][:align].keys
  end
end
