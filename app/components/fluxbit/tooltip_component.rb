# frozen_string_literal: true

# The `Fluxbit::TooltipComponent` is a component for rendering customizable tooltips.
# It extends `Fluxbit::Component` and provides options for configuring the tooltip's
# appearance and behavior. You can control the arrow visibility, and other attributes.
# The tooltip can display additional information when the user hovers over or focuses
# on an element.
class Fluxbit::TooltipComponent < Fluxbit::Component
  include Fluxbit::Config::TooltipComponent

  # Initializes the tooltip component with the given properties.
  #
  # @param [Hash] props The properties to customize the tooltip.
  # @option props [Boolean] :has_arrow (true) Determines if an arrow should be displayed on the tooltip.
  # @option props [Hash] **props Remaining options declared as HTML attributes, applied to the tooltip container.
  def initialize(**props)
    super
    @props = props
    @has_arrow = options @props.delete(:has_arrow), default: true
    @props["role"] = "tooltip"

    add(class: styles[:base], to: @props)
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def call
    tag.div(**@props) do
      concat content
      concat arrow
    end
  end

  def arrow
    return "" unless @has_arrow

    tag.div("", "data-popper-arrow" => true, class: "tooltip-arrow")
  end
end
