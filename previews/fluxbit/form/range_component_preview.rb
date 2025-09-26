# frozen_string_literal: true

require_relative "shared/base_product_model"

class Fluxbit::Form::RangeComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::RangeComponent
  # --------------------------------
  # You can use this component to create range sliders for selecting numeric values within a specified range
  #
  # @param name [String] "Field name"
  # @param label [String] "Label text"
  # @param value [Number] "Current value"
  # @param min [Number] "Minimum value"
  # @param max [Number] "Maximum value"
  # @param step [Number] "Step increment"
  # @param vertical [Boolean] "Vertical orientation"
  # @param sizing select "Slider size" :sizing_options
  # @param help_text [String] "Help text below the field"
  # @param helper_popover [String] "Content for helper popover"
  # @param disabled [Boolean] "Disabled state"
  def playground(
    name: "volume",
    label: "Volume Level",
    value: 50,
    min: 0,
    max: 100,
    step: 1,
    vertical: false,
    sizing: 1,
    help_text: "Adjust the volume level from 0 to 100",
    helper_popover: "Use this slider to control the audio volume. Higher values increase the volume.",
    disabled: false)
    render Fluxbit::Form::RangeComponent.new(
      name: name,
      label: label.present? ? label : nil,
      value: value,
      min: min,
      max: max,
      step: step,
      vertical: vertical,
      sizing: sizing,
      help_text: help_text.present? ? help_text : nil,
      helper_popover: helper_popover.present? ? helper_popover : nil,
      disabled: disabled
    )
  end

  def basic_range; end
  def range_sizes; end
  def custom_range_values; end
  def vertical_range; end
  def with_helper_text; end
  def with_helper_popover; end
  def disabled_range; end
  def use_cases; end
  def with_form_builder
    @product ||= ::BaseProductModel.new(
      name: "Sample Product",
      price: 29.99,
      rating: 4,
      volume: 75,
      brightness: 50,
      size: 2
    )

    # Ensure the product is valid and ready for form display
    @product.valid? if @product
    @product
  end

  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def sizing_options
    (0...Fluxbit::Config::Form::RangeComponent.styles[:sizes].count).to_a
  end
end
