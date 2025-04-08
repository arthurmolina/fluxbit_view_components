class Fluxbit::BadgeComponentPreview < ViewComponent::Preview
  # Fluxbit::BadgeComponent
  # ------------------------
  # You can use this component to display a message to the user
  #
  # @param color select "Color" :color_options
  # @param pill [Boolean] toggle "Pill"
  # @param size select "Size" :size_options
  # @param perfect_rounded select "Perfect Rounded" :perfect_rounded_options
  # @param content text "Content"
  def playground(color: :info, pill: false, size: 0, perfect_rounded: 0, content: 'Playground Badge')
    render Fluxbit::BadgeComponent.new(
      color: color,
      pill: pill,
      perfect_rounded: perfect_rounded.to_i,
      size: size.to_i
    ).with_content(content)
  end

  def default_badges; end
  def badge_pills; end
  def badge_sizes; end
  def badge_link; end
  def badge_with_icon; end
  def badge_with_icon_only; end
  def notification_badge; end
  def button_with_badge; end
  def with_popover; end
  def with_tooltip; end
  def dismissible_badges; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def color_options
    Fluxbit::Config::BadgeComponent.styles[:colors].keys
  end

  def size_options
    (0..Fluxbit::Config::BadgeComponent.styles[:sizes].count - 1).map(&:to_s)
  end

  def perfect_rounded_options
    (0..Fluxbit::Config::BadgeComponent.styles[:perfect_rounded].count - 1).map(&:to_s)
  end
end
