# frozen_string_literal: true

##
# The `Fluxbit::StepperComponent` is a customizable stepper component that extends `Fluxbit::Component`.
# It provides a visual representation of a multi-step process, supporting both horizontal and vertical orientations
# with various styling options including different colors and states.
#
# @example Basic usage
#   = fx_stepper do |stepper|
#     = stepper.with_step(title: "Step 1", state: :completed)
#     = stepper.with_step(title: "Step 2", state: :active)
#     = stepper.with_step(title: "Step 3")
#   end
#
# @see docs/02_Components/Stepper.md For detailed documentation.
class Fluxbit::StepperComponent < Fluxbit::Component
  include Fluxbit::Config::StepperComponent

  renders_many :steps, lambda { |**attrs, &block|
    step = Step.new(**attrs)
    step.with_content(block.call) if block_given?
    step
  }

  ##
  # Initializes the stepper component with the given properties.
  #
  # @param [Hash] **props The properties to customize the stepper.
  # @option props [Symbol] :orientation (:horizontal) The orientation of the stepper (:horizontal, :vertical).
  # @option props [Symbol] :variant (:default) The variant of the stepper (:default, :progress, :detailed).
  # @option props [Symbol] :color (:blue) The color theme of the active step (:blue, :green, :red, :yellow, :indigo, :purple).
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::StepperComponent]
  def initialize(**props)
    super
    @props = props

    @orientation = options(@props.delete(:orientation), collection: [:horizontal, :vertical], default: @@orientation)
    @variant = options(@props.delete(:variant), collection: [:default, :progress, :detailed], default: @@variant)
    @color = options(@props.delete(:color), collection: [:blue, :green, :red, :yellow, :indigo, :purple], default: @@color)

    declare_classes
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def call
    tag.div(**@props) do
      tag.ol(class: styles[:list][@variant][@orientation]) do
        safe_join(steps.map.with_index { |step, index| render_step(step, index) })
      end
    end
  end

  private

  def declare_classes
    add(class: styles[:base][@orientation], to: @props, first_element: true)
  end

  def render_step(step, index)
    last_step = index == steps.count - 1

    content_tag(:li, class: step_item_classes) do
      if @orientation == :vertical && @variant != :detailed
        # Vertical layout: wrapper div for proper positioning
        concat(
          tag.div(class: "relative") do
            content = []
            content << tag.div(class: "flex items-center") do
              concat(render_step_indicator(step))
              concat(render_step_content(step)) if step.title.present? || step.description.present? || step.content.present?
            end
            content << render_vertical_connector(step) unless last_step
            safe_join(content)
          end
        )
      elsif @orientation == :vertical && @variant == :detailed
        # Detailed vertical: no connectors, just cards
        concat(render_step_indicator(step))
        concat(render_step_content(step)) if step.title.present? || step.description.present? || step.content.present?
      else
        # Horizontal layout: standard flow with connectors
        concat(render_step_indicator(step))
        concat(render_step_content(step)) if step.title.present? || step.description.present? || step.content.present?
        concat(render_connector(step)) unless last_step
      end
    end
  end

  def step_item_classes
    styles[:item][@variant][@orientation]
  end

  def render_step_indicator(step)
    tag.div(class: step_circle_classes(step)) do
      if step.state == :completed && @variant != :progress
        anyicon("heroicons_solid:check", class: styles[:step_icon][@variant][:completed])
      elsif step.state == :completed && @variant == :progress
        content_tag(:span, "✓", class: step_number_classes(step))
      else
        content_tag(:span, step.number || "", class: step_number_classes(step))
      end
    end
  end

  def render_step_content(step)
    return "" unless step.title.present? || step.description.present? || step.content.present?

    tag.div(class: styles[:content][@variant][@orientation]) do
      content = []

      content << tag.h3(step.title, class: step_title_classes(step)) if step.title.present?
      content << tag.p(step.description, class: styles[:description]) if step.description.present?
      content << step.content if step.content.present?

      safe_join(content)
    end
  end

  def render_connector(step)
    return "" if @orientation == :horizontal && steps.count <= 1

    connector_classes = if step.state == :completed
                          styles[:connector][:completed][@variant][@orientation]
                        elsif step.state == :active
                          styles[:connector][:active][@color][@variant][@orientation]
                        else
                          styles[:connector][@variant][@orientation]
                        end

    tag.div(class: connector_classes)
  end

  def render_vertical_connector(step)
    # Position based on variant (different circle sizes)
    left_position = case @variant
                    when :progress then "left-4"  # w-8 circles
                    when :detailed then "left-6"  # w-12 circles
                    else "left-5"                  # w-10 circles (default)
                    end

    connector_classes = if step.state == :completed
                          "absolute #{left_position} top-full w-0.5 h-6 bg-green-200 dark:bg-green-700"
                        elsif step.state == :active
                          color_bg = case @color
                                     when :blue then "bg-blue-200 dark:bg-blue-700"
                                     when :green then "bg-green-200 dark:bg-green-700"
                                     when :red then "bg-red-200 dark:bg-red-700"
                                     when :yellow then "bg-yellow-200 dark:bg-yellow-700"
                                     when :indigo then "bg-indigo-200 dark:bg-indigo-700"
                                     when :purple then "bg-purple-200 dark:bg-purple-700"
                                     else "bg-blue-200 dark:bg-blue-700"
                                     end
                          "absolute #{left_position} top-full w-0.5 h-6 #{color_bg}"
                        else
                          "absolute #{left_position} top-full w-0.5 h-6 bg-gray-200 dark:bg-gray-700"
                        end

    tag.div(class: connector_classes)
  end

  def step_circle_classes(step)
    case step.state
    when :completed
      styles[:step][@variant][:completed]
    when :active
      styles[:step][@variant][:active][@color]
    else
      styles[:step][@variant][:base]
    end
  end

  def step_number_classes(step)
    case step.state
    when :completed
      styles[:step_number][@variant][:completed]
    when :active
      styles[:step_number][@variant][:active][@color]
    else
      styles[:step_number][@variant][:base]
    end
  end

  def step_title_classes(step)
    case step.state
    when :completed
      styles[:title][:completed]
    when :active
      styles[:title][:active][@color]
    else
      styles[:title][:base]
    end
  end

  # Nested step component
  class Step < Fluxbit::Component
    include Fluxbit::Config::StepperComponent

    attr_reader :title, :description, :state, :number

    ##
    # Initializes a step item for the stepper.
    #
    # @param [Hash] **props The properties to customize the step.
    # @option props [String] :title The title of the step.
    # @option props [String] :description The description of the step.
    # @option props [Symbol] :state (:pending) The state of the step (:pending, :active, :completed).
    # @option props [String, Integer] :number The step number or custom text.
    #
    # @return [Fluxbit::StepperComponent::Step]
    def initialize(**props)
      super
      @props = props

      @title = @props.delete(:title)
      @description = @props.delete(:description)
      @state = options(@props.delete(:state), collection: [:pending, :active, :completed], default: :pending)
      @number = @props.delete(:number)
    end

    def call
      content
    end
  end
end