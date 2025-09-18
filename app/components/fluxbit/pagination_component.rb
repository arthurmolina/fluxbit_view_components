# The `Fluxbit::PaginationComponent` is a component for rendering customizable pagination controls.
# It extends `Fluxbit::Component` and provides options for configuring the pagination's
# appearance, behavior, and content areas. You can control the pagination's layout, item count,
# and other interactive elements. The pagination is divided into different sections (previous, next, etc.),
# each of which can be styled or customized through various properties.
class Fluxbit::PaginationComponent < Fluxbit::Component
  include Fluxbit::Config::PaginationComponent

  def initialize(pagy = nil, **props)
    @pagy = pagy

    @props = props
    @count = @props.delete(:count) || 0
    @last = @props.delete(:last) || 1
    @next = @props.delete(:next)
    @page = @props.delete(:page) || 1
    @prev = @props.delete(:prev)
    @size = @props.delete(:size) || :default
    @ends = @props.delete(:ends) || true
    @request_path = @props.delete(:request_path) || nil

    if @pagy
      @count = @pagy.count
      @last = @pagy.last
      @next = @pagy.next
      @page = @pagy.page
      @prev = @pagy.prev
      @size = @pagy.vars[:size]
      @ends = @pagy.vars[:ends]
      @request_path = @pagy.vars[:request_path]
    end

    unless @size.is_a?(Integer) && @size >= 0
      raise ArgumentError, "expected :size to be an Integer >= 0, got #{@size.inspect} (#{@size.class})"
    end

    @show_first_last = options @props.delete(:show_first_last), default: @@show_first_last
    @show_prev_next = options @props.delete(:show_prev_next), default: @@show_prev_next
    @show_pages = options @props.delete(:show_pages), default: @@show_pages
    @show_icons = options @props.delete(:show_icons), default: @@show_icons
    @show_texts = options @props.delete(:show_texts), default: @@show_texts
    @sizing = options @props.delete(:sizing), default: @@sizing
    @aria_label = @props.delete(:aria_label) || translate("aria_label.nav", count: @last)
    @show_texts = true if !@show_icons && !@show_texts

    add(class: [ styles[:root], styles[:sizes][@sizing][:root] ], to: @props)
    @page_link_style = [ styles[:page_link], styles[:sizes][@sizing][:page_link] ].join(" ")
    @current_style = [ styles[:current], styles[:sizes][@sizing][:page_link] ].join(" ")
    @props[:aria] ||= {}
    @props[:aria][:label] = @aria_label unless @props[:aria][:label]
  end

  def call
    tag.nav(**@props) do
      concat first_button if @show_first_last
      concat prev_button if @show_prev_next

      if @show_pages
        series.each do |item|
          case item
          when Integer
            concat(tag.a(item.to_s, href: url_for(item), role: "link", class: @page_link_style, aria: { label: item.to_s }))
          when String
            concat(tag.a(item.to_s, role: "link", class: @current_style, aria: { disabled: true, current: "page" }))
          when :gap
            concat(tag.a(ellipsis_horizontal, role: "link", class: @page_link_style, aria: { disabled: true }))
          end
        end
      end

      concat next_button if @show_prev_next
      concat last_button if @show_first_last
    end
  end

  private

  def translate(key, options = {})
    I18n.t(key, **options.merge(scope: "fluxbit.pagination")) # , default: Fluxbit::DEFAULT_TRANSLATIONS["fluxbit.pagination.#{key}"]))
  end

  def first_button
    props = { role: "link", class: @page_link_style, aria: { label: translate("aria_label.first") } }
    if @page != 1
      props[:href] = url_for(1)
    else
      props[:aria][:disabled] = true
      add class: styles[:disabled], to: props, first_element: true
    end
    add class: styles[:previous], to: props

    tag.a(**props) do
      concat(chevron_double_left) if @show_icons
      concat(tag.span(
        translate("first"),
        class: @show_texts ? (@show_icons ? styles[:text_with_icon_prev] : styles[:only_text]) : styles[:only_icon]
      ))
    end
  end

  def last_button
    props = { role: "link", class: @page_link_style, aria: { label: translate("aria_label.last") } }
    if @page != @last
      props[:href] = url_for(@last)
    else
      props[:aria][:disabled] = true
      add class: styles[:disabled], to: props, first_element: true
    end
    add class: styles[:next], to: props

    tag.a(**props) do
      concat(tag.span(
        translate("last"),
        class: @show_texts ? (@show_icons ? styles[:text_with_icon_next] : styles[:only_text]) : styles[:only_icon]
      ))
      concat(chevron_double_right) if @show_icons
    end
  end

  def prev_button
    props = { role: "link", class: @page_link_style, aria: { label: translate("aria_label.prev") } }
    if prev_page = @prev
      props[:href] = url_for(prev_page)
    else
      props[:aria][:disabled] = true
      add class: styles[:disabled], to: props, first_element: true
    end
    add(class: styles[:previous], to: props) unless @show_first_last

    tag.a(**props) do
      concat(chevron_left) if @show_icons
      concat(tag.span(
        translate("prev"),
        class: @show_texts ? (@show_icons ? styles[:text_with_icon_prev] : styles[:only_text]) : styles[:only_icon]
        )
      )
    end
  end

  def next_button
    props = { role: "link", class: @page_link_style, aria: { label: translate("aria_label.next") } }
    if next_page = @next
      props[:href] = url_for(next_page)
    else
      props[:aria][:disabled] = true
      add class: styles[:disabled], to: props, first_element: true
    end
    add(class: styles[:next], to: props) unless @show_first_last

    tag.a(**props) do
      concat(tag.span(
        translate("next"),
        class: @show_texts ? (@show_icons ? styles[:text_with_icon_next] : styles[:only_text]) : styles[:only_icon]
      ))
      concat(chevron_right) if @show_icons
    end
  end

  def series
    return @pagy.series(size: @size) if @pagy && @pagy.respond_to?(:series, true)
    return [] if @size.zero?

    [].tap do |series|
      if @size >= @last
        series.push(*1..@last)
      else
        left  = ((@size - 1) / 2.0).floor            # left half might be 1 page shorter for even size
        start = if @page <= left                     # beginning pages
                  1
        elsif @page > (@last - @size + left) # end pages
                  @last - @size + 1
        else                                 # intermediate pages
                  @page - left
        end
        series.push(*start...start + @size)
        # Set first and last pages plus gaps when needed, respecting the size
        if @ends && @size >= 7
          series[0]  = 1
          series[1]  = :gap  unless series[1]  == 2
          series[-2] = :gap  unless series[-2] == @last - 1
          series[-1] = @last
        end
      end
      series[series.index(@page)] = @page.to_s
    end
  end

  def url_for(page)
    vars = @pagy&.vars || {}
    # Use current request parameters as base
    params = (respond_to?(:request) ? request.GET : controller.request.GET).dup
    params.merge!(vars[:params].transform_keys(&:to_s)) if vars[:params].is_a?(Hash)
    # Set page and possibly limit
    params[vars[:page_param].to_s] = page
    params[vars[:limit_param].to_s] = vars[:limit] if vars[:limit_extra]
    # Apply params proc if given
    params = vars[:params].call(params) if vars[:params].is_a?(Proc)

    # Build query string
    query_str = params.any? ? "?#{Rack::Utils.build_nested_query(params)}" : ""
    # Base path (use stored request_path or current path)
    base_path = @request_path || (respond_to?(:request) ? request.path : controller.request.path)
    base_path = "#{request.base_url}#{base_path}" if vars[:absolute]
    "#{base_path}#{query_str}#{vars[:fragment] || ''}"
  end
end
