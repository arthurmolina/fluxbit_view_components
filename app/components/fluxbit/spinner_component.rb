# frozen_string_literal: true

# The `Fluxbit::SpinnerComponent` is a component for rendering loading spinners.
class Fluxbit::SpinnerComponent < Fluxbit::Component
  include Fluxbit::Config::SpinnerComponent

  # Initializes the Spinner component with various customization options.
  #
  # @param [Hash] **props The properties to customize the spinner.
  # @option props [Symbol] :color (:default) The color theme of the spinner (:default, :info, :success, :failure, :warning, :pink, :purple).
  # @option props [Integer] :size (1) The size of the spinner (0 to 4).
  # @option props [String] :label ('Loading...') The aria-label for accessibility.
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::SpinnerComponent]
  def initialize(**props)
    super
    @props = props

    @color = options @props.delete(:color), collection: [ :default, :info, :success, :failure, :warning, :pink, :purple ], default: @@color
    @size = options @props.delete(:size), collection: (0..4).to_a, default: @@size
    @label = @props.delete(:label) || @@label

    add class: [
      styles[:base],
      styles[:sizes][@size.to_i],
      styles[:colors][@color]
    ], to: @props

    # Add accessibility attributes
    @props[:role] = "status"
    @props[:"aria-label"] = @label

    remove_class_from_props(@props)
  end

  private

  def spinner_classes
    [
      styles[:base],
      styles[:sizes][@size.to_i],
      styles[:colors][@color]
    ].compact.join(" ")
  end

  def screen_reader_classes
    styles[:screen_reader]
  end
end
