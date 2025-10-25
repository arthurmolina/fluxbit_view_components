# frozen_string_literal: true

##
# The `Fluxbit::Form::RadioGroupButtonComponent` is a component for rendering radio buttons
# styled as a button group. It provides the visual appearance of grouped buttons while
# maintaining radio button behavior (only one option can be selected at a time).
#
# This component is useful for creating segmented controls, view toggles, or any interface
# where users need to select one option from a group with a button-like appearance.
class Fluxbit::Form::RadioGroupButtonComponent < Fluxbit::Form::FieldComponent
  include Fluxbit::Config::Form::RadioGroupButtonComponent

  renders_many :radio_options, lambda { |**props, &block|
    @options_group << ComponentObj.new(props, view_context.capture(&block))
  }

  ##
  # Initializes the radio group button component with the given properties.
  #
  # @param [Hash] props The properties to customize the radio group button.
  # @option props [String] :name (nil) The name attribute for the radio button group (required for proper radio functionality).
  # @option props [Symbol, String] :color (:default) The color style of the buttons.
  # @option props [Symbol, String] :size (1) The size of the buttons (e.g., `0` to `4`).
  # @option props [Boolean] :pill (false) Determines if the buttons have pill-shaped edges.
  # @option props [Hash] **props Remaining options declared as HTML attributes, applied to the group container.
  #
  # @return [Fluxbit::Form::RadioGroupButtonComponent]
  def initialize(**props)
    super
    @props = props
    @name = @props.delete(:name) || "radio_group_#{fx_id}"
    @color = options (@props.delete(:color) || "").to_sym, collection: button_styles[:colors].keys, default: @@color
    @size = @props.delete(:size) || @@size
    @pill = options @props.delete(:pill), default: false
    @outline = @color.to_s.end_with?("_outline")
    @options_group = []

    add class: Fluxbit::Config::Form::RadioGroupButtonComponent.styles[:group], to: @props, first_element: true
  end

  def call
    radio_options
    tag.div(**@props) do
      @options_group.each_with_index do |option, index|
        concat render_radio_button(option, index)
      end
    end
  end

  private

  def render_radio_button(option, index)
    option_props = option.props || {}
    option_content = option.content
    option_value = option_props.delete(:value) || index
    option_checked = option_props.delete(:checked) || false
    option_disabled = option_props.delete(:disabled) || false

    radio_id = "#{@name}_#{option_value}_#{fx_id}"

    # Input element
    input_html = {
      type: "radio",
      id: radio_id,
      name: @name,
      value: option_value,
      class: "#{Fluxbit::Config::Form::RadioGroupButtonComponent.styles[:input]} peer"
    }
    input_html[:checked] = true if option_checked
    input_html[:disabled] = true if option_disabled

    # Label element (styled as button)
    label_html = option_props.dup
    label_html[:for] = radio_id

    add class: Fluxbit::Config::Form::RadioGroupButtonComponent.styles[:label][:base], to: label_html, first_element: true
    add class: button_color_classes, to: label_html, first_element: true
    add class: button_size_classes, to: label_html, first_element: true
    add class: button_pill_classes, to: label_html, first_element: true
    add class: button_outline_classes, to: label_html, first_element: true

    # Position classes
    add class: Fluxbit::Config::Form::RadioGroupButtonComponent.styles[:label][:position][:start], to: label_html if index == 0
    add class: Fluxbit::Config::Form::RadioGroupButtonComponent.styles[:label][:position][:end], to: label_html if index == @options_group.size - 1
    add class: Fluxbit::Config::Form::RadioGroupButtonComponent.styles[:label][:position][:middle], to: label_html if index > 0 && index < @options_group.size - 1

    # Selected state - use peer-checked for CSS-only interaction
    # The peer modifier allows the label to change when the radio input is checked
    add class: "peer-checked:brightness-90 dark:peer-checked:brightness-75", to: label_html

    # Disabled state
    if option_disabled
      add class: Fluxbit::Config::ButtonComponent.styles[:disabled], to: label_html, first_element: true
    end

    tag.div(class: "relative") do
      concat tag.input(**input_html)
      concat tag.label(option_content, **label_html)
    end
  end

  def button_styles
    Fluxbit::Config::ButtonComponent.styles
  end

  def button_color_classes
    @color.in?(button_styles[:colors].keys) ? button_styles[:colors][@color] : button_styles[:colors][:default]
  end

  def button_size_classes
    button_styles[:size][@size.to_i]
  end

  def button_pill_classes
    return "" if @outline
    button_styles[:pill][@pill ? :on : :off]
  end

  def button_outline_classes
    if @outline
      "#{button_styles[:outline][:on]} #{button_styles[:outline][:pill][@pill ? :on : :off]}"
    else
      button_styles[:outline][:off]
    end
  end
end
