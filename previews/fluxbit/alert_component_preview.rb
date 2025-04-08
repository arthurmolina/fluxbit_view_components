# frozen_string_literal: true

class Fluxbit::AlertComponentPreview < ViewComponent::Preview
  # Fluxbit::AlertComponent
  # ------------------------
  # You can use this component to display _a_ message to the user
  #
  # @param color select "Color" :color_options
  # @param icon text
  # @param can_close [Boolean] toggle "Can close?"
  # @param fade_in_animation [Boolean] toggle "Fade In Animation"
  # @param out_animation select "Out Animation" :out_animation_options
  # @param dismiss_timeout [Integer] "Dismiss timeout"
  # @param all_rounded [Boolean] toggle "All rounded?"
  def playground(color: :info, icon: :default, can_close: true, fade_in_animation: true, out_animation: :fade_out,
                 dismiss_timeout: 0, all_rounded: true)
    render Fluxbit::AlertComponent.new(
      color: color,
      icon: icon,
      can_close: can_close,
      dismiss_timeout: dismiss_timeout,
      fade_in_animation: fade_in_animation,
      out_animation: out_animation,
      all_rounded: all_rounded
    ).with_content("Alert")
  end

  def default_alerts; end
  def alert_without_icon; end
  def alert_with_icon; end
  def alert_with_list; end
  def dismissing_timeout; end
  def dismissing_animation; end
  def additional_content; end
  def adding_other_properties; end
  def adding_removing_classes; end

  private

  def color_options
    Fluxbit::Config::AlertComponent.styles[:colors].keys
  end

  def out_animation_options
    Fluxbit::Config::AlertComponent.styles[:animations].keys
  end
end
