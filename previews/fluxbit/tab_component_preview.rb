# frozen_string_literal: true

class Fluxbit::TabComponentPreview < ViewComponent::Preview
  # Fluxbit::TabComponent
  # ------------------------
  # You can use this component to display _a_ message to the user
  #
  # @param variant select "variant" :variant_options
  # @param color select "Color" :color_options
  # @param tab_panel select "Tab Panel" :tab_panel_options
  # @param vertical [Boolean] toggle "vertical?"
  def playground(variant: :default, color: :blue, tab_panel: :default, vertical: false)
    render Fluxbit::TabComponent.new(
      variant: variant,
      color: color,
      tab_panel: tab_panel,
      vertical: vertical,
    ) do |tabs|
      tabs.with_tab title: "Profile", active: true, icon: anyicon(icon: "heroicons_solid:user") do |content|
        'Profile details'
      end

      tabs.with_tab title: "Settings", icon: anyicon(icon: "heroicons_solid:pencil") do |content|
        'Settings details'
      end

      tabs.with_tab title: "Disabled", icon: anyicon(icon: "heroicons_solid:exclamation-triangle"), disabled: true
    end
  end

  def default; end
  def underline; end
  def pills; end
  def full_width; end
  def all_colors; end

  private

  def anyicon(icon: "heroicons_solid:user", **props)
    Anyicon::Icon.render icon: icon, **props
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
end
