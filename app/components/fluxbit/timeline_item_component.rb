# frozen_string_literal: true

# The `Fluxbit::TimelineItemComponent` is a component for rendering individual timeline items.
class Fluxbit::TimelineItemComponent < Fluxbit::Component
  include Fluxbit::Config::TimelineComponent

  # Initializes the TimelineItem component.
  #
  # @param [Hash] **props The properties to customize the timeline item.
  # @option props [Symbol] :variant (nil) The timeline variant from parent component.
  # @option props [String] :title (nil) The title of the timeline item.
  # @option props [String] :description (nil) The description text.
  # @option props [String] :date (nil) The date or time for the item.
  # @option props [String, Symbol] :icon (nil) The icon to display in the timeline indicator.
  # @option props [Symbol] :status (:default) The status of the item (:default, :completed, :current, :pending).
  # @option props [Symbol] :color (:blue) The color theme (:blue, :green, :red, :yellow, :purple, :indigo).
  # @option props [String] :href (nil) URL to make the item clickable.
  # @option props [Symbol] :ring (:default) The ring size around indicator (:none, :small, :default, :large).
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::TimelineItemComponent]
  def initialize(**props)
    super
    @props = props

    @variant = @props.delete(:variant) || :default
    @title = @props.delete(:title)
    @description = @props.delete(:description)
    @date = @props.delete(:date)
    @icon = @props.delete(:icon)
    @status = options @props.delete(:status), collection: [:default, :completed, :current, :pending], default: :default
    @color = options @props.delete(:color), collection: [:blue, :green, :red, :yellow, :purple, :indigo], default: :blue
    @ring = options @props.delete(:ring), collection: [:none, :small, :default, :large], default: :default
    @href = @props.delete(:href)

    if @variant != :stepper
      add class: styles[:item][:base], to: @props
    end

    remove_class_from_props(@props)
  end

  def before_render
    super
    if @variant == :stepper
      # Add stepper classes after @is_last is set
      add class: stepper_item_classes, to: @props
    end
  end

  private

  def indicator_classes
    [
      styles[:item][:indicator][:base],
      styles[:item][:indicator][:status][@status],
      styles[:item][:indicator][:colors][@color],
      styles[:item][:indicator][:rings][@ring]
    ].compact.join(" ")
  end

  def content_classes
    styles[:item][:content][:base]
  end

  def title_classes
    styles[:item][:content][:title]
  end

  def description_classes
    styles[:item][:content][:description]
  end

  def date_classes
    styles[:item][:content][:date]
  end

  def connector_classes
    styles[:item][:connector]
  end

  def render_as_link?
    @href.present?
  end

  def is_last?
    @is_last || false
  end

  def stepper_item_classes
    styles[:stepper][:item]
  end

  def stepper_indicator_classes
    if @status == :completed || @status == :current
      styles[:stepper][:indicator_completed]
    else
      styles[:stepper][:indicator]
    end
  end
end