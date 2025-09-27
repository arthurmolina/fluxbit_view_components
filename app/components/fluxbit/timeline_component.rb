# frozen_string_literal: true

# The `Fluxbit::TimelineComponent` is a component for rendering customizable timelines.
class Fluxbit::TimelineComponent < Fluxbit::Component
  include Fluxbit::Config::TimelineComponent

  # Slot for timeline items
  renders_many :items, lambda { |**props|
    Fluxbit::TimelineItemComponent.new(
      variant: @variant,
      **props
    )
  }

  private

  def items_with_position
    items.map.with_index do |item, index|
      item.instance_variable_set(:@is_last, index == items.length - 1)
      item
    end
  end

  # Initializes the Timeline component with various customization options.
  #
  # @param [Hash] **props The properties to customize the timeline.
  # @option props [Symbol] :variant (:default) The timeline variant (:default, :vertical, :stepper, :activity).
  # @option props [Symbol] :position (:left) The position of timeline indicators (:left, :center, :right).
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::TimelineComponent]
  def initialize(**props)
    super
    @props = props

    @variant = options @props.delete(:variant), collection: [:default, :vertical, :stepper, :activity], default: @@variant
    @position = options @props.delete(:position), collection: [:left, :center, :right], default: @@position

    add class: [
      styles[:base],
      styles[:variants][@variant],
      styles[:positions][@position]
    ], to: @props

    remove_class_from_props(@props)
  end

  private

  def timeline_classes
    [
      styles[:base],
      styles[:variants][@variant],
      styles[:positions][@position]
    ].compact.join(" ")
  end

  def list_tag
    @variant == :stepper ? "ol" : "ul"
  end
end