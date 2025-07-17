# frozen_string_literal: true

##
# The `Fluxbit::DrawerComponent` is a customizable alert component that extends `Fluxbit::Component`.
# It provides various options to display alert messages with different styles, icons, and behaviors
# such as close functionality and animations.
#
# Example usage:
#   = render Fluxbit::DrawerComponent.new(
#     placement: :left,
#     sizing: :md,
#     show_close_button: true,
#     swipeable: false,
#     shadow: true
#   ) do |drawer|
#     drawer.with_header do |header|
#       "Header Content"
#     end
#   end
#
class Fluxbit::DrawerComponent < Fluxbit::Component
  include Fluxbit::Config::DrawerComponent

  renders_one :header, lambda { |*args, **props, &block|
    # add(class: props[:class], to: @caption_html) if props[:class]
    # @caption_html = props.merge(@caption_html)
    # remove_class_from_props @caption_html

    block.call
  }

  ##
  # Initializes the table component with the given properties.
  #
  # @param [Hash] props The properties to customize the table.
  # @option props [Boolean] :striped (false) Determines if the table rows should be striped.
  # @option props [Boolean] :bordered (false) Determines if the table should have borders.
  # @option props [Boolean] :hover (false) Determines if the table rows should highlight on hover.
  # @option props [Boolean] :shadow (false) Determines if the table should have a shadow effect.
  # @option props [Hash] :wrapper_html Additional HTML attributes for the wrapper div.
  # @option props [Hash] :thead_html Additional HTML attributes for the table header.
  # @option props [Hash] :tbody_html Additional HTML attributes for the table body.
  # @option props [Hash] :tr_html Additional HTML attributes for the table rows.
  # @option props [Hash] :cells_html Additional HTML attributes for the table cells.
  #
  # @example
  #   = render Fluxbit::DrawerComponent.new(
  #     placement: :left,
  #     sizing: :md,
  #     show_close_button: true,
  #     swipeable: false,
  #     shadow: true
  #   ) do |drawer|
  #     drawer.with_header do |header|
  #       "Header Content"
  #     end
  #   end
  #
  # @return [Fluxbit::DrawerComponent]
  #
  def initialize(**props)
    super
    @props = props
    @placement = options(@props.delete(:placement), collection: styles[:placements].keys, default: @@placement).to_sym
    @sizing = options(@props.delete(:sizing), collection: styles[:sizes][:horizontal].keys, default: @@sizing).to_sym
    @show_close_button = options @props.delete(:show_close_button), default: @@show_close_button
    @swipeable = options @props.delete(:swipeable), default: @@swipeable
    @shadow = options @props.delete(:shadow), default: @@shadow
    @backdrop = options @props.delete(:backdrop), default: @@backdrop
    @auto_show = options @props.delete(:auto_show), default: @@auto_show
    @body_scrolling = options @props.delete(:body_scrolling), default: @@body_scrolling
    @edge_offset = @props.delete(:edge_offset)
    @backdrop_classes = @props.delete(:backdrop_classes)

    if @swipeable
      @placement = :bottom
      @show_close_button = false
    end

    @props[:id] ||= fx_id
    @props[:tabindex] = "-1"
    @props["aria-labelledby"] = "#{@props[:id]}-label"
    # binding.pry
    @using_stimulus = @props["data-fluxbit-drawer-target"].present? || @props["data-controller"].to_s.include?("fluxbit-drawer") ||
                      (
                        @props[:data].present? && (
                          @props[:data][:"fluxbit-drawer-target"].present? || (@props[:data][:controller] || "").to_s.include?("fluxbit-drawer")
                        )
                      )

    if @using_stimulus
      if @props["data-controller"].to_s.include?("fluxbit-drawer") || @props[:data][:controller].to_s.include?("fluxbit-drawer")
        @props["data-fluxbit-drawer-auto-show-value"] = @auto_show
        @props["data-fluxbit-drawer-placement-value"] = @placement.to_s
        @props["data-fluxbit-drawer-backdrop-value"] = @backdrop
        @props["data-fluxbit-drawer-body-scrolling-value"] = @body_scrolling
        @props["data-fluxbit-drawer-edge-value"] = @swipeable
        @props["data-fluxbit-drawer-edge-offset-value"] = @edge_offset if @edge_offset.present? && @swipeable
        @props["data-fluxbit-drawer-backdrop-classes-value"] = @backdrop_classes if @backdrop_classes.present?
      else
        @props["data-auto-show"] = @auto_show
        @props["data-placement"] = @placement.to_s
        @props["data-backdrop"] = @backdrop
        @props["data-body-scrolling"] = @body_scrolling
        @props["data-edge"] = @swipeable
        @props["data-edge-offset"] = @edge_offset if @edge_offset.present? && @swipeable
        @props["data-backdrop-classes"] = @backdrop_classes if @backdrop_classes.present?
      end
    end

    add(
      class: [ styles[:root],
              styles[:placements][@placement],
              styles[:color],
              @swipeable ? styles[:swipeable][:default] : nil,
              @shadow ? styles[:shadow] : nil,
              size_class ],
      to: @props
    )
  end

  def size_class
    styles[:sizes][@placement.in?([ :left, :right ]) ? :horizontal : :vertical][@sizing]
  end
end
