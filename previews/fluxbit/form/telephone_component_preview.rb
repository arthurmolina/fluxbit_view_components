# frozen_string_literal: true

require_relative "shared/base_product_model"

class Fluxbit::Form::TelephoneComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::TelephoneComponent
  # --------------------------------
  # A telephone input component with country code selector and automatic phone number masking
  #
  # @param name [String] "Field name"
  # @param label [String] "Label text"
  # @param value [String] "Field value"
  # @param placeholder [String] "Placeholder text"
  # @param default_country select "Default country" :country_options
  # @param color select "Validation state" :color_options
  # @param sizing select "Field size" :sizing_options
  # @param disabled [Boolean] "Disabled state"
  # @param readonly [Boolean] "Readonly state"
  # @param required [Boolean] "Marks the field as required"
  # @param help_text [String] "Help text below field"
  def playground(
    name: "phone",
    label: "Phone Number",
    value: "",
    placeholder: "Enter your phone number",
    default_country: "BR",
    color: :default,
    sizing: 0,
    disabled: false,
    readonly: false,
    required: false,
    help_text: "Enter your phone number with country code")
    render Fluxbit::Form::TelephoneComponent.new(
      name: name,
      label: label.present? ? label : nil,
      value: value.present? ? value : nil,
      placeholder: placeholder.present? ? placeholder : nil,
      default_country: default_country,
      color: color,
      sizing: sizing,
      disabled: disabled,
      readonly: readonly,
      required: required,
      help_text: help_text.present? ? help_text : nil
    )
  end

  # @label Default
  def default
    render Fluxbit::Form::TelephoneComponent.new(
      name: "phone",
      label: "Phone Number",
      placeholder: "Enter your phone number"
    )
  end

  # @label With Different Countries
  def with_different_countries; end

  # @label Validation States
  def validation_states; end

  # @label Different Sizes
  def sizes; end

  # @label Disabled and Readonly
  def disabled_readonly; end

  # @label Required Field
  def required_field
    render Fluxbit::Form::TelephoneComponent.new(
      name: "phone",
      label: "Phone Number",
      required: true,
      help_text: "Phone number is required"
    )
  end

  # @label With Form Builder
  def with_form_builder
    @product ||= ::BaseProductModel.new(
      name: "Sample Product",
      phone: "5511999998888"
    )

    @product.valid? if @product
    @product
  end

  private

  def color_options
    Fluxbit::Config::Form::TextFieldComponent.styles[:text].keys
  end

  def sizing_options
    (0...Fluxbit::Config::Form::TextFieldComponent.styles[:sizes].count).to_a
  end

  def country_options
    Fluxbit::Form::TelephoneComponent::COUNTRIES.map { |c| c[:code] }
  end
end
