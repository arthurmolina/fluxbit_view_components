# frozen_string_literal: true

# The `Fluxbit::Form::LabelComponent` is a flexible and accessible label for form fields.
# It supports custom content, helper popovers, multiple color styles, sizing options, and
# displays associated help text when provided. It is fully compatible with Rails form builders.
#
# @example Basic usage
#   = render Fluxbit::Form::LabelComponent.new(with_content: "Your Name")
#
# @see docs/03_Forms/Label.md For detailed documentation and examples.
class Fluxbit::Form::LabelComponent < Fluxbit::Form::Component
  include Fluxbit::Config::Form::LabelComponent

  # Initializes the label component with the given properties.
  #
  # @param with_content [String] The label text to display (alternative to block content)
  # @param help_text [String, Array<String>] One or more help text messages to render below the label
  # @param helper_popover [String] Popover content shown on icon hover
  # @param helper_popover_placement [String] Placement of the popover (default: "right")
  # @param sizing [Integer] Size index for label text (default: config default)
  # @param color [Symbol] Label color (:default, :success, :danger, :info, :warning)
  # @param class [String] Additional CSS classes for the label element
  # @param ... any other HTML attribute supported by the <label> tag
  def initialize(**props)
    super
    @props = props
    @with_content = @props.delete(:with_content)
    @help_text = @props.delete(:help_text)
    @help_text = [ @help_text ] if !@help_text.is_a?(Array)
    @helper_popover = @props.delete(:helper_popover)
    @helper_popover_placement = @props.delete(:helper_popover_placement) || @@helper_popover_placement
    @sizing = @props[:sizing].to_i || @@sizing
    @sizing = (styles[:sizes].count - 1) if @sizing > (styles[:sizes].count - 1)
    @color = options(@props.delete(:color), collection: styles[:colors], default: @@color)
    @required = @props.delete(:required) || false

    add class: styles[:colors][@color], to: @props, first_element: true
    add class: styles[:base], to: @props, first_element: true
    add class: styles[:sizes][@sizing], to: @props, first_element: true
  end

  def span_helper_popover
    return "" if @helper_popover.nil?

    content_tag :span,
                anyicon(@@helper_popover_icon, class: @@helper_popover_icon_class),
                {
                  "data-popover-placement": @helper_popover_placement,
                  "data-popover-target": target,
                  class: styles[:helper_popover]
                }
  end

  def render_popover
    return "" if @helper_popover.nil?

    Fluxbit::PopoverComponent.new(id: target).with_content(@helper_popover).render_in(view_context)
  end

  def call
    safe_join(
      [
        content_tag(:label, safe_join([ content || @with_content, span_helper_popover, required ]), @props),
        help_text,
        render_popover
      ]
    )
  end

  def required
    return "" unless @required

    content_tag(:span, "*", class: styles[:required])
  end
end
