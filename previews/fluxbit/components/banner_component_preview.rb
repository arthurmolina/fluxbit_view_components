# frozen_string_literal: true

class Fluxbit::Components::BannerComponentPreview < ViewComponent::Preview
  # Fluxbit::BannerComponent
  # ------------------------
  # You can use this component to display important information or announcements to users
  #
  # @param position select "Position" :position_options
  # @param color select "Color" :color_options
  # @param icon text
  # @param dismissible [Boolean] toggle "Dismissible?"
  # @param full_width [Boolean] toggle "Full width?"
  def playground(position: :top, color: :info, icon: :default, dismissible: true, full_width: true)
    render Fluxbit::BannerComponent.new(
      position: position,
      color: color,
      icon: icon,
      dismissible: dismissible,
      full_width: full_width
    ).with_content("We use cookies to make your experience better. By using our site, you accept our use of cookies.")
  end

  def default_banner; end
  def sticky_banners; end
  def marketing_banner; end
  def newsletter_banner; end
  def informational_banner; end
  def banner_colors; end
  def banner_without_icon; end
  def banner_with_cta; end
  def banner_with_logo; end
  def adding_other_properties; end
  def adding_removing_classes; end

  private

  def position_options
    Fluxbit::Config::BannerComponent.styles[:positions].keys
  end

  def color_options
    Fluxbit::Config::BannerComponent.styles[:colors].keys
  end
end
