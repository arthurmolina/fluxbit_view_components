class Fluxbit::Components::BottomNavigationComponentPreview < ViewComponent::Preview
  # Fluxbit::BottomNavigationComponent
  # ------------------------------------
  # You can use this component to create a fixed bottom navigation bar
  # Note: Number of columns is automatically calculated based on the number of items
  #
  # @param variant [Symbol] select { choices: [default, app_bar] }
  # @param border [Boolean] toggle "Show Border"
  # @param show_cta [Boolean] toggle "Show CTA Button (App Bar Only)"
  # @param show_tooltips [Boolean] toggle "Show Tooltips"
  def playground(variant: :default, border: true, show_cta: false, show_tooltips: false)
    render Fluxbit::BottomNavigationComponent.new(
      variant: variant,
      border: border
    ) do |nav|
      if variant == :app_bar && show_cta
        nav.with_item(href: "/", icon: "heroicons_solid:home", active: true, tooltip_text: (show_tooltips ? "Home" : nil)) { "Home" }
        nav.with_item(href: "/wallet", icon: "heroicons_solid:wallet", tooltip_text: (show_tooltips ? "Wallet" : nil)) { "Wallet" }
        nav.with_cta(href: "/new", icon: "heroicons_solid:plus", tooltip_text: (show_tooltips ? "Create New" : nil)) { "New Item" }
        nav.with_item(href: "/settings", icon: "heroicons_solid:cog-6-tooth", tooltip_text: (show_tooltips ? "Settings" : nil)) { "Settings" }
        nav.with_item(href: "/profile", icon: "heroicons_solid:user", tooltip_text: (show_tooltips ? "Profile" : nil)) { "Profile" }
      else
        nav.with_item(href: "/", icon: "heroicons_solid:home", active: true, tooltip_text: (show_tooltips ? "Home" : nil)) { "Home" }
        nav.with_item(href: "/wallet", icon: "heroicons_solid:wallet", tooltip_text: (show_tooltips ? "Wallet" : nil)) { "Wallet" }
        nav.with_item(href: "/settings", icon: "heroicons_solid:cog-6-tooth", tooltip_text: (show_tooltips ? "Settings" : nil)) { "Settings" }
        nav.with_item(href: "/profile", icon: "heroicons_solid:user", tooltip_text: (show_tooltips ? "Profile" : nil)) { "Profile" }
      end
    end
  end

  def default; end
  def app_bar_variant; end
  def without_border; end
  def three_columns; end
  def five_columns; end
  def with_active_item; end
  def with_tooltips; end
  def without_icons; end
  def with_pagination; end
  def button_group_bottom_bar; end
  def meeting_control_bar; end
  def adding_removing_classes; end
  def adding_other_properties; end
end
