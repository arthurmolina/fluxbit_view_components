# frozen_string_literal: true

##
# The `Fluxbit::ProgressComponent` is a customizable progress bar component that extends `Fluxbit::Component`.
# It allows you to create progress indicators with various styles, sizes, colors, and label positioning options
# to display completion status or loading progress.
#
# @example Basic usage
#   = fx_progress(progress: 45)
#
# @example With labels
#   = fx_progress(progress: 75, text_label: "Loading", label_progress: true)
#
# @see docs/02_Components/Progress.md For detailed documentation.
class Fluxbit::ProgressComponent < Fluxbit::Component
  include Fluxbit::Config::ProgressComponent

  ##
  # Initializes the progress component with the given properties.
  #
  # @param [Hash] **props The properties to customize the component.
  # @option props [Integer] :progress (0) The progress percentage (0-100).
  # @option props [Symbol, String] :color (:default) The color theme of the progress bar.
  # @option props [Integer] :size (1) The size of the progress bar (0-3).
  # @option props [String] :text_label (nil) Label text to display with the progress bar.
  # @option props [Boolean] :label_progress (false) Whether to show the progress percentage.
  # @option props [Boolean] :label_text (false) Whether to show the text label.
  # @option props [Symbol] :progress_label_position (:inside) Position of progress label (:inside or :outside).
  # @option props [Symbol] :text_label_position (:outside) Position of text label (:inside or :outside).
  # @option props [Hash] :label_html ({}) HTML attributes for label elements. Supports :remove_class.
  # @option props [Boolean] :stimulus (false) Whether to add Stimulus controller data attributes for JavaScript interactions.
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options as HTML attributes.
  #
  # @return [Fluxbit::ProgressComponent]
  def initialize(**props)
    super
    @props = props

    # Use options() function with config defaults
    @progress = options(@props.delete(:progress), default: @@progress)
    @color = options(@props.delete(:color), collection: styles[:bar][:colors].keys, default: @@color)
    @size = options(@props.delete(:size), default: @@size)
    @text_label = options(@props.delete(:text_label), default: @@text_label)
    @label_progress = options(@props.delete(:label_progress), default: @@label_progress)
    @label_text = options(@props.delete(:label_text), default: @@label_text)
    @progress_label_position = options(@props.delete(:progress_label_position),
                                      collection: [ :inside, :outside ],
                                      default: @@progress_label_position)
    @text_label_position = options(@props.delete(:text_label_position),
                                  collection: [ :inside, :outside ],
                                  default: @@text_label_position)
    @label_html = options(@props.delete(:label_html), default: @@label_html)
    @stimulus = options(@props.delete(:stimulus), default: @@stimulus)

    # Sanitize progress value
    @progress = [ @progress.to_i, 0 ].max
    @progress = [ @progress, 100 ].min

    # Apply styling
    declare_classes

    # Handle class removal
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def call
    content_tag(:div) do
      safe_join([
        render_outside_labels,
        render_progress_container
      ].compact)
    end
  end

  private

  def declare_classes
    add(class: styles[:base], to: @props, first_element: true)
    add(class: styles[:sizes][@size], to: @props, first_element: true)

    # Add Stimulus controller attributes if enabled
    if @stimulus
      @props["data-controller"] = [ @props["data-controller"], "fx-progress" ].compact.join(" ")
      @props["data-fx-progress-progress-value"] = @progress
      @props["data-fx-progress-animate-value"] = true
    end
  end

  def render_outside_labels
    return unless has_outside_labels?

    content_tag(:div, class: styles[:labels][:outside][:base]) do
      safe_join([
        render_outside_text_label,
        render_outside_progress_label
      ].compact)
    end
  end

  def render_outside_text_label
    return unless @label_text && @text_label.present? && @text_label_position == :outside

    label_props = build_label_props(styles[:labels][:outside][:text], is_progress_label: false)
    content_tag(:span, @text_label, **label_props)
  end

  def render_outside_progress_label
    return unless @label_progress && @progress_label_position == :outside

    label_props = build_label_props(styles[:labels][:outside][:progress], is_progress_label: true)
    content_tag(:span, "#{@progress}%", **label_props)
  end

  def render_progress_container
    content_tag(:div, **@props) do
      content_tag(:div, progress_bar_content, **progress_bar_props)
    end
  end

  def progress_bar_props
    bar_props = {
      class: progress_bar_classes,
      style: "width: #{@progress}%"
    }

    # Add Stimulus target if enabled
    if @stimulus
      bar_props["data-fx-progress-target"] = "bar"
    end

    bar_props
  end

  def progress_bar_classes
    classes = [ styles[:bar][:base] ]
    classes << styles[:bar][:colors][@color]
    classes << styles[:bar][:text_sizes][@size] if has_inside_labels?
    classes.join(" ")
  end

  def progress_bar_content
    return "" unless has_inside_labels?

    safe_join([
      render_inside_text_label,
      render_inside_progress_label
    ].compact, " ")
  end

  def render_inside_text_label
    return unless @label_text && @text_label.present? && @text_label_position == :inside

    label_props = build_label_props(styles[:labels][:inside][:text], is_progress_label: false)
    content_tag(:span, @text_label, **label_props)
  end

  def render_inside_progress_label
    return unless @label_progress && @progress_label_position == :inside

    label_props = build_label_props(styles[:labels][:inside][:progress], is_progress_label: true)
    content_tag(:span, "#{@progress}%", **label_props)
  end

  def has_outside_labels?
    (@label_text && @text_label.present? && @text_label_position == :outside) ||
    (@label_progress && @progress_label_position == :outside)
  end

  def has_inside_labels?
    (@label_text && @text_label.present? && @text_label_position == :inside) ||
    (@label_progress && @progress_label_position == :inside)
  end

  def build_label_props(base_class, is_progress_label: false)
    label_props = @label_html.dup

    # Start with base class and merge with any custom classes
    label_props[:class] = base_class
    add(class: @label_html[:class], to: label_props) if @label_html[:class].present?

    # Add Stimulus target if enabled and this is a progress label
    if @stimulus && is_progress_label
      label_props["data-fx-progress-target"] = "progressLabel"
    elsif @stimulus && !is_progress_label
      label_props["data-fx-progress-target"] = "textLabel"
    end

    # Handle remove_class for labels
    if label_props[:remove_class].present?
      label_props[:class] = remove_class(label_props.delete(:remove_class), label_props[:class])
    end

    label_props
  end
end
