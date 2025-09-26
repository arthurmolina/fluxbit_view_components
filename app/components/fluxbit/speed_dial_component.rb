# frozen_string_literal: true

# The `Fluxbit::SpeedDialComponent` is a component for rendering customizable Speed Dial floating action buttons.
class Fluxbit::SpeedDialComponent < Fluxbit::Component
  include Fluxbit::Config::SpeedDialComponent

  # Slot for speed dial action items
  renders_many :actions, lambda { |**props|
    Fluxbit::SpeedDialActionComponent.new(
      text_outside: @text_outside,
      square: @square,
      **props
    )
  }

  # Initializes the SpeedDial component with various customization options.
  #
  # @param [Hash] **props The properties to customize the speed dial.
  # @option props [Symbol] :position (:bottom_right) The position of the speed dial (:top_left, :top_right, :bottom_left, :bottom_right).
  # @option props [Boolean] :square (false) Whether to use square shape instead of rounded.
  # @option props [Boolean] :text_outside (false) Whether to display text outside action buttons.
  # @option props [String, Symbol] :trigger_icon ("heroicons_solid:plus") The icon for the trigger button.
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::SpeedDialComponent]
  def initialize(**props)
    super
    @props = props

    @position = options @props.delete(:position), collection: [:top_left, :top_right, :bottom_left, :bottom_right], default: @@position
    @square = options @props.delete(:square), default: @@square
    @text_outside = options @props.delete(:text_outside), default: @@text_outside
    @trigger_icon = @props.delete(:trigger_icon) || "heroicons_solid:plus"
    @props[:id] ||= "speed-dial-#{random_id}"

    add class: [
      styles[:base],
      styles[:positions][@position]
    ], to: @props

    remove_class_from_props(@props)
  end

  private

  def classes(class_array)
    class_array.compact.join(" ")
  end

  def menu_id
    "#{@props[:id]}-menu"
  end

  def trigger_classes
    [
      styles[:trigger][:base],
      @square ? styles[:trigger][:shapes][:square] : styles[:trigger][:shapes][:rounded]
    ]
  end

  def top_position?
    @position.in?([:top_left, :top_right])
  end

  def menu_classes
    [
      styles[:menu][:base],
      styles[:menu][:hidden],
      top_position? ? "mt-4" : "mb-4"
    ]
  end
end