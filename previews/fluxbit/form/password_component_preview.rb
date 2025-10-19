# frozen_string_literal: true

require "ostruct"
require_relative "shared/base_product_model"

class Fluxbit::Form::PasswordComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::PasswordComponent
  # --------------------------------
  # Password input field with toggleable visibility and optional strength indicators
  #
  # @param name [String] "Field name"
  # @param label [String] "Label text"
  # @param placeholder [String] "Placeholder text"
  # @param show_strength [Boolean] "Show password strength indicators"
  # @param min_length [Integer] "Minimum password length"
  # @param require_uppercase [Boolean] "Require uppercase letters"
  # @param require_lowercase [Boolean] "Require lowercase letters"
  # @param require_numbers [Boolean] "Require numbers"
  # @param require_special [Boolean] "Require special characters"
  # @param color select "Validation state" :color_options
  # @param sizing select "Field size" :sizing_options
  # @param help_text [String] "Help text below field"
  # @param disabled [Boolean] "Disabled state"
  def playground(
    name: "password",
    label: "Password",
    placeholder: "Enter your password",
    show_strength: true,
    min_length: 8,
    require_uppercase: true,
    require_lowercase: true,
    require_numbers: true,
    require_special: false,
    color: :default,
    sizing: 0,
    help_text: "",
    disabled: false
  )
    render Fluxbit::Form::PasswordComponent.new(
      name: name,
      label: label.present? ? label : nil,
      placeholder: placeholder.present? ? placeholder : nil,
      show_strength: show_strength,
      min_length: min_length,
      require_uppercase: require_uppercase,
      require_lowercase: require_lowercase,
      require_numbers: require_numbers,
      require_special: require_special,
      color: color,
      sizing: sizing,
      help_text: help_text.present? ? help_text : nil,
      disabled: disabled
    )
  end

  # Basic password field without strength indicators
  # @label Basic
  def default; end

  # Password field with strength indicator
  # @label With Strength Indicator
  def with_strength; end

  # Password field with custom requirements
  # @label Custom Requirements
  def custom_requirements; end

  # Password field with all requirements enabled
  # @label Strict Requirements
  def strict_requirements; end

  # Password fields in different sizes
  # @label Different Sizes
  def sizes; end

  # Password field with validation state
  # @label Validation States
  def validation_states; end

  # Password field using form builder
  # @label With Form Builder
  def with_form_builder
    @user ||= OpenStruct.new(
      password: "",
      password_confirmation: ""
    )

    class << @user
      def model_name
        ActiveModel::Name.new(self.class, nil, "User")
      end

      def to_key
        nil
      end

      def persisted?
        false
      end
    end

    @user
  end

  # Password field disabled
  # @label Disabled
  def disabled; end

  private

  def color_options
    Fluxbit::Config::Form::TextFieldComponent.styles[:text].keys
  end

  def sizing_options
    (0...Fluxbit::Config::Form::TextFieldComponent.styles[:sizes].count).to_a
  end
end
