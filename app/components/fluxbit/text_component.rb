# frozen_string_literal: true

# The `Fluxbit::TextComponent` is a component for rendering customizable text elements.
# It extends `Fluxbit::Component` and provides options for configuring the text's
# appearance and behavior. You can control the text's tag, styles, and other attributes.
# The text can be rendered as different HTML tags (e.g., span, div) and can have various
# styles applied based on the provided properties.
class Fluxbit::TextComponent < Fluxbit::Component
  include Fluxbit::Config::TextComponent

  # Initializes the text component with the given properties.
  #
  # @param [Hash] props The properties to customize the text.
  # @option props [Symbol] :as (:span) The HTML tag to use for the text element.
  # @option props [Hash] **props Remaining options declared as HTML attributes, applied to the text element.
  def initialize(**props)
    super
    @props = props.compact
    @as = @props.delete(:as) || :span

    styles.each do |style_type, style_values|
      if @props.key?(style_type)
        element = @props.delete(style_type)
        if style_values.is_a?(Array)
          add(class: style_values[element.to_i], to: @props)
        else
          add(class: style_values[element.to_sym], to: @props) if style_values.key?(element.to_sym)
        end
      end
    end
  end

  def call
    content_tag @as, content, @props
  end
end
