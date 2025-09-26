# frozen_string_literal: true

# The `Fluxbit::SpeedDialActionComponent` is a component for rendering individual action items in a Speed Dial.
class Fluxbit::SpeedDialActionComponent < Fluxbit::Component
  include Fluxbit::Config::SpeedDialComponent

  # Initializes the SpeedDialAction component.
  #
  # @param [Hash] **props The properties to customize the speed dial action.
  # @option props [String, Symbol] :icon (nil) The icon to display in the action button.
  # @option props [String] :text (nil) The text label for the action.
  # @option props [String] :tooltip (nil) The tooltip text (defaults to text if not provided).
  # @option props [String] :href (nil) The URL to link to (creates an anchor tag instead of button).
  # @option props [Boolean] :text_outside (false) Whether to display text outside the button.
  # @option props [Boolean] :square (false) Whether to use square shape instead of rounded.
  # @option props [Symbol] :tooltip_placement (:left) Tooltip placement.
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::SpeedDialActionComponent]
  def initialize(**props)
    super(**props.slice(:tooltip_text, :tooltip_placement, :tooltip_trigger))
    @props = props

    @icon = @props.delete(:icon)
    @text = @props.delete(:text)
    @tooltip = @props.delete(:tooltip) || @text
    @href = @props.delete(:href)
    @text_outside = options @props.delete(:text_outside), default: false
    @square = options @props.delete(:square), default: false
    @tooltip_placement = options @props.delete(:tooltip_placement), default: :left
    @props[:id] ||= "speed-dial-action-#{random_id}"

    # Set tooltip via parent component if provided
    @tooltip_text = @tooltip if @tooltip.present?

    add class: [
      styles[:action][:base],
      @square ? styles[:action][:shapes][:square] : styles[:action][:shapes][:rounded]
    ], to: @props
    @props[:type] ||= "button" unless @href

    remove_class_from_props(@props)
  end

  def before_render
    add_popover_or_tooltip
  end

  private

  def icon_classes
    styles[:action][:icon]
  end

  def text_classes
    styles[:action][:text][:outside]
  end
end