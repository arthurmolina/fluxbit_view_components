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
  COUNTRIES = [
    { code: "BR", name: "Brasil", dial_code: "+55", flag: "🇧🇷", mask: "(##) #####-####" },
    { code: "US", name: "United States", dial_code: "+1", flag: "🇺🇸", mask: "(###) ###-####" },
    { code: "CA", name: "Canada", dial_code: "+1", flag: "🇨🇦", mask: "(###) ###-####" },
    { code: "GB", name: "United Kingdom", dial_code: "+44", flag: "🇬🇧", mask: "#### ### ####" },
    { code: "DE", name: "Germany", dial_code: "+49", flag: "🇩🇪", mask: "### #########" },
    { code: "FR", name: "France", dial_code: "+33", flag: "🇫🇷", mask: "# ## ## ## ##" },
    { code: "ES", name: "Spain", dial_code: "+34", flag: "🇪🇸", mask: "### ## ## ##" },
    { code: "IT", name: "Italy", dial_code: "+39", flag: "🇮🇹", mask: "### ### ####" },
    { code: "PT", name: "Portugal", dial_code: "+351", flag: "🇵🇹", mask: "### ### ###" },
    { code: "AR", name: "Argentina", dial_code: "+54", flag: "🇦🇷", mask: "## ####-####" },
    { code: "MX", name: "Mexico", dial_code: "+52", flag: "🇲🇽", mask: "## #### ####" },
    { code: "JP", name: "Japan", dial_code: "+81", flag: "🇯🇵", mask: "##-####-####" },
    { code: "CN", name: "China", dial_code: "+86", flag: "🇨🇳", mask: "### #### ####" },
    { code: "IN", name: "India", dial_code: "+91", flag: "🇮🇳", mask: "##### #####" },
    { code: "AU", name: "Australia", dial_code: "+61", flag: "🇦🇺", mask: "### ### ###" },
  ].freeze

  # Initializes the telephone component with the given properties.
  #
  # @param default_country [String] The default country code (ISO 3166-1 alpha-2, e.g., "BR", "US")
  # @param country_field_name [String] Name for the hidden country code field (optional)
  # @param ... all other parameters from TextFieldComponent
  def initialize(**props)
    @default_country = props.delete(:default_country) || "BR"
    @country_field_name = props.delete(:country_field_name)

    # Set default sizing to 1 (Medium) if not specified
    props[:sizing] = 1 unless props.key?(:sizing)

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

    # Define our custom size classes that make sense: Small < Medium < Large
    custom_size_class = case @sizing
    when 0
      "p-2 text-xs rounded-lg"        # Small
    when 1
      "p-2.5 text-sm rounded-lg"      # Medium
    when 2
      "p-4 text-base rounded-lg"      # Large
    else
      "p-2.5 text-sm rounded-lg"
    end

    # Remove the old size class and add our custom one
    # First remove common padding/text classes that might conflict
    current_classes = current_classes.gsub(/\bp-[\d.]+\b/, '')
                                    .gsub(/\btext-(xs|sm|base|md|lg|xl)\b/, '')
                                    .gsub(/\brounded-lg\b/, '')
                                    .strip

    @props[:class] = "#{current_classes} #{custom_size_class}".strip
  end

  def current_country
    COUNTRIES.find { |c| c[:code] == @default_country } || COUNTRIES.first
  end

  def country_select
    content_tag :div, class: "relative flex-shrink-0" do
      content_tag :select,
                  id: country_select_id,
                  name: @country_field_name || "#{@name}_country",
                  class: country_select_classes,
                  data: {
                    fx_telephone_target: "countrySelect",
                    action: "change->fx-telephone#updateMask"
                  } do
        safe_join(
          COUNTRIES.map do |country|
            content_tag :option,
                        "#{country[:flag]} #{country[:dial_code]}",
                        value: country[:code],
                        selected: country[:code] == @default_country,
                        data: {
                          dial_code: country[:dial_code],
                          mask: country[:mask]
                        }
          end
        )
      end
    end
  end

  def country_select_id
    "#{@props[:id] || @name}_country"
  end

  def country_select_classes
    # Override sizing to make more sense: Small < Medium < Large
    size_padding = case @sizing
    when 0
      "p-2"        # Small
    when 1
      "p-2.5"      # Medium
    when 2
      "p-4"        # Large
    else
      "p-2.5"
    end

    # Adjust text sizes to match
    size_text = case @sizing
    when 0
      "text-xs"    # Small
    when 1
      "text-sm"    # Medium
    when 2
      "text-base"  # Large
    else
      "text-sm"
    end

    [
      "mt-1",
      "block",
      "w-24",
      size_padding,
      size_text,
      "text-slate-900",
      "bg-slate-50",
      "border",
      "border-r-0",
      "border-slate-300",
      "rounded-l-lg",
      "focus:ring-blue-500",
      "focus:border-blue-500",
      "dark:bg-slate-700",
      "dark:border-slate-600",
      "dark:text-white",
      "dark:focus:ring-blue-500",
      "dark:focus:border-blue-500"
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
