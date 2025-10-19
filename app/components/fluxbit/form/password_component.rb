# frozen_string_literal: true

# The `Fluxbit::Form::PasswordComponent` is a password input component that extends `Fluxbit::Form::TextFieldComponent`.
# It provides a password field with a toggleable visibility icon (eye/eye-slash) and optional password strength indicators.
# The component can display validation checks for password requirements such as length, letters, capital letters, numbers, and special characters.
#
# @example Basic usage
#   = render Fluxbit::Form::PasswordComponent.new(name: :password)
#
# @example With password strength checks
#   = render Fluxbit::Form::PasswordComponent.new(name: :password, show_strength: true)
#
# @example Custom requirements
#   = render Fluxbit::Form::PasswordComponent.new(
#     name: :password,
#     show_strength: true,
#     min_length: 12,
#     require_uppercase: true,
#     require_lowercase: true,
#     require_numbers: true,
#     require_special: true
#   )
#
# @see docs/03_Forms/Password.md For detailed documentation and examples.
class Fluxbit::Form::PasswordComponent < Fluxbit::Form::TextFieldComponent
  # Initializes the password field component with the given properties.
  #
  # @param form [ActionView::Helpers::FormBuilder] The form builder (optional, for Rails forms)
  # @param attribute [Symbol] The model attribute to be used in the form (required if using form builder)
  # @param show_strength [Boolean] Whether to display password strength indicators (default: false)
  # @param min_length [Integer] Minimum password length requirement (default: 8)
  # @param require_uppercase [Boolean] Require at least one uppercase letter (default: true)
  # @param require_lowercase [Boolean] Require at least one lowercase letter (default: true)
  # @param require_numbers [Boolean] Require at least one number (default: true)
  # @param require_special [Boolean] Require at least one special character (default: false)
  # @param strength_labels [Hash] Custom labels for strength checks
  # @param ... any other options supported by TextFieldComponent
  def initialize(**props)
    @show_strength = props.delete(:show_strength) || false
    @min_length = props.delete(:min_length) || 8

    # Get boolean values, defaulting to true for uppercase/lowercase/numbers, false for special
    uppercase_val = props.delete(:require_uppercase)
    @require_uppercase = uppercase_val.nil? ? true : uppercase_val

    lowercase_val = props.delete(:require_lowercase)
    @require_lowercase = lowercase_val.nil? ? true : lowercase_val

    numbers_val = props.delete(:require_numbers)
    @require_numbers = numbers_val.nil? ? true : numbers_val

    @require_special = props.delete(:require_special) || false
    @strength_labels = props.delete(:strength_labels) || default_strength_labels

    # Force type to password and add eye icon for visibility toggle
    props[:type] = :password
    props[:right_icon] ||= :"heroicons_outline:eye"

    # Add data attributes for Stimulus controller
    props[:data] ||= {}
    # props[:data][:controller] = add_controller(props[:data][:controller], "fx-password")
    props[:data][:action] = add_action(props[:data][:action], "input->fx-password#validate")

    # Store right_icon_html for later use in create_right_icon
    @password_right_icon_html = props.delete(:right_icon_html) || {}

    # Set up wrapper_html with controller before calling super
    props[:wrapper_html] ||= {}
    props[:wrapper_html][:data] ||= {}
    props[:wrapper_html][:data][:controller] = "fx-password"
    props[:wrapper_html][:data].merge!(
      {
        "fx-password-target": "inputWrapper",
        "fx-password-min-length-value": @min_length,
        "fx-password-require-uppercase-value": @require_uppercase,
        "fx-password-require-lowercase-value": @require_lowercase,
        "fx-password-require-numbers-value": @require_numbers,
        "fx-password-require-special-value": @require_special
      }
    )


    super(**props)
  end

  def call
    content_tag :div, **@wrapper_html do
      safe_join [
        label,
        icon_container_wrapper,
        help_text,
        (@show_strength ? strength_indicator : nil)
      ].compact
    end
  end

  private

  def password_styles
    @password_styles ||= {
      strength_wrapper: "mt-2 space-y-2",
      strength_bar_wrapper: "space-y-1",
      strength_bar_label: "text-sm font-medium text-slate-700 dark:text-slate-300",
      strength_bar_container: "w-full bg-slate-200 rounded-full h-2 dark:bg-slate-700",
      strength_bar: "h-2 rounded-full transition-all duration-300 bg-slate-300 dark:bg-slate-600",
      checks_list: "space-y-1",
      check_item: "flex items-center gap-2 text-sm text-slate-600 dark:text-slate-400",
      check_icon: "flex-shrink-0 text-red-500 dark:text-red-400",
      check_label: ""
    }
  end

  def icon_container_wrapper
    content_tag :div,
      data: {
        "fx-password-target": "inputWrapper",
        "fx-password-min-length-value": @min_length,
        "fx-password-require-uppercase-value": @require_uppercase,
        "fx-password-require-lowercase-value": @require_lowercase,
        "fx-password-require-numbers-value": @require_numbers,
        "fx-password-require-special-value": @require_special
      } do
      icon_container
    end
  end

  def default_strength_labels
    {
      length: I18n.t("fluxbit.form.password.checks.length", default: "At least %{count} characters", count: @min_length),
      uppercase: I18n.t("fluxbit.form.password.checks.uppercase", default: "Contains uppercase letter"),
      lowercase: I18n.t("fluxbit.form.password.checks.lowercase", default: "Contains lowercase letter"),
      numbers: I18n.t("fluxbit.form.password.checks.numbers", default: "Contains number"),
      special: I18n.t("fluxbit.form.password.checks.special", default: "Contains special character"),
      strength: I18n.t("fluxbit.form.password.strength", default: "Password strength")
    }
  end

  def strength_indicator
    content_tag :div, class: password_styles[:strength_wrapper], data: { "fx-password-target": "strengthIndicator" } do
      safe_join [
        strength_bar,
        strength_checks
      ]
    end
  end

  def strength_bar
    content_tag :div, class: password_styles[:strength_bar_wrapper] do
      safe_join([
        content_tag(:div, class: password_styles[:strength_bar_label]) do
          content_tag :span, @strength_labels[:strength]
        end,
        content_tag(:div, class: password_styles[:strength_bar_container]) do
          content_tag :div,
            "",
            class: password_styles[:strength_bar],
            data: { "fx-password-target": "strengthBar" }
        end
      ])
    end
  end

  def strength_checks
    content_tag :ul, class: password_styles[:checks_list] do
      safe_join [
        strength_check(:length, @strength_labels[:length]),
        (@require_lowercase ? strength_check(:lowercase, @strength_labels[:lowercase]) : nil),
        (@require_uppercase ? strength_check(:uppercase, @strength_labels[:uppercase]) : nil),
        (@require_numbers ? strength_check(:numbers, @strength_labels[:numbers]) : nil),
        (@require_special ? strength_check(:special, @strength_labels[:special]) : nil)
      ].compact
    end
  end

  def strength_check(type, label)
    content_tag :li,
      class: password_styles[:check_item],
      data: { "fx-password-target": "check#{type.to_s.capitalize}" } do
      safe_join([
        # Icon container with both check and X icons
        content_tag(:span, class: password_styles[:check_icon]) do
          safe_join([
            # X icon (visible by default - password requirement not met)
            content_tag(:span,
              data: { "fx-password-target": "check#{type.to_s.capitalize}Fail" }
            ) do
              anyicon(:"heroicons_solid:x-circle", class: "size-4")
            end,
            # Check icon (hidden by default - password requirement met)
            content_tag(:span,
              class: "hidden",
              data: { "fx-password-target": "check#{type.to_s.capitalize}Pass" }
            ) do
              anyicon(:"heroicons_solid:check-circle", class: "size-4")
            end
          ])
        end,
        content_tag(:span, label, class: password_styles[:check_label])
      ])
    end
  end

  def add_controller(existing, new_controller)
    existing ? "#{existing} #{new_controller}" : new_controller
  end

  def add_action(existing, new_action)
    existing ? "#{existing} #{new_action}" : new_action
  end

  def add_class(existing, new_class)
    existing ? "#{existing} #{new_class}" : new_class
  end

  # Override to render both eye icons with toggle visibility
  def create_right_icon
    return "" if @right_icon.nil?

    # Build wrapper attributes
    wrapper_attrs = {
      class: add_class(@password_right_icon_html[:class], "absolute inset-y-0 right-0 flex items-center pr-3 cursor-pointer"),
      onclick: "", # Prevent pointer-events-none
      data: {
        action: "click->fx-password#toggleVisibility"
      }
    }

    content_tag :div, **wrapper_attrs do
      safe_join([
        # Eye icon (visible by default)
        content_tag(:div,
          class: "#{styles[:additional_icons][:class][@color]}",
          data: { "fx-password-target": "eyeIcon" }
        ) do
          eye_icon
        end,
        # Eye-slash icon (hidden by default)
        content_tag(:div,
          class: "#{styles[:additional_icons][:class][@color]} hidden",
          data: { "fx-password-target": "eyeSlashIcon" }
        ) do
          eye_slash_icon
        end
      ])
    end
  end
end
