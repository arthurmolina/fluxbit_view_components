# frozen_string_literal: true

require "test_helper"

class Fluxbit::AccordionComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::AccordionComponent

  test "render accordion with default styles and attributes" do
    render_inline(Fluxbit::AccordionComponent.new) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    assert_selector "div#{styled(:base)}"
    assert_selector "div[data-accordion='open']"
    assert_selector "h2"
    assert_selector "button[type='button']"
    assert_selector "button[aria-expanded]"
  end

  test "render accordion with collapse_all behavior" do
    render_inline(Fluxbit::AccordionComponent.new(collapse_all: true)) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    assert_selector "div[data-accordion='collapse']"
  end

  test "render accordion with flush styling" do
    render_inline(Fluxbit::AccordionComponent.new(flush: true)) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    # Flush accordion should not have border/rounded classes
    refute_selector "div.border"
    refute_selector "div.rounded-xl"
  end

  test "render accordion panel with header and content" do
    render_inline(Fluxbit::AccordionComponent.new) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    assert_selector "button", text: "Test Header"
    assert_selector "div", text: "Test Content"
  end

  test "render accordion panel with open state" do
    render_inline(Fluxbit::AccordionComponent.new) do |c|
      c.with_panel(open: true, index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    assert_selector "button[aria-expanded='true']"
    refute_selector "div.hidden"
  end

  test "render accordion panel with closed state" do
    render_inline(Fluxbit::AccordionComponent.new) do |c|
      c.with_panel(open: false, index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    assert_selector "button[aria-expanded='false']"
    assert_selector "div.hidden"
  end

  test "render multiple accordion panels" do
    render_inline(Fluxbit::AccordionComponent.new) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "First Header" }
        panel.with_body { "First Content" }
      end
      c.with_panel(index: 1) do |panel|
        panel.with_header { "Second Header" }
        panel.with_body { "Second Content" }
      end
    end

    assert_selector "button", text: "First Header"
    assert_selector "button", text: "Second Header"
    assert_selector "div", text: "First Content"
    assert_selector "div", text: "Second Content"
  end

  test "render accordion panel with proper ARIA attributes" do
    render_inline(Fluxbit::AccordionComponent.new) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    assert_selector "button[data-accordion-target]"
    assert_selector "button[aria-controls]"
    assert_selector "div[aria-labelledby]"
  end

  test "render accordion with custom CSS classes" do
    render_inline(Fluxbit::AccordionComponent.new(class: "custom-class")) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    assert_selector "div.custom-class"
  end

  test "render accordion with custom HTML attributes" do
    render_inline(Fluxbit::AccordionComponent.new(id: "test-accordion", "data-test" => "accordion")) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    assert_selector "div#test-accordion"
    assert_selector "div[data-test='accordion']"
  end

  test "render accordion panel with chevron icon" do
    render_inline(Fluxbit::AccordionComponent.new) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "Test Header" }
        panel.with_body { "Test Content" }
      end
    end

    assert_selector "button svg"
    assert_selector "svg#{styled(:item, :icon, :base)}"
  end

  test "accordion generates unique IDs for panels" do
    render_inline(Fluxbit::AccordionComponent.new) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "First Header" }
        panel.with_body { "First Content" }
      end
      c.with_panel(index: 1) do |panel|
        panel.with_header { "Second Header" }
        panel.with_body { "Second Content" }
      end
    end

    # Should have unique header and content IDs
    accordion_id = page.find("div[data-accordion]")[:id]
    assert_selector "h2##{accordion_id}-header-0"
    assert_selector "h2##{accordion_id}-header-1"
    assert_selector "div##{accordion_id}-content-0"
    assert_selector "div##{accordion_id}-content-1"
  end

  test "render accordion with primary color scheme" do
    render_inline(Fluxbit::AccordionComponent.new(color: :primary)) do |c|
      c.with_panel(index: 0) do |panel|
        panel.with_header { "Primary Header" }
        panel.with_body { "Primary Content" }
      end
    end

    assert_selector "button", text: "Primary Header"
    # Should have blue background classes from primary color scheme
    assert_selector "button.bg-blue-50"
    assert_selector "div.bg-blue-50"
  end
end
