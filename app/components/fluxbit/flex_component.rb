# frozen_string_literal: true

# The `Fluxbit::FlexComponent` is a component for rendering customizable flex containers.
# It extends `Fluxbit::Component` and provides options for configuring the flex container's
# appearance and behavior. You can control the flex direction, alignment, wrapping, gap,
# and other attributes. This component is useful for creating responsive layouts and
# aligning content dynamically.
class Fluxbit::FlexComponent < Fluxbit::Component
  include Fluxbit::Config::FlexComponent

  # Initializes the flex component with various customization options.
  #
  # @param vertical [Boolean] Whether the flex direction is vertical. Defaults to `false`.
  # @param reverse [Boolean] Whether the flex direction is reversed. Defaults to `false`.
  # @param justify_content [Symbol] The justification of content. Options include `:start`, `:end`, `:center`, `:space_around`, `:space_between`, `:space_evenly`, etc. Defaults to `:center`.
  # @param align_items [Symbol] The alignment of items. Options include `:start`, `:end`, `:center`, `:baseline`, `:stretch`. Defaults to `:center`.
  # @param wrap [Boolean] Whether the flex container should wrap. Defaults to `false`.
  # @param wrap_reverse [Boolean] Whether the flex container should wrap in reverse. Defaults to `false`.
  # @param gap [Integer] The gap between flex items. Defaults to `0`.
  # @param props [Hash] Additional HTML attributes for the container.
  def initialize(**props)
    @props = props

    declare_classes(@props)
    %i[vertical reverse justify_content align_items wrap wrap_reverse gap].each do |key|
      @props.delete(key)
    end

    styles[:resolutions].each do |resolution|
      if @props.key?(resolution)
        declare_classes(@props.delete(resolution), resolution)
      end
    end
  end

  def call
    tag.div(content, **@props)
  end

  private

  def declare_resolution(resolution)
    return "" if resolution.nil?
    "#{resolution}:"
  end

  def declare_classes(props = {}, resolution = nil)
    if props.key?(:vertical)
      vertical = props[:vertical]
      reverse = props[:reverse] || false
      add class: "#{declare_resolution(resolution)}#{direction(vertical, reverse)}", to: @props, first_element: true
    end

    if props.key?(:wrap)
      wrap = props[:wrap]
      wrap_reverse = props[:wrap_reverse] || false
      add class: "#{declare_resolution(resolution)}#{wrap(wrap, wrap_reverse)}", to: @props, first_element: true
    end

    if props.key?(:justify_content)
      justify_content = props[:justify_content]
      add class: "#{declare_resolution(resolution)}#{styles[:justify_content][justify_content.to_sym]}", to: @props, first_element: true
    end

    if props.key?(:align_items)
      align_items = props[:align_items]
      add class: "#{declare_resolution(resolution)}#{styles[:align_items][align_items.to_sym]}", to: @props, first_element: true
    end

    if props.key?(:gap)
      gap = props[:gap]
      add class: "#{declare_resolution(resolution)}#{styles[:gap][gap.to_i]}", to: @props, first_element: true
    end

    add(class: styles[:base], to: @props, first_element: true) if resolution.nil?
  end

  def wrap(wrap, reverse)
    if wrap
      reverse ? styles[:wrap][:wrap_reverse] : styles[:wrap][:wrap]
    else
      styles[:wrap][:nowrap]
    end
  end

  def direction(vertical, reverse)
    if vertical
      reverse ? styles[:direction][:vertical_reverse] : styles[:direction][:vertical]
    else
      reverse ? styles[:direction][:horizontal_reverse] : styles[:direction][:horizontal]
    end
  end
end
