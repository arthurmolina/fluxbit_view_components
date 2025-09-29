# frozen_string_literal: true

require_relative "shared/base_product_model"

class Fluxbit::Form::TextFieldComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::TextFieldComponent
  # --------------------------------
  # You can use this component to create various types of text input fields with support for icons, addons, and validation states
  #
  # @param name [String] "Field name"
  # @param label [String] "Label text"
  # @param value [String] "Field value"
  # @param placeholder [String] "Placeholder text"
  # @param type select "Input type" :type_options
  # @param icon select "Left icon" :icon_options
  # @param right_icon select "Right icon" :icon_options
  # @param addon [String] "Addon text or icon"
  # @param color select "Validation state" :color_options
  # @param sizing select "Field size" :sizing_options
  # @param shadow [Boolean] "Add drop shadow"
  # @param disabled [Boolean] "Disabled state"
  # @param readonly [Boolean] "Readonly state"
  # @param multiline [Boolean] "Multiline textarea"
  # @param help_text [String] "Help text below field"
  # @param helper_popover [String] "Helper popover content"
  def playground(
    name: "username",
    label: "Username",
    value: "",
    placeholder: "Enter your username",
    type: :text,
    icon: nil,
    right_icon: nil,
    addon: "",
    color: :default,
    sizing: 0,
    shadow: false,
    disabled: false,
    readonly: false,
    multiline: false,
    help_text: "Choose a unique username",
    helper_popover: "Username must be 3-20 characters long and contain only letters, numbers, and underscores")
    render Fluxbit::Form::TextFieldComponent.new(
      name: name,
      label: label.present? ? label : nil,
      value: value.present? ? value : nil,
      placeholder: placeholder.present? ? placeholder : nil,
      type: type,
      icon: icon,
      right_icon: right_icon,
      addon: addon.present? ? addon : nil,
      color: color,
      sizing: sizing,
      shadow: shadow,
      disabled: disabled,
      readonly: readonly,
      multiline: multiline,
      help_text: help_text.present? ? help_text : nil,
      helper_popover: helper_popover.present? ? helper_popover : nil
    )
  end

  def default; end
  def basic; end
  def input_types; end
  def password_with_icon; end
  def with_addon; end
  def with_icons; end
  def multiline; end
  def validation_states; end
  def sizes; end
  def with_helper_popover; end
  def disabled_readonly; end
  def with_shadow; end
  def with_form_builder
    @product ||= ::BaseProductModel.new(
      name: "Sample Product",
      description: "This is a sample product description for demonstration purposes.",
      price: 29.99,
      category: "Electronics",
      sku: "SAMPLE-001",
      stock_quantity: 100,
      email: "contact@example.com",
      website: "https://example.com"
    )

    # Ensure the product is valid and ready for form display
    @product.valid? if @product
    @product
  end

  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def color_options
    Fluxbit::Config::Form::TextFieldComponent.styles[:text].keys
  end

  def type_options
    Fluxbit::Form::TextFieldComponent::TYPE_OPTIONS
  end

  def sizing_options
    (0...Fluxbit::Config::Form::TextFieldComponent.styles[:sizes].count).to_a
  end

  def icon_options
    [ nil, "heroicons_solid:user", "heroicons_solid:envelope", "heroicons_solid:eye", "heroicons_solid:lock-closed", "heroicons_solid:phone", "heroicons_solid:calendar", "heroicons_solid:magnifying-glass", "heroicons_solid:credit-card" ]
  end
end
