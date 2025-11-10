# frozen_string_literal: true

# The `Fluxbit::Form::TelephoneComponent` is a telephone input component that extends `Fluxbit::Form::TextFieldComponent`.
# It provides a styled telephone input with an integrated country code selector showing country flags and dialing codes.
# The input includes automatic masking for phone numbers.
#
# @example Basic usage
#   = render Fluxbit::Form::TelephoneComponent.new(name: :phone)
#
# @example With default country
#   = render Fluxbit::Form::TelephoneComponent.new(name: :phone, default_country: "BR")
#
class Fluxbit::Form::TelephoneComponent < Fluxbit::Form::TextFieldComponent
  include Fluxbit::Config::Form::TelephoneComponent

  # Initializes the telephone component with the given properties.
  #
  # @param default_country [String] The default country code (ISO 3166-1 alpha-2, e.g., "BR", "US")
  # @param country_field_name [String] Name for the hidden country code field (optional, deprecated in favor of :country)
  # @param country [Symbol] Attribute name for the country field when using form builder (e.g., :phone_country)
  # @param ... all other parameters from TextFieldComponent
  def initialize(**props)
    @default_country = props.delete(:default_country) || @@default_country
    @country_field_name = props.delete(:country_field_name)
    @country_attribute = props.delete(:country)

    # Set default sizing from config if not specified
    props[:sizing] = @@default_sizing unless props.key?(:sizing)

    # Force type to tel
    props[:type] = :tel

    super(**props)

    # Override the input classes to match our custom sizing
    override_input_sizing
  end

  def call
    content_tag :div, **@wrapper_html do
      safe_join [
        label,
        telephone_input_container,
        help_text
      ]
    end
  end

  private

  def override_input_sizing
    # Remove the original size classes
    current_classes = @props[:class].to_s

    # Get size class from config
    size_index = [@sizing, 0].max
    size_index = [size_index, @@telephone_styles[:input][:sizes].length - 1].min
    custom_size_class = @@telephone_styles[:input][:sizes][size_index]

    # Remove the old size class and add our custom one
    # First remove common padding/text classes that might conflict
    current_classes = current_classes.gsub(/\bp-[\d.]+\b/, "")
                                    .gsub(/\btext-(xs|sm|base|md|lg|xl)\b/, "")
                                    .gsub(/\brounded-lg\b/, "")
                                    .strip

    @props[:class] = "#{current_classes} #{custom_size_class}".strip
  end

  def current_country
    @@telephone_countries.find { |c| c[:code] == @default_country } || @@telephone_countries.first
  end

  def country_select
    content_tag :div, class: "relative flex-shrink-0" do
      if @form.present? && @country_attribute.present?
        # Use form builder's select to get proper name attribute
        @form.select(
          @country_attribute,
          options_for_select(
            @@telephone_countries.map { |c| [ "#{c[:flag]} #{c[:dial_code]}", c[:code], { "data-dial-code": c[:dial_code], "data-mask": c[:mask] } ] },
            country_select_value
          ),
          {},
          {
            id: country_select_id,
            class: country_select_classes,
            data: {
              fx_telephone_target: "countrySelect",
              action: "change->fx-telephone#updateMask"
            }
          }
        )
      else
        # Standalone select (no form builder)
        select_tag(
          country_select_name,
          country_options_html,
          id: country_select_id,
          class: country_select_classes,
          data: {
            fx_telephone_target: "countrySelect",
            action: "change->fx-telephone#updateMask"
          }
        )
      end
    end
  end

  def country_options_html
    safe_join(
      @@telephone_countries.map do |country|
        content_tag :option,
                    "#{country[:flag]} #{country[:dial_code]}",
                    value: country[:code],
                    selected: country[:code] == country_select_value,
                    data: {
                      dial_code: country[:dial_code],
                      mask: country[:mask]
                    }
      end
    )
  end

  def country_select_name
    # Only used in standalone mode
    @country_field_name || "#{@name}_country"
  end

  def country_select_value
    # Priority:
    # 1. Value from object attribute (when using form builder with country attribute)
    # 2. Default country
    if @form.present? && @country_attribute.present? && @object.present?
      @object.public_send(@country_attribute) rescue @default_country
    else
      @default_country
    end
  end

  def country_select_id
    "#{@props[:id] || @name}_country"
  end

  def country_select_classes
    # Get size from config
    size_index = [@sizing, 0].max
    size_index = [size_index, @@telephone_styles[:country_select][:sizes].length - 1].min
    size_config = @@telephone_styles[:country_select][:sizes][size_index]

    # Get color from config
    color = @color || :default
    color_classes = @@telephone_styles[:country_select][:colors][color] || @@telephone_styles[:country_select][:colors][:default]

    [
      @@telephone_styles[:country_select][:base],
      @@telephone_styles[:country_select][:width],
      size_config[:padding],
      size_config[:text],
      color_classes
    ].join(" ")
  end

  def telephone_input
    # Override the props to adjust styling for the telephone input
    input_props = @props.dup

    # Remove left border radius since it connects to the country select
    current_classes = input_props[:class] || ""
    input_props[:class] = current_classes.gsub("rounded-lg", "rounded-r-lg")

    # Store original props temporarily
    original_props = @props
    @props = input_props

    result = input

    # Restore original props
    @props = original_props

    result
  end

  def telephone_input_container
    content_tag :div,
                class: "flex w-full",
                data: {
                  controller: "fx-telephone",
                  fx_telephone_mask_value: current_country[:mask]
                } do
      safe_join([
        country_select,
        content_tag(:div, telephone_input, class: "relative flex-1")
      ])
    end
  end
end
