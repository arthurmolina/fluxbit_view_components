# frozen_string_literal: true

class Fluxbit::Components::TableComponentPreview < ViewComponent::Preview
  # Fluxbit::TableComponent
  # -----------------------
  # You can use this component to create responsive data tables with various styling options
  #
  # @param striped [Boolean] toggle "Striped Rows"
  # @param bordered [Boolean] toggle "Bordered"
  # @param hover [Boolean] toggle "Hover Effects"
  # @param shadow [Boolean] toggle "Shadow"
  def playground(striped: false, bordered: false, hover: false, shadow: false)
    render Fluxbit::TableComponent.new(
      striped: striped,
      bordered: bordered,
      hover: hover,
      shadow: shadow
    ) do |table|
      table.with_header do |header|
        header.with_cell { "Product name" }
        header.with_cell { "Color" }
        header.with_cell { "Category" }
        header.with_cell { "Price" }
      end

      table.with_row do |row|
        row.with_cell { "Apple MacBook Pro 17" }
        row.with_cell { "Silver" }
        row.with_cell { "Laptop" }
        row.with_cell { "$2999" }
      end

      table.with_row do |row|
        row.with_cell { "Microsoft Surface Pro" }
        row.with_cell { "White" }
        row.with_cell { "Laptop PC" }
        row.with_cell { "$1999" }
      end
    end
  end

  def default; end
  def basic_table; end
  def striped_rows; end
  def bordered_table; end
  def hover_effects; end
  def table_shadow; end
  def colored_rows; end
  def table_footer; end
  def selected_cells; end
  def only_rows; end
  def adding_removing_classes; end
  def adding_other_properties; end
end
