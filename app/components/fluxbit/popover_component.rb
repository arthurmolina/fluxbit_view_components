# frozen_string_literal: true

# The `Fluxbit::PopoverComponent` is a component for rendering customizable popovers.
# It extends `Fluxbit::Component` and provides options for configuring the popover's
# appearance, behavior, and content areas. You can control the popover's trigger,
# placement, and other interactive elements. The popover is divided into different
# sections (trigger and content), each of which can be styled or customized through
# various properties.
class Fluxbit::PopoverComponent < Fluxbit::Component
  include Fluxbit::Config::PopoverComponent

  # Initializes the popover component with the given properties.
  #
  # @param [Hash] props The properties to customize the popover.
  # @option props [String] :title (nil) The title text displayed in the popover.
  # @option props [Boolean] :has_arrow (true) Determines if an arrow should be displayed on the popover.
  # @option props [String] :image (nil) The URL of an image to be displayed in the popover.
  # @option props [Symbol] :image_position (:right) The position of the image relative to the content (:left or :right).
  # @option props [Hash] :image_html ({}) Additional HTML attributes for the image element.
  # @option props [Symbol, String] :size (2) The size of the popover (0 to 4).
  # @option props [String] :remove_class ('') Classes to be removed from the default popover class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes, applied to the popover container.
  def initialize(**props)
    super
    @props = props
    @title = @props.delete(:title)
    @has_arrow = options @props.delete(:has_arrow), default: @@has_arrow
    @image = @props.delete(:image)
    @image_position = options @props.delete(:image_position), default: @@image_position
    @image_html = options @props.delete(:image_html), default: @@image_html
    @props["data-popover"] = "data-popover"
    @props["role"] = "tooltip"

    add(class: [ styles[:base], styles[:size][@props.delete(:size) || @@size] ], to: @props)
    add(class: styles[:image_content][:image], to: @image_html)
    @image_html[:src] = @image

    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
    @image_html[:class] = remove_class(@props.delete(:remove_class) || "", @image_html[:class])
  end

  def call
    tag.div(**@props) do
      concat div_title unless @title.blank?
      concat (tag.div(class: styles[@image.blank? ? :content : :image_base]) do
        if @image.blank?
          content
        else
          if @image_position == :left
            concat tag.img(**@image_html)
            concat tag.div(content, class: styles[:image_content][:text])
          else
            concat tag.div(content, class: styles[:image_content][:text])
            concat tag.img(**@image_html)
          end
        end
      end)
      concat popper_arrow if @has_arrow
    end
  end

  def popper_arrow
    tag.div("data-popper-arrow" => true)
  end

  def div_title
    tag.div(class: styles[:title][:div]) do
      tag.h3(@title, class: styles[:title][:h3])
    end
  end
end
