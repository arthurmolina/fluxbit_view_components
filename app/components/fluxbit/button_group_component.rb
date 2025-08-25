# frozen_string_literal: true

# The `Fluxbit::ButtonGroupComponent` is a component for rendering a group of buttons.
# It extends `Fluxbit::Component` and provides options for configuring the appearance
# and behavior of the button group. You can control the buttons displayed
# within the group. The component supports rendering multiple buttons,
# each of which can be styled or customized through various properties.
class Fluxbit::ButtonGroupComponent < Fluxbit::Component
  attr_accessor :buttons_group
  include Fluxbit::Config::ButtonComponent
  # renders_many :buttons, Fluxbit::ButtonComponent

  renders_many :buttons, lambda { |**props, &block|
    @buttons_group << ComponentObj.new(props, view_context.capture(&block))
  }

  # Initializes the button group component with the given properties.
  #
  # @param [Hash] props The properties to customize the button group.
  # @option props [Hash] **props Remaining options declared as HTML attributes, applied to the button group container.
  def initialize(**props)
    super
    @props = props
    @buttons_group = []
    add class: styles[:group], to: @props
  end

  def call
    buttons
    tag.div(**@props) do
      @buttons_group.each_with_index do |button, index|
        button_props = button.props || {}
        button_content = button.content

        button_props[:grouped] = true
        button_props[:first_button] = true if index == 0
        button_props[:last_button] = true if index == @buttons_group.size - 1

        concat Fluxbit::ButtonComponent.new(**button_props).with_content(button_content).render_in(view_context)
      end
    end
  end
end
