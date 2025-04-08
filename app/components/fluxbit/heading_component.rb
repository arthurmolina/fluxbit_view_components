# frozen_string_literal: true

##
# The `Fluxbit::HeadingComponent` is a customizable heading component that extends {Fluxbit::Component}.
# It provides a straightforward way to generate heading elements (`<h1>` through `<h6>`) with
# configurable sizes, letter spacing, and line heights. Additional HTML attributes can be
# passed to further control the component’s behavior and styling.
#
# Example usage:
#   = render Fluxbit::HeadingComponent.new(size: 2, spacing: :wider, line_height: :relaxed) do
#     "My Heading"
#
class Fluxbit::HeadingComponent < Fluxbit::Component
  include Fluxbit::Config::HeadingComponent

  ##
  # Initializes the heading component with the provided options.
  #
  # @param [Integer] size (1) The heading level (1 through 6). Determines whether the component is `<h1>`, `<h2>`, etc.
  # @param [Symbol] spacing (:tight) The letter spacing style for the heading. Must be one of the keys defined in +styles[:spacings]+.
  # @param [Symbol] line_height (:none) The line height style for the heading. Must be one of the keys defined in +styles[:line_heights]+.
  # @param [Hash] props Additional HTML attributes to be applied to the heading element, such as +class+, +id+, +data-*, etc.
  #
  # @return [Fluxbit::HeadingComponent]
  #
  # @example
  #   = render Fluxbit::HeadingComponent.new(size: 2, spacing: :wider, line_height: :relaxed) do
  #     "My Heading"
  #
  def initialize(size: nil, spacing: nil, line_height: nil, **props)
    super
    @props = props
    @base_component = "h#{size || @@size}".to_sym

    add to: @props, class: [
      styles[:base],
      styles[:sizes][@base_component],
      styles[:spacings][spacing || @@spacing],
      styles[:line_heights][line_height || @@line_height]
    ]
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def call
    content_tag @base_component, content, **@props
  end
end
