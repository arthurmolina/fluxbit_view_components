# frozen_string_literal: true

# The `Fluxbit::Form::TextFieldComponent` is a form input component that extends `Fluxbit::Form::FieldComponent`.
# It provides a styled text input (or textarea) with support for various HTML input types, optional icons or add-on content,
# and color-coded validation states (e.g. default, success, error).
#
# @example Basic usage
#   = render Fluxbit::Form::TextFieldComponent.new(name: :email)
#
# @see docs/03_Forms/TextField.md For detailed documentation and examples.
class Fluxbit::Form::TextFieldComponent < Fluxbit::Form::FieldComponent
  TYPE_DEFAULT = :text
  TYPE_OPTIONS = %i[text textarea text_area color number email password search tel url date datetime_local month time week currency]
  include Fluxbit::Config::Form::TextFieldComponent

  # Initializes the text field component with the given properties.
  #
  # @param form [ActionView::Helpers::FormBuilder] The form builder (optional, for Rails forms)
  # @param attribute [Symbol] The model attribute to be used in the form (required if using form builder)
  # @param id [String] The id of the input element (optional)
  # @param label [String] The label for the input field (optional)
  # @param help_text [String] Additional help text for the input field (optional)
  # @param helper_popover [String] Content for a popover helper (optional)
  # @param helper_popover_placement [String] Placement of the popover (default: "right")
  # @param name [String] Name of the field (required, unless using form builder)
  # @param value [String] Value for the field (optional)
  # @param type [Symbol] Input type (`:text`, `:email`, etc)
  # @param icon [Symbol] Left icon (optional)
  # @param right_icon [Symbol] Right icon (optional)
  # @param addon [String] Add-on text or icon before the input (optional)
  # @param addon_html [Hash] Props for the Add-on (optional)
  # @param icon_html [Hash] Props for the left icon (optional)
  # @param right_icon_html [Hash] Props for the right icon (optional)
  # @param div_html [Hash] Props for the whole div (optional)
  # @param multiline [Boolean] Renders a textarea if true
  # @param color [Symbol] Field color (`:default`, `:success`, `:danger`, etc)
  # @param sizing [Integer] Input size
  # @param shadow [Boolean] Adds drop shadow if true
  # @param disabled [Boolean] Disables the input if true
  # @param readonly [Boolean] Makes the input readonly if true
  # @param ... any other HTML attribute supported by input/textarea
  def initialize(**props)
    super(**props)
    @color = valid_color(@props.delete(:color))
    @type = options(@props.delete(:type), collection: TYPE_OPTIONS, default: TYPE_DEFAULT)
    @icon = @props.delete(:icon)
    @multiline = options(@props.delete(:multiline), default: false)
    @shadow = @props.delete(:shadow)
    @addon = @props.delete(:addon)
    @right_icon = @props.delete(:right_icon)
    @addon_html = @props.delete(:addon_html) || {}
    @div_html = @props.delete(:div_html) || {}
    @icon_html = @props.delete(:icon_html) || {}
    @right_icon_html = @props.delete(:right_icon_html) || {}
    @sizing = sizing_with_addon @props.delete(:sizing)
    @props[:type] = @type

    declare_classes
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def call
    content_tag :div, **@wrapper_html do
      safe_join [ label, icon_container, help_text ]
    end
  end

  private

  def valid_color(color)
    return color if styles[:bg].key?(color)
    return :danger if errors.present?

    @@color
  end

  def sizing_with_addon(sizing)
    sizing.to_i < styles[:sizes].count ? sizing.to_i : @@sizing
  end

  def declare_classes
    add to: @props,
        first_element: true,
        class: [
          styles[:default],
          (@props.key?(:readonly) || @props.key?(:disabled) ? styles[:text][@color] : nil),
          styles[:ring][@color],
          styles[:bg][@color],
          styles[:placeholder][@color],
          styles[:border][@color],
          @addon ? styles[:sizing_md_addon] : styles[:sizes][@sizing],
          (@shadow ? styles[:shadow] : nil),
          (@right_icon ? styles[:right_icon] : nil),
          (@icon ? styles[:icon] : nil)
        ].compact.join(" ")
  end

  def icon(icon_v, tag: :div, props: nil)
    return "" if icon_v.blank?

    content_tag(
      tag,
      anyicon(
        icon_v,
        class: styles[:additional_icons][:class][@color]
      ),
      **props
    )
  end

  def create_icon
    add class: styles[:additional_icons][:icon], to: @icon_html
    add(class: "pointer-events-none", to: @icon_html) unless events?(@icon_html)
    icon(@icon, props: @icon_html)
  end

  def create_addon
    add class: styles[:additional_icons][:addon][@color], to: @addon_html
    icon(@addon, tag: :span, props: @addon_html)
  end

  def create_right_icon
    add class: styles[:additional_icons][:right_icon], to: @right_icon_html
    add(class: "pointer-events-none", to: @right_icon_html) unless events?(@right_icon_html)
    icon(@right_icon, props: @right_icon_html)
  end

  def events?(props)
    props.keys.intersection(
      %i[onclick onsubmit onchange onkeydown onkeyup onkeypress href]
    ).present?
  end

  def input
    input_type = case @type
    when :text
      @multiline ? "text_area" : "text_field"
    when :tel then "telephone_field"
    when :currency then "text_field"
    when :textarea, :text_area then "text_area"
    else
      "#{@type}_field"
    end

    if @form.present? && @attribute.present?
      @form.public_send(input_type, @attribute, @props)
    else
      public_send("#{input_type}_tag", @name, @value, @props)
    end
  end

  def icon_container_with_addon
    add class: "flex", to: @div_html
    content_tag :div, safe_join([ create_addon, create_right_icon, input ]), @div_html
  end

  def icon_container_without_addon
    add class: "relative w-full", to: @div_html
    content_tag :div, safe_join([ create_icon, create_right_icon, input ]), @div_html
  end

  def icon_container
    return input if @icon.nil? && @right_icon.nil? && @addon.nil?
    return icon_container_with_addon unless @addon.nil?

    icon_container_without_addon
  end
end
