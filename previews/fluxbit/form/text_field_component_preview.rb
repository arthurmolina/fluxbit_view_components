# frozen_string_literal: true

# Fake Product model for form builder demonstrations
class Product
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :name, :string
  attribute :description, :string
  attribute :price, :decimal
  attribute :category, :string
  attribute :sku, :string
  attribute :stock_quantity, :integer
  attribute :email, :string
  attribute :website, :string
  attribute :available, :boolean
  attribute :template, :string

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :sku, presence: true, format: { with: /\A[A-Z0-9-]+\z/, message: "must contain only uppercase letters, numbers, and hyphens" }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true

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
    when 'description' then 'Product Description'
    when 'price' then 'Price ($)'
    when 'category' then 'Category'
    when 'sku' then 'SKU'
    when 'stock_quantity' then 'Stock Quantity'
    when 'email' then 'Contact Email'
    when 'website' then 'Product Website'
    when 'available' then 'Available'
    else
      attr.to_s.humanize
    end
  end
end

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
    @product ||= Product.new(
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
    [nil, "heroicons_solid:user", "heroicons_solid:envelope", "heroicons_solid:eye", "heroicons_solid:lock-closed", "heroicons_solid:phone", "heroicons_solid:calendar", "heroicons_solid:magnifying-glass", "heroicons_solid:credit-card"]
  end
end
