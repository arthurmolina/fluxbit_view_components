# frozen_string_literal: true

class Fluxbit::Components::CardComponentPreview < ViewComponent::Preview
  # @param color select "Color" :color_options
  # @param shadow [Boolean]
  # @param border [Boolean]
  # @param rounded [Boolean]
  # @param hoverable [Boolean]
  # @param href [String] text { description: "Link URL" }
  def default(color: :default, shadow: true, border: true, rounded: true, hoverable: false, href: nil)
    render Fluxbit::CardComponent.new(
      color: color,
      shadow: shadow,
      border: border,
      rounded: rounded,
      hoverable: hoverable,
      href: href.present? ? href : nil
    ) do |card|
      card.with_header do
        tag.h5 class: "text-xl font-bold tracking-tight text-gray-900 dark:text-white" do
          "Noteworthy technology acquisitions 2021"
        end
      end
      card.with_section do
        tag.p class: "font-normal text-gray-700 dark:text-gray-400" do
          "Here are the biggest enterprise technology acquisitions of 2021 so far, in reverse chronological order."
        end
      end
      card.with_footer do
        tag.small class: "text-gray-500 dark:text-gray-400" do
          "Last updated 3 mins ago"
        end
      end
    end
  end

  def basic_cards; end
  def colored_cards; end
  def cards_with_images; end
  def horizontal_cards; end
  def clickable_cards; end
  def hoverable_cards; end
  def minimal_cards; end
  def cards_with_sections; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def color_options
    Fluxbit::Config::CardComponent.styles[:colors].keys
  end
end
