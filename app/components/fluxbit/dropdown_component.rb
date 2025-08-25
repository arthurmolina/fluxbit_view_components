# frozen_string_literal: true

# The `Fluxbit::DropdownComponent` is a component for rendering customizable Dropdown containers.
class Fluxbit::DropdownComponent < Fluxbit::Component
  include Fluxbit::Config::DropdownComponent

  renders_many :items, Fluxbit::DropdownItemComponent

  # Initializes the Dropdown component with various customization options.
  #
  # @param sizing [Integer] The alignment of items. Defaults to `0` (small).
  # @param divider [Boolean] Whether the Dropdown has a division between the items. Defaults to `true`.
  # @param props [Hash] Additional HTML attributes for the container.
  def initialize(**props)
    @props = props
    @sizing = props.delete(:sizing) || @@sizing
    @auto_divider = options props.delete(:auto_divider), default: @@auto_divider
    @props[:id] ||= "dropdown-#{random_id}"

    add to: @props, class: [
      styles[:base],
      styles[:sizes][@sizing],
      @auto_divider ? styles[:auto_divider] : nil
    ]

    remove_class_from_props(@props)
  end

  def get_item
    @props[:id]
  end

  def call
    tag.div(**@props) do
      tag.ul(class: styles[:ul]) do
        concat(safe_join(items)) if items.any?
        concat(Fluxbit::DropdownItemComponent.new(content).render_in(view_context)) if content.present?
      end
    end
  end
end
