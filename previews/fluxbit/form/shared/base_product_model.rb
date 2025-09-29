# frozen_string_literal: true

# Shared Product model for form component demonstrations
# This prevents method redefinition warnings when multiple preview files are loaded
class BaseProductModel
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

  # Additional attributes used across different form previews
  attribute :featured, :boolean
  attribute :accept_terms, :boolean
  attribute :newsletter_signup, :boolean
  attribute :notifications_enabled, :boolean
  attribute :auto_publish, :boolean
  attribute :public_listing, :boolean
  attribute :rating, :integer
  attribute :volume, :integer
  attribute :brightness, :integer
  attribute :size, :integer
  attribute :status, :string
  attribute :priority, :string
  attribute :country, :string
  attribute :time_zone, :string
  attribute :avatar, :string
  attribute :main_image, :string
  attribute :thumbnail, :string
  attribute :banner, :string
  attribute :logo, :string

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :sku, presence: true, format: { with: /\A[A-Z0-9-]+\z/, message: "must contain only uppercase letters, numbers, and hyphens" }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :website, format: { with: /\Ahttps?:\/\/[^\s]+\z/ }, allow_blank: true

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

  # Implement hash-like access methods for ViewComponent compatibility
  def [](key)
    send(key) if respond_to?(key)
  end

  def []=(key, value)
    send("#{key}=", value) if respond_to?("#{key}=")
  end

  def keys
    attributes.keys
  end

  def values
    attributes.values
  end

  def each(&block)
    attributes.each(&block)
  end

  def dig(*keys)
    result = self
    keys.each do |key|
      result = result[key]
      return nil if result.nil?
    end
    result
  end

  # Make it respond to common Rails model methods
  def model_name
    @model_name ||= begin
      model_name = ActiveModel::Name.new(self.class)
      # Override route key to use existing products route
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
      # Override route key to use existing products route
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
    persisted? ? [ id ] : nil
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
