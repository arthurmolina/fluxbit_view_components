# frozen_string_literal: true

# Fake Product model for form builder demonstrations
class CheckBoxProduct
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
  attribute :featured, :boolean
  attribute :accept_terms, :boolean
  attribute :newsletter_signup, :boolean
  attribute :template, :string

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :accept_terms, acceptance: { accept: [true, 1, '1'] }

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

  def [](key)
    return nil if key.to_s == 'locals'
    return nil unless has_attribute?(key)
    public_send(key)
  rescue NoMethodError
    nil
  end

  def []=(key, value)
    return nil if key.to_s == 'locals'
    return nil unless has_attribute?(key)
    public_send("#{key}=", value)
  rescue NoMethodError
    nil
  end

  # Handle ViewComponent-specific methods that might be called
  def locals
    {}
  end


  def to_h
    attributes
  end

  def to_hash
    attributes
  end

  # Make it respond to common Rails model methods
  def model_name
    @model_name ||= begin
      model_name = ActiveModel::Name.new(CheckBoxProduct)
      # Override route key to prevent Rails from looking for routes
      def model_name.route_key
        "products"
      end
      def model_name.param_key
        "product"
      end
      model_name
    end
  end

  def self.model_name
    @model_name ||= begin
      model_name = ActiveModel::Name.new(self)
      # Override route key to prevent Rails from looking for routes
      def model_name.route_key
        "products"
      end
      def model_name.param_key
        "product"
      end
      model_name
    end
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

  # Additional methods for better Rails compatibility
  def read_attribute_for_validation(attr)
    public_send(attr)
  end

  def has_attribute?(attr)
    self.class.attribute_types.key?(attr.to_s)
  end

  def attribute_names
    self.class.attribute_names
  end

  def self.attribute_names
    @attribute_names ||= attribute_types.keys
  end

  # Human attribute names for I18n
  def self.human_attribute_name(attr, options = {})
    case attr.to_s
    when 'name' then 'Product Name'
    when 'available' then 'Available for Purchase'
    when 'featured' then 'Featured Product'
    when 'accept_terms' then 'Accept Terms and Conditions'
    when 'newsletter_signup' then 'Subscribe to Newsletter'
    else
      attr.to_s.humanize
    end
  end
end

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
  def playground(
    label: "Accept the terms",
    name: "accept_terms",
    value: "1",
    type: :check_box,
    help_text: "",
    helper_popover: "",
    helper_popover_placement: :right,
    disabled: false,
    checked: false)
    render Fluxbit::Form::CheckBoxComponent.new(
      label: label,
      name: name,
      value: value,
      type: type,
      help_text: help_text == "" ? nil : help_text,
      helper_popover: helper_popover == "" ? nil : helper_popover,
      helper_popover_placement: helper_popover_placement,
      disabled: disabled,
      checked: checked
    )
  end

  def basic_checkbox; end
  def radio_buttons; end
  def checkbox_group; end
  def checked_states; end
  def disabled_checkboxes; end
  def with_helper_text; end
  def with_helper_popover; end
  def inline_checkboxes; end
  def with_form_builder
    @product ||= begin
      product = CheckBoxProduct.new
      product.name = "Sample Product"
      product.available = true
      product.featured = false
      product.accept_terms = false
      product.newsletter_signup = true

      # Ensure the product is valid and ready for form display
      product.valid?
      product
    rescue => e
      # Fallback if there are any issues
      CheckBoxProduct.new(name: "Sample Product")
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
