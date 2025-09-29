# frozen_string_literal: true

# The `Fluxbit::SpinnerPercentComponent` is a component for rendering progress spinners with percentage display.
class Fluxbit::SpinnerPercentComponent < Fluxbit::Component
  include Fluxbit::Config::SpinnerPercentComponent

  # Initializes the SpinnerPercent component with various customization options.
  #
  # @param [Hash] **props The properties to customize the spinner.
  # @option props [Symbol] :color (:default) The color theme of the spinner (:default, :info, :success, :failure, :warning, :pink, :purple).
  # @option props [Integer] :size (1) The size of the spinner (-1 to 4).
  # @option props [Integer] :percent (0) The percentage completion (0 to 100).
  # @option props [String] :label ('Loading...') The aria-label for accessibility.
  # @option props [Boolean] :show_percent (true) Whether to display the percentage text.
  # @option props [String] :text (nil) Custom text to display instead of percentage. If provided, overrides show_percent.
  # @option props [Hash] :label_html ({}) HTML attributes for the inner text element. Supports remove_class key to remove default classes.
  # @option props [Boolean] :animate (false) Whether to apply rotation animation to the circle.
  # @option props [Symbol] :speed (:normal) The speed of rotation animation (:slow, :normal, :fast, :very_fast).
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::SpinnerPercentComponent]
  def initialize(**props)
    super
    @props = props

    @color = options @props.delete(:color), collection: [ :default, :info, :success, :failure, :warning, :pink, :purple ], default: @@color
    @size = options @props.delete(:size), collection: (-1..4).to_a, default: @@size
    @percent = [ @props.delete(:percent) || @@percent, 0 ].max
    @percent = [ @percent, 100 ].min
    @label = @props.delete(:label) || @@label
    @show_percent = @props.delete(:show_percent)
    @show_percent = @@show_percent if @show_percent.nil?
    @text = @props.delete(:text) || @@text
    @label_html = @props.delete(:label_html) || {}
    @animate = @props.delete(:animate)
    @animate = @@animate if @animate.nil?
    @speed = options @props.delete(:speed), collection: [ :slow, :normal, :fast, :very_fast ], default: @@speed

    add class: [
      styles[:base],
      styles[:sizes][@size]
    ], to: @props

    # Add accessibility attributes
    @props[:role] = "progressbar"
    @props[:"aria-label"] = @label
    @props[:"aria-valuenow"] = @percent
    @props[:"aria-valuemin"] = "0"
    @props[:"aria-valuemax"] = "100"

    # Add Stimulus controller
    @props[:data] ||= {}
    @props[:data][:controller] = "fx-spinner-percent"
    @props[:data][:"fx-spinner-percent-percent-value"] = @percent
    @props[:data][:"fx-spinner-percent-animate-value"] = @animate
    @props[:data][:"fx-spinner-percent-speed-value"] = @speed
    @props[:data][:"fx-spinner-percent-has-custom-text-value"] = !@text.nil?

    remove_class_from_props(@props)
  end

  private

  def container_classes
    [
      styles[:base],
      styles[:sizes][@size]
    ].compact.join(" ")
  end

  def background_circle_classes
    styles[:colors][@color].split.first # gets "text-gray-200" part
  end

  def progress_circle_classes
    styles[:colors][@color].split.last # gets "stroke-blue-600" part
  end

  def svg_classes
    classes = [ styles[:sizes][@size] ]
    classes << styles[:speeds][@speed] if @animate
    classes.compact.join(" ")
  end

  def percentage_text_classes
    [
      "absolute inset-0 flex items-center justify-center text-sm font-semibold",
      styles[:text_colors][@color]
    ].compact.join(" ")
  end

  def circumference
    # For a circle with radius 45 (viewBox is 100x100, radius should be ~45 to fit nicely)
    2 * Math::PI * 45
  end

  def stroke_dasharray
    circumference
  end

  def stroke_dashoffset
    circumference - (@percent / 100.0) * circumference
  end

  def screen_reader_classes
    styles[:screen_reader]
  end

  def label_text_classes
    # Start with default classes
    default_classes = percentage_text_classes.split(" ")

    # Remove classes specified in label_html[:remove_class]
    remove_class = @label_html[:remove_class] || @label_html["remove_class"]
    if remove_class && !remove_class.empty?
      remove_classes = remove_class.split(" ")
      default_classes = default_classes - remove_classes
    end

    # Add custom classes from label_html[:class]
    custom_classes = @label_html[:class]&.split(" ") || []

    # Combine and join
    (default_classes + custom_classes).uniq.join(" ")
  end
end
