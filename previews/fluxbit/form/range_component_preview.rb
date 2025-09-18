# frozen_string_literal: true

# Fake Product model for form builder demonstrations
class Product
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :name, :string
  attribute :price, :decimal
  attribute :rating, :integer
  attribute :volume, :integer
  attribute :brightness, :integer
  attribute :size, :integer
  attribute :template, :string

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :rating, inclusion: { in: 1..5 }

  # Simulate persisted state
  def persisted?
    false
  end

  def id
    nil
  end

  def to_param
    nil
  end

  # Add methods to make it behave like a hash when needed
  def merge(other)
    self
  end

  def to_h
    attributes
  end

  def to_hash
    attributes
  end

  # Make it respond to common Rails model methods
  def model_name
    @model_name ||= ActiveModel::Name.new(self.class)
  end

  def self.model_name
    @model_name ||= ActiveModel::Name.new(self)
  end

  # Form routing helpers
  def new_record?
    !persisted?
  end

  def destroyed?
    false
  end

  # Required for form_with
  def to_key
    persisted? ? [id] : nil
  end

  def to_model
    self
  end

  # Human attribute names for I18n
  def self.human_attribute_name(attr, options = {})
    case attr.to_s
    when 'name' then 'Product Name'
    when 'price' then 'Price ($)'
    when 'rating' then 'Product Rating'
    when 'volume' then 'Volume Level'
    when 'brightness' then 'Brightness'
    when 'size' then 'Size'
    else
      attr.to_s.humanize
    end
  end
end

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
    @product ||= Product.new(
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
