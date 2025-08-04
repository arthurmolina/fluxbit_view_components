# frozen_string_literal: true

##
# The `Fluxbit::TableComponent` is a customizable alert component that extends `Fluxbit::Component`.
# It provides various options to display alert messages with different styles, icons, and behaviors
# such as close functionality and animations.
#
# Example usage:
#   = render Fluxbit::TableComponent.new(
#     striped: true,
#     bordered: true,
#     hover: true,
#     shadow: true,
#     wrapper_html: { class: "my-custom-wrapper" },
#     thead_html: { class: "my-custom-thead" },
#     tbody_html: { class: "my-custom-tbody" },
#     tr_html: { class: "my-custom-tr" }
#   ) do |table|
#     table.with_header do |header|
#       header.with_column "Column 1"
#       header.with_column "Column 2"
#     end
#
#     table.with_row do |row|
#       row.with_cell "Data 1"
#       row.with_cell "Data 2"
#     end
#   end
#
class Fluxbit::TableComponent < Fluxbit::Component
  include Fluxbit::Config::TableComponent

  renders_one :footer, lambda { |*args, **props, &block|
    add class: styles[:footer][:base], to: props
    props[:as] ||= :tr
    remove_class_from_props props

    props[:cells_html] ||= {}
    props[:cells_html][:as] ||= :td
    props[:cells_html][:scope] ||= :row
    add(class: styles[:footer][:cell], to: props[:cells_html])
    remove_class_from_props props[:cells_html]

    Fluxbit::TableGroupComponent.new(*args, **props, &block)
  }

  renders_many :headers, lambda { |*args, **props, &block|
    add class: styles[:head][:base], to: props
    props[:as] ||= :tr
    remove_class_from_props props

    props[:cells_html] ||= {}
    props[:cells_html][:as] ||= :th
    props[:cells_html][:scope] ||= :col
    add(class: styles[:head][:cell], to: props[:cells_html])
    remove_class_from_props props[:cells_html]

    Fluxbit::TableGroupComponent.new(*args, **props, &block)
  }

  renders_many :rows, lambda { |*args, **props, &block|
    color = props.delete(:color) || :default
    add(class: styles[:row][:base], to: props)
    add(class: styles[:row][:striped][color], to: props) if @striped
    add(class: styles[:row][:hovered][color], to: props) if @hover
    add(class: styles[:row][:bordered], to: props) if @bordered
    add(class: styles[:row][:colors][color], to: props, first_element: true) if styles[:row][:colors].key?(color) && !@striped
    props[:as] ||= :tr
    remove_class_from_props props

    props[:cells_html] ||= {}
    props[:cells_html][:as] ||= :td
    props[:cells_html][:scope] ||= :row
    add(class: styles[:row][:cell][:base], to: props[:cells_html])
    remove_class_from_props props[:cells_html]

    Fluxbit::TableGroupComponent.new(*args, **props, &block)
  }

  ##
  # Initializes the table component with the given properties.
  #
  # @param [Hash] props The properties to customize the table.
  # @option props [Boolean] :striped (false) Determines if the table rows should be striped.
  # @option props [Boolean] :bordered (false) Determines if the table should have borders.
  # @option props [Boolean] :hover (false) Determines if the table rows should highlight on hover.
  # @option props [Boolean] :shadow (false) Determines if the table should have a shadow effect.
  # @option props [Hash] :thead_html Additional HTML attributes for the table header.
  # @option props [Hash] :tbody_html Additional HTML attributes for the table body.
  # @option props [Hash] :tr_html Additional HTML attributes for the table rows.
  # @option props [Hash] :cells_html Additional HTML attributes for the table cells.
  #
  # @example
  #   = render Fluxbit::TableComponent.new(
  #     striped: true,
  #     bordered: true,
  #     hover: true,
  #     shadow: true,
  #     thead_html: { class: "my-custom-thead" },
  #     tbody_html: { class: "my-custom-tbody" },
  #     tr_html: { class: "my-custom-tr" }
  #   ) do |table|
  #     table.with_header do |header|
  #       header.with_column "Column 1"
  #       header.with_column "Column 2"
  #     end
  #
  #     table.with_row do |row|
  #       row.with_cell "Data 1"
  #       row.with_cell "Data 2"
  #     end
  #   end
  #
  # @return [Fluxbit::TableComponent]
  #
  def initialize(**props)
    super
    @props = props
    @striped = options @props.delete(:striped), default: @@striped
    @bordered = options @props.delete(:bordered), default: @@bordered
    @hover = options @props.delete(:hover), default: @@hover
    @shadow = options @props.delete(:shadow), default: @@shadow
    @only_rows = options @props.delete(:only_rows), default: false

    # Wrapper HTML
    @wrapper_html = @props.delete(:wrapper_html) || {}
    add(class: styles[:wrapper][:base], to: @wrapper_html)
    add(class: styles[:wrapper][:shadow], to: @wrapper_html) if @shadow

    # Head HTML
    @thead_html = @props.delete(:thead_html) || {}
    # add(class: styles[:head][:base], to: @thead_html)

    # Body HTML
    @tbody_html = @props.delete(:tbody_html) || {}
    add(class: styles[:body][:base], to: @tbody_html)

    # Row HTML
    @tr_html = @props.delete(:tr_html) || {}
    add(class: styles[:body][:base], to: @tbody_html)

    # Footer HTML
    @tfoot_html = @props.delete(:tfoot_html) || {}
    add(class: styles[:footer][:base], to: @tfoot_html)

    # Table HTML
    add(class: styles[:root][:base], to: @props)
  end

  def call
    return safe_join(rows) if @only_rows && rows?

    # Wrapper
    capture do
      # Table
      concat(content_tag(:div, **@wrapper_html) do
        concat(content_tag(:table, **@props) do
          # header
          concat(
            content_tag(:thead, **@thead_html) do
              concat(safe_join headers)
            end
          ) if headers?

          # body
          concat(
            content_tag(:tbody, **@tbody_html) do
              if content.present?
                content
              else
                concat(safe_join rows) if rows?
              end
            end
          )

          # Footer
          concat(
            content_tag(:tfoot, **@tfoot_html) do
              concat(footer)
            end
          ) if footer?
        end)
      end)
    end
  end
end
