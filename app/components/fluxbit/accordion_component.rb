# frozen_string_literal: true

# The `Fluxbit::AccordionComponent` renders an accordion component following Flowbite styles.
# It supports collapsible panels with headers and content, customizable icons, and various styling options.
class Fluxbit::AccordionComponent < Fluxbit::Component
  include Fluxbit::Config::AccordionComponent

  renders_many :panels, lambda { |**attrs, &block|
    panel = Panel.new(accordion_id: fx_id, flush: @flush, color: @color, **attrs)
    block.call(panel) if block_given?
    panel
  }

  ##
  # Initializes the accordion component with the given properties.
  #
  # @param [Hash] **props The properties to customize the accordion.
  # @option props [Boolean] :flush (false) When true, removes borders and rounded corners for seamless integration.
  # @option props [Symbol, String] :color (:default) The color theme for accordion panels (default, light, primary, secondary, success, danger, warning, info, dark).
  # @option props [Boolean] :collapse_all (false) When true, allows all panels to be collapsed simultaneously. When false, keeps at least one panel open.
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes for the accordion container.
  #
  # @return [Fluxbit::AccordionComponent]
  def initialize(**props)
    super
    @props = props
    @flush = options(@props.delete(:flush), default: @@flush)
    @color = options(@props.delete(:color), collection: styles[:colors].keys, default: @@color).to_sym
    @collapse_all = options(@props.delete(:collapse_all), default: @@collapse_all)
  end

  def before_render
    add to: @props, first_element: true, class: [
      styles[:base],
      @flush ? "" : "border border-gray-200 dark:border-gray-700 rounded-xl"
    ]
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
    @props[:id] ||= fx_id
    @props["data-accordion"] = @collapse_all ? "collapse" : "open"
  end

  def call
    tag.div(**@props) do
      safe_join(panels)
    end
  end

  class Panel < Fluxbit::Component
    include Fluxbit::Config::AccordionComponent
    renders_one :header
    renders_one :body

    ##
    # Initializes an accordion panel with the given properties.
    #
    # @param [String] accordion_id The parent accordion's ID for proper ARIA relationships.
    # @param [Boolean] flush (false) Whether the panel should use flush styling.
    # @param [Symbol, String] color (:default) The color theme for this panel.
    # @param [Boolean] open (false) Whether the panel should start in an expanded state.
    # @param [Integer] index (0) The panel's position index for proper styling (first, middle, last).
    # @param [Hash] **props Additional HTML attributes for the panel container.
    #
    # @return [Fluxbit::AccordionComponent::Panel]
    def initialize(accordion_id:, **props)
      super
      @props = props
      @accordion_id = accordion_id
      @flush = options(@props.delete(:flush), default: @@flush)
      @color = options(@props.delete(:color), collection: styles[:colors].keys, default: @@color).to_sym
      @open = options(@props.delete(:open), default: false)
      @index = options(@props.delete(:index), default: 0)
    end

    def call
      header_id = "#{@accordion_id}-header-#{@index}"
      content_id = "#{@accordion_id}-content-#{@index}"

      header_base = styles[:item][:header][:base]
      content_base = styles[:item][:content][:base]

      if @flush
        header_base = header_base.gsub(/border[^-]\S*/, "").gsub(/rounded-\S+/, "")
        content_base = content_base.gsub(/border[^-]\S*/, "").gsub(/rounded-\S+/, "")
      end

      header_classes = [
        header_base,
        styles[:colors][@color][:header],
        (@index == 0) ? styles[:item][:header][:first] : styles[:item][:header][:middle]
      ].compact.join(" ")

      content_classes = [
        content_base,
        styles[:colors][@color][:content],
        (@index == 0) ? styles[:item][:content][:first] : styles[:item][:content][:middle]
      ].compact.join(" ")

      tag.div(class: styles[:item][:base]) do
        concat(
          tag.h2(id: header_id) do
            tag.button(
              type: "button",
              class: header_classes,
              "data-accordion-target" => "##{content_id}",
              "aria-expanded" => @open.to_s,
              "aria-controls" => content_id
            ) do
              concat(tag.span(header || "Accordion Header"))
              concat(chevron_down(class: styles[:item][:icon][:base]))
            end
          end
        )
        concat(
          tag.div(
            body || "",
            id: content_id,
            class: [@open ? "" : "hidden", content_classes].join(" "),
            "aria-labelledby" => header_id
          )
        )
      end
    end
  end
end