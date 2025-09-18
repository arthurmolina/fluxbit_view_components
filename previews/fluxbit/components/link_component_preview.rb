# frozen_string_literal: true

class Fluxbit::Components::LinkComponentPreview < ViewComponent::Preview
  # @param color select "Color" :color_options
  # @param href [String] text { description: "Link URL" }
  def default(color: :primary, href: "#")
    render Fluxbit::LinkComponent.new(
      color: color,
      href: href.present? ? href : "#"
    ) do
      "Sample Link Text"
    end
  end

  def default_links; end
  def colored_links; end
  def links_with_attributes; end
  def external_links; end
  def links_in_text; end
  def navigation_links; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def color_options
    Fluxbit::Config::LinkComponent.styles[:colors].keys
  end
end
