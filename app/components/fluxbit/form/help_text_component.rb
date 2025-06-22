# frozen_string_literal: true

# The `Fluxbit::HelpTextComponent` is a component for rendering customizable helper text elements.
# It extends `Fluxbit::Component` and provides options for configuring the helper text's
# appearance and behavior. You can control the helper text's color and other attributes.
# The helper text can have various styles applied based on the provided properties.
#
# @example Basic usage
#   = render Fluxbit::Form::HelpTextComponent.new { "Your password must be at least 8 characters." }
#
# @see docs/03_Forms/HelpText.md For detailed documentation and examples.
class Fluxbit::Form::HelpTextComponent < Fluxbit::Form::Component
  include Fluxbit::Config::Form::HelpTextComponent

  # Initializes the helper text component with the given properties.
  #
  # @param [Symbol] color (:default) The color of the helper text.
  # @param [Hash] props The properties to customize the helper text.
  # @option props [Hash] **props Remaining options declared as HTML attributes, applied to the helper text element.
  def initialize(color: nil, **props)
    super
    @props = props
    color = @@color unless color.in? %i[info default success failure warning]
    add class: style(color), to: @props, first_element: true
  end

  def style(color)
    styles[:base] + styles[:colors][color]
  end

  def call
    content_tag :p, content, @props
  end
end
