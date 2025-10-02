# frozen_string_literal: true

##
# The `Fluxbit::CarouselComponent` is a customizable carousel component that extends `Fluxbit::Component`.
# It allows you to create image carousels or content sliders with various features like automatic sliding,
# indicators, navigation controls, and customizable animations.
#
# @example Basic usage
#   = fx_carousel do |c|
#     c.with_slide { image_tag("slide1.jpg") }
#     c.with_slide { image_tag("slide2.jpg") }
#     c.with_slide { image_tag("slide3.jpg") }
#   end
#
# @see docs/02_Components/Carousel.md For detailed documentation.
class Fluxbit::CarouselComponent < Fluxbit::Component
  include Fluxbit::Config::CarouselComponent

  renders_many :slides, lambda { |**props, &block|
    begin
      @slides_group << ComponentObj.new(props, view_context.capture(&block))
    rescue
      @slides_group << ComponentObj.new(props, nil)
    end
  }

  ##
  # Initializes the carousel component with the given properties.
  #
  # @param [Hash] **props The properties to customize the component.
  # @option props [Boolean] :slide (true) Enables automatic sliding between items.
  # @option props [Integer] :slide_interval (3000) Interval in milliseconds between automatic slides.
  # @option props [Boolean] :indicators (true) Shows slide indicator dots at the bottom.
  # @option props [Boolean] :controls (true) Shows previous/next navigation controls.
  # @option props [String] :left_control (nil) Custom content/text for left control button.
  # @option props [String] :right_control (nil) Custom content/text for right control button.
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::CarouselComponent]
  def initialize(**props)
    super
    @props = props
    @slides_group = []

    @slide = options(@props.delete(:slide), default: @@slide)
    @slide_interval = options(@props.delete(:slide_interval), default: @@slide_interval)
    @indicators = options(@props.delete(:indicators), default: @@indicators)
    @controls = options(@props.delete(:controls), default: @@controls)
    @left_control = @props.delete(:left_control)
    @right_control = @props.delete(:right_control)

    declare_classes

    # Handle class removal
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])

    # Flowbite carousel data attributes
    @props[:data] ||= {}
    @props[:data][:carousel] = @slide ? "slide" : "static"
  end

  def call
    slides # Ensure slides are rendered

    tag.div(**@props) do
      concat(render_slides_container)
      concat(render_indicators) if @indicators
      concat(render_controls) if @controls
    end
  end

  private

  def declare_classes
    add(class: styles[:base], to: @props, first_element: true)
  end

  def render_slides_container
    tag.div(class: styles[:slides_container]) do
      safe_join(@slides_group.map.with_index { |slide, index| render_slide(slide, index) })
    end
  end

  def render_slide(slide, index)
    slide_props = slide.props.dup
    add(class: styles[:slide][:base], to: slide_props, first_element: true)
    add(class: styles[:slide][:inactive], to: slide_props) unless index.zero?

    slide_props[:data] ||= {}
    slide_props[:data][:carousel_item] = index.zero? ? "active" : true

    tag.div(**slide_props) do
      slide.content
    end
  end

  def render_indicators
    tag.div(class: styles[:indicators][:container]) do
      safe_join(@slides_group.count.times.map { |index| render_indicator(index) })
    end
  end

  def render_indicator(index)
    button_props = {
      type: "button",
      class: styles[:indicators][:button],
      "aria-current": index.zero?.to_s,
      "aria-label": "Slide #{index + 1}",
      data: {
        carousel_slide_to: index
      }
    }

    tag.button(**button_props)
  end

  def render_controls
    safe_join([
      render_control_button(:previous),
      render_control_button(:next)
    ])
  end

  def render_control_button(direction)
    is_previous = direction == :previous
    custom_content = is_previous ? @left_control : @right_control

    button_props = {
      type: "button",
      class: [styles[:controls][:button], is_previous ? styles[:controls][:previous] : styles[:controls][:next]].join(" "),
      data: {}
    }

    # Add Flowbite carousel control data attribute
    if is_previous
      button_props[:data][:carousel_prev] = ""
    else
      button_props[:data][:carousel_next] = ""
    end

    tag.button(**button_props) do
      if custom_content
        custom_content
      else
        concat(tag.span(class: styles[:controls][:icon_wrapper]) do
          is_previous ? chevron_left(class: styles[:controls][:icon]) : chevron_right(class: styles[:controls][:icon])
        end)
        concat(tag.span("#{direction.to_s.capitalize} slide", class: styles[:controls][:sr_only]))
      end
    end
  end

end
