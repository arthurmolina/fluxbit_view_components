# frozen_string_literal: true

##
##
# The `Fluxbit::PaginationComponent` is a customizable link component that extends {Fluxbit::Component}.
# It provides a straightforward way to generate anchor elements (`<a>`) with configurable colors
# and styling options. Additional HTML attributes can be passed to further control the component's
# behavior and appearance.
#
# Example usage:
#   = render Fluxbit::PaginationComponent.new(size: 2, spacing: :wider, line_height: :relaxed) do
#     "My Heading"
#
class Fluxbit::PaginationComponent < Fluxbit::Component
  include Fluxbit::Config::PaginationComponent

  ##
  # Initializes the link component with the provided options.
  #
  # @param [Symbol] color (:default) The color style for the heading. Must be one of the keys defined in +styles[:colors]+.
  # @param [Hash] props Additional HTML attributes to be applied to the heading element, such as +class+, +id+, +data-*, etc.
  #
  # @return [Fluxbit::PaginationComponent]
  #
  # @example
  #   = render Fluxbit::PaginationComponent.new(color: :primary) do
  #     "My Heading"
  #
  def initialize(**props)
    super
    @props = props
    @color = @props.delete(:color) || @@color

    add to: @props, class: [ styles[:colors][@color], styles[:base] ]
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
    @href = @props.delete(:href) || "#"
  end

  def call
    link_to content, @href, **@props
  end
end
