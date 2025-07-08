require "test_helper"

class Fluxbit::TableComponentTest < ViewComponent::TestCase
  def test_renders_basic_table_with_header_and_rows
    render_inline Fluxbit::TableComponent.new do |table|
      table.with_caption { "Table Title" }

      table.with_header do |header|
        header.with_cell { "Header 1" }
        header.with_cell { "Header 2" }
      end

      table.with_row do |row|
        row.with_cell { "Cell 1" }
        row.with_cell { "Cell 2" }
      end
    end

    assert_selector "caption", text: "Table Title"
    assert_selector "thead"
    assert_selector "th", text: "Header 1"
    assert_selector "th", text: "Header 2"
    assert_selector "tbody"
    assert_selector "td", text: "Cell 1"
    assert_selector "td", text: "Cell 2"
  end

  def test_renders_footer_and_footer_caption
    render_inline Fluxbit::TableComponent.new do |table|
      table.with_footer { |footer| footer.with_cell { "Footer Cell" } }
      table.with_footer_caption { "Footer Caption" }
    end

    assert_selector "tfoot"
    assert_selector "td", text: "Footer Cell"
    assert_selector "div", text: "Footer Caption"
  end

  def test_applies_striped_rows
    render_inline Fluxbit::TableComponent.new(striped: true) do |table|
      table.with_row do |row|
        row.with_cell { "Row 1" }
      end
    end
    # Check for odd/even classes on rows
    assert_includes rendered_content, "odd:bg"
    assert_includes rendered_content, "even:bg"
  end

  def test_applies_hover
    render_inline Fluxbit::TableComponent.new(hover: true) do |table|
      table.with_row do |row|
        row.with_cell { "Hoverable Row" }
      end
    end
    assert_includes rendered_content, "hover:bg"
  end

  def test_applies_bordered
    render_inline Fluxbit::TableComponent.new(bordered: true) do |table|
      table.with_row do |row|
        row.with_cell { "Bordered Row" }
      end
    end
    assert_includes rendered_content, "border-b"
  end

  def test_applies_shadow
    render_inline Fluxbit::TableComponent.new(shadow: true) do |table|
      table.with_row do |row|
        row.with_cell { "Shadow Row" }
      end
    end
    assert_includes rendered_content, "shadow"
  end

  def test_supports_custom_classes_and_ids
    render_inline Fluxbit::TableComponent.new(class: "custom-table", id: "my-table") do |table|
      table.with_header { |h| h.with_cell { "H" } }
      table.with_row    { |r| r.with_cell { "R" } }
    end

    assert_selector "table.custom-table#my-table"
  end

  def test_supports_custom_wrapper_and_section_html
    render_inline(
      Fluxbit::TableComponent.new(
        wrapper_html: { class: "wrapper-x" },
        thead_html: { class: "thead-x" },
        tbody_html: { class: "tbody-x" },
        tfoot_html: { class: "tfoot-x" }
      )
    ) do |table|
      table.with_header { |h| h.with_cell { "H" } }
      table.with_row    { |r| r.with_cell { "R" } }
      table.with_footer  { |f| f.with_cell { "F" } }
    end

    assert_selector ".wrapper-x"
    assert_selector "thead.thead-x"
    assert_selector "tbody.tbody-x"
    assert_selector "tfoot.tfoot-x"
  end

  def test_renders_multiple_rows_and_headers
    render_inline Fluxbit::TableComponent.new do |table|
      table.with_header do |header|
        header.with_cell { "A" }
        header.with_cell { "B" }
      end

      table.with_row do |row|
        row.with_cell { "1" }
        row.with_cell { "2" }
      end
      table.with_row do |row|
        row.with_cell { "3" }
        row.with_cell { "4" }
      end
    end

    assert_selector "th", text: "A"
    assert_selector "td", text: "1"
    assert_selector "td", text: "3"
    assert_selector "td", text: "4"
  end

  def test_selected_cell_gets_special_class
    render_inline Fluxbit::TableComponent.new do |table|
      table.with_header do |header|
        header.with_cell { "ID" }
        header.with_cell { "Name" }
      end
      table.with_row do |row|
        row.with_cell(selected: true) { "1" }
        row.with_cell { "Alpha" }
      end
    end

    assert_selector "td.font-medium.text-gray-900.whitespace-nowrap"
  end
end
