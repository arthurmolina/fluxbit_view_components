# frozen_string_literal: true

require_relative "shared/base_product_model"

class Fluxbit::Form::CheckBoxComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::CheckBoxComponent
  # --------------------------------
  # You can use this component to create checkboxes and radio buttons with various customization options
  #
  # @param label [String] "The label for the input field"
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param value [String] "Value for the field (optional)"
  # @param type select "Type" :type_options
  # @param help_text [String] "Additional help text for the input field (optional)"
  # @param helper_popover [String] "Content for a popover helper (optional)"
  # @param helper_popover_placement select "Placement of the popover" :helper_popover_placement_options
  # @param disabled [Boolean] toggle "Disables the input if true"
  # @param checked [Boolean] toggle "Marks the input as checked if true"
  # @param required [Boolean] toggle "Marks the field as required"
  def playground(
    label: "Accept the terms",
    name: "accept_terms",
    value: "1",
    type: :check_box,
    help_text: "",
    helper_popover: "",
    helper_popover_placement: :right,
    disabled: false,
    checked: false,
    required: false)
    render Fluxbit::Form::CheckBoxComponent.new(
      label: label,
      name: name,
      value: value,
      type: type,
      help_text: help_text == "" ? nil : help_text,
      helper_popover: helper_popover == "" ? nil : helper_popover,
      helper_popover_placement: helper_popover_placement,
      disabled: disabled,
      checked: checked,
      required: required
    )
  end

  def basic_checkbox; end
  def radio_buttons; end
  def checkbox_group; end
  def checked_states; end
  def disabled_checkboxes; end
  def required_field; end
  def with_helper_text; end
  def with_helper_popover; end
  def inline_checkboxes; end
  def with_form_builder
    @product ||= begin
      product = ::BaseProductModel.new
      product.name = "Sample Product"
      product.available = true
      product.featured = false
      product.accept_terms = false
      product.newsletter_signup = true

      # Ensure the product is valid and ready for form display
      product.valid?
      product
    rescue
      # Fallback if there are any issues
      ::BaseProductModel.new(name: "Sample Product")
    end
    @product
  end

  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def type_options
    Fluxbit::Form::CheckBoxComponent::TYPE_OPTIONS
  end

  def helper_popover_placement_options
    %w[top right bottom left]
  end
end
