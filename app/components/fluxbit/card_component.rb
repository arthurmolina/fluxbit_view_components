class Fluxbit::CardComponent < Fluxbit::Component
  # Define default styles for the card and its parts.
  cattr_accessor :styles, default: {
    base:         "",
    base_image_left: "flex flex-row",
    border:       "border border-gray-200 dark:border-gray-700",
    shadow:       "shadow-sm",
    rounded:      "rounded-lg",
    hoverable:    "transition-shadow hover:shadow-lg",
    clickable: {
      default: "cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-700",
      primary: "cursor-pointer hover:bg-blue-100 dark:hover:bg-blue-800",
      success: "cursor-pointer hover:bg-green-100 dark:hover:bg-green-800",
      danger:  "cursor-pointer hover:bg-red-100 dark:hover:bg-red-800"
    },
    # "flex flex-col items-center bg-white border border-gray-200 rounded-lg shadow-sm md:flex-row md:max-w-xl dark:border-gray-700"
    header:       "px-4 py-2 font-semibold text-gray-900 dark:text-gray-100",
    body:         "px-4 py-2 space-y-4",
    footer:       "px-4 py-2 text-sm text-gray-500 dark:text-gray-400",
    image_top:    "w-full",
    image_left:   "object-cover w-full rounded-t-lg h-96 md:h-auto md:w-48 md:rounded-none md:rounded-s-lg",
    content_left: "px-4 py-2",
    colors: {
      default: "bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100",
      primary: "bg-blue-50 text-blue-900 border-blue-200 dark:bg-blue-900 dark:text-white dark:border-blue-800",
      success: "bg-green-50 text-green-900 border-green-200 dark:bg-green-900 dark:text-white dark:border-green-800",
      danger:  "bg-red-50 text-red-900 border-red-200 dark:bg-red-900 dark:text-white dark:border-red-800"
    }
  }

  renders_one :header
  renders_one :footer
  renders_one :section

  # Initializes the card component with various customization options.
  #
  # @param color [Symbol] Color theme for the card (e.g., :default, :primary, :success).
  # @param shadow [Boolean] Whether to apply a drop shadow.
  # @param border [Boolean] Whether to display a border.
  # @param rounded [Boolean] Whether the card has rounded corners.
  # @param hoverable [Boolean] Whether to apply a hover effect.
  # @param image [String, nil] URL or path of an image to display (optional).
  # @param image_position [Symbol] Position of the image (:top or :left). Defaults to :top.
  # @param href [String, nil] Whether the entire card is clickable.
  # @param tooltip_text [String, nil] Text for a tooltip (optional).
  # @param tooltip_placement [String] Placement of the tooltip (e.g., "top", "right").
  # @param tooltip_trigger [String] Trigger event for the tooltip (e.g., "hover", "click").
  # @param popover_text [String, nil] Text for a popover (optional).
  # @param popover_placement [String] Placement of the popover.
  # @param popover_trigger [String] Trigger event for the popover.
  # @param props [Hash] Additional HTML attributes for the container.
  def initialize(color: :default, shadow: true, border: true, rounded: true, hoverable: false,
                 image: nil, image_position: :top, image_props: {},
                 tooltip_text: nil, tooltip_placement: "top", tooltip_trigger: "hover",
                 popover_text: nil, popover_placement: "top", popover_trigger: "click",
                 **props)
    @color             = color ? color.to_sym : :default
    @shadow            = shadow
    @border            = border
    @rounded           = rounded
    @hoverable         = hoverable
    @image             = image
    @image_position    = image_position.to_sym
    @image_props       = image_props
    @tooltip_text      = tooltip_text
    @tooltip_placement = tooltip_placement
    @tooltip_trigger   = tooltip_trigger
    @popover_text      = popover_text
    @popover_placement = popover_placement
    @popover_trigger   = popover_trigger
    @props             = props
    @image_props[:src] = @image
  end

  def before_render
    add to: @props, first_element: true, class: [
      styles[:base],
      @border ? styles[:border] : nil,
      @shadow ? styles[:shadow] : nil,
      @rounded ? styles[:rounded] : nil,
      styles[:colors][@color] || nil,
      @hoverable ? styles[:hoverable] : nil,
      @props[:href] ? styles[:clickable][@color] : nil,
      (@image && @image_position == :left) ? styles[:base_image_left] : nil
    ]
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def call
    container_tag = @props[:href] ? :a : :div

    header_html = header ? content_tag(:div, header, class: self.class.styles[:header]) : nil
    footer_html = footer ? content_tag(:div, footer, class: self.class.styles[:footer]) : nil
    body_content = section ? section : nil

    if @image && @image_position == :top
      # Top image layout: image at the top, then header, body, and footer.
      add(class: styles[:image_top], to: @image_props)
      image_html = content_tag(:img, nil, **@image_props)
      body_html  = body_content ? content_tag(:div, body_content, class: self.class.styles[:body]) : nil

      content_tag(container_tag, **@props) do
        concat(image_html)
        concat(header_html) if header_html
        concat(body_html) if body_html
        concat(footer_html) if footer_html
      end
    elsif @image && @image_position == :left
      # Left image layout: image on the left and content on the right in a flex container.
      add(class: styles[:image_left], to: @image_props)
      image_html = content_tag(:div, class: "x") do
        content_tag(:img, nil, **@image_props)
      end
      content_inner = "".html_safe
      content_inner << header_html.to_s if header_html
      if body_content.present?
        content_inner << content_tag(:div, body_content, class: self.class.styles[:body] + " " + self.class.styles[:content_left])
      end
      content_inner << footer_html.to_s if footer_html

      content_tag(container_tag, **@props) do
        concat(image_html)
        concat(content_tag(:div, content_inner, class: "flex-1"))
      end
    else
      # Fallback: render without image or with an unrecognized image_position.
      body_html = body_content ? content_tag(:div, body_content, class: self.class.styles[:body]) : nil
      content_tag(container_tag, **@props) do
        concat(header_html) if header_html
        concat(body_html) if body_html
        concat(footer_html) if footer_html
      end
    end
  end
end
