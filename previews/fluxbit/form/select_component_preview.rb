# frozen_string_literal: true

# Fake Product model for form builder demonstrations
class Product
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :name, :string
  attribute :category, :string
  attribute :status, :string
  attribute :priority, :string
  attribute :country, :string
  attribute :time_zone, :string
  attribute :template, :string

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :category, presence: true

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
    when 'category' then 'Product Category'
    when 'status' then 'Product Status'
    when 'priority' then 'Priority Level'
    when 'country' then 'Country'
    when 'time_zone' then 'Time Zone'
    else
      attr.to_s.humanize
    end
  end
end

class Fluxbit::Form::SelectComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::SelectComponent
  # ------------------------
  #
  # @param id [String] "The id of the select element (optional)"
  # @param label [String] "The label for the select field (optional)"
  # @param help_text [String] "Additional help text for the select field (optional)"
  # @param helper_popover [String] "Content for a popover helper (optional)"
  # @param helper_popover_placement select "Placement of the popover (default: right)" :helper_popover_placement_options
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param value [String] "Value for the field (optional)"
  # @param grouped [Boolean] toggle "Enables grouped select options"
  # @param time_zone [Boolean] toggle "Uses Rails time zone select options"
  # @param color select "Color" :color_options
  # @param sizing [Integer] "Select size"
  # @param shadow [Boolean] toggle "Adds drop shadow if true"
  # @param disabled [Boolean] toggle "Disables the select if true"
  # @param multiple [Boolean] toggle "Allows multiple selections if true"
  def playground(
    id: 'select_playground', label: "User Role",
    help_text: "Choose a role for the user", helper_popover: "Helper popover", helper_popover_placement: "right",
    name: "role", value: nil, grouped: false, time_zone: false,
    color: :default, sizing: 1, shadow: false, disabled: false, multiple: false)
    render Fluxbit::Form::SelectComponent.new(
      id: id,
      label: label,
      help_text: help_text,
      helper_popover: helper_popover,
      helper_popover_placement: helper_popover_placement,
      name: name,
      value: value,
      options: basic_options,
      grouped: grouped,
      time_zone: time_zone,
      color: color,
      sizing: sizing,
      shadow: shadow,
      disabled: disabled,
      multiple: multiple,
    )
  end

  # Renders a basic select dropdown.
  def default; end
  def basic_select; end
  def with_prompt; end
  def grouped_options; end
  def time_zone_select; end
  def multiple_selection; end
  def validation_states; end
  def sizes; end
  def disabled; end
  def with_helper_text; end
  def with_form_builder
    @product ||= Product.new(
      name: "Sample Product",
      category: "electronics",
      status: "active",
      priority: "high",
      country: "US",
      time_zone: "America/New_York"
    )

    # Ensure the product is valid and ready for form display
    @product.valid? if @product
    @product
  end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def color_options
    [:default, :success, :danger, :warning, :info]
  end

  def helper_popover_placement_options
    %w[top right bottom left]
  end

  def basic_options
    [
      ["Administrator", "admin"],
      ["Editor", "editor"],
      ["Viewer", "viewer"],
      ["Guest", "guest"]
    ]
  end
end