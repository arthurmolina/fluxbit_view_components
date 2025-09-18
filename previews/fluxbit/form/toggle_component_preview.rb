# frozen_string_literal: true

# Fake Product model for form builder demonstrations
class Product
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :name, :string
  attribute :available, :boolean
  attribute :featured, :boolean
  attribute :notifications_enabled, :boolean
  attribute :auto_publish, :boolean
  attribute :public_listing, :boolean
  attribute :template, :string

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }

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
    when 'available' then 'Available for Purchase'
    when 'featured' then 'Featured Product'
    when 'notifications_enabled' then 'Enable Notifications'
    when 'auto_publish' then 'Auto-publish Updates'
    when 'public_listing' then 'Public Listing'
    else
      attr.to_s.humanize
    end
  end
end

class Fluxbit::Form::ToggleComponentPreview < ViewComponent::Preview
  # Fluxbit::Form::ToggleComponent
  # ------------------------
  #
  # @param id [String] "The id of the toggle element (optional)"
  # @param label [String] "The label for the toggle field (optional)"
  # @param other_label [String] "Additional label on the other side (optional)"
  # @param help_text [String] "Additional help text for the toggle field (optional)"
  # @param helper_popover [String] "Content for a popover helper (optional)"
  # @param helper_popover_placement select "Placement of the popover (default: right)" :helper_popover_placement_options
  # @param name [String] "Name of the field (required, unless using form builder)"
  # @param checked [Boolean] toggle "Checked state of the toggle"
  # @param value [String] "Value when toggle is checked"
  # @param color select "Checked toggle color" :color_options
  # @param unchecked_color select "Unchecked toggle color" :unchecked_color_options
  # @param button_color select "Toggle button color" :button_color_options
  # @param sizing select "Toggle size" :sizing_options
  # @param invert_label [Boolean] toggle "Invert label and toggle position"
  # @param disabled [Boolean] toggle "Disables the toggle if true"
  def playground(
    id: 'toggle_playground', label: "Enable notifications", other_label: "",
    help_text: "Receive email notifications", helper_popover: "Toggle notifications on or off", helper_popover_placement: "right",
    name: "notifications", checked: false, value: "1", color: :default, unchecked_color: :default, button_color: :default,
    sizing: 1, invert_label: false, disabled: false)
    render Fluxbit::Form::ToggleComponent.new(
      id: id,
      label: label,
      other_label: other_label.presence,
      help_text: help_text,
      helper_popover: helper_popover,
      helper_popover_placement: helper_popover_placement,
      name: name,
      checked: checked,
      value: value,
      color: color,
      unchecked_color: unchecked_color,
      button_color: button_color,
      sizing: sizing,
      invert_label: invert_label,
      disabled: disabled,
    )
  end

  # Renders a basic toggle switch.
  def default; end
  def basic_toggle; end
  def toggle_colors; end
  def toggle_sizes; end
  def unchecked_colors; end
  def button_colors; end
  def inverted_label; end
  def toggle_states; end
  def disabled; end
  def with_helper_text; end
  def with_helper_popover; end
  def with_additional_label; end
  def with_form_builder
    @product ||= Product.new(
      name: "Sample Product",
      available: true,
      featured: false,
      notifications_enabled: true,
      auto_publish: false,
      public_listing: true
    )

    # Ensure the product is valid and ready for form display
    @product.valid? if @product
    @product
  end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def color_options
    Fluxbit::Config::Form::ToggleComponent.styles[:toggle][:checked].keys
  end

  def unchecked_color_options
    Fluxbit::Config::Form::ToggleComponent.styles[:toggle][:unchecked].keys
  end

  def button_color_options
    Fluxbit::Config::Form::ToggleComponent.styles[:toggle][:button].keys
  end

  def sizing_options
    (0...Fluxbit::Config::Form::ToggleComponent.styles[:toggle][:sizes].count).to_a
  end

  def helper_popover_placement_options
    %w[top right bottom left]
  end
end
