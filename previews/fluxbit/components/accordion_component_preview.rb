# frozen_string_literal: true

class Fluxbit::Components::AccordionComponentPreview < ViewComponent::Preview
  # @param flush [Boolean]
  # @param color select "Color" :color_options
  # @param collapse_all [Boolean]
  def default(flush: false, color: :default, collapse_all: false)
    render Fluxbit::AccordionComponent.new(
      flush: flush,
      color: color,
      collapse_all: collapse_all
    ) do |accordion|
      accordion.with_panel(open: true, index: 0) do |panel|
        panel.with_header { "Header" }
        panel.with_body do
          tag.p(class: "text-gray-500 dark:text-gray-400") { "Content 1" }
        end
      end

      accordion.with_panel(index: 1) do |panel|
        panel.with_header { "Header 2" }
        panel.with_body do
          tag.p(class: "mb-2 text-gray-500 dark:text-gray-400") { "Content 2" }
        end
      end

      accordion.with_panel(index: 2) do |panel|
        panel.with_header { "Header 3" }
        panel.with_body do
          tag.p(class: "mb-2 text-gray-500 dark:text-gray-400") { "Content 3" }
        end
      end
    end
  end

  def basic_accordion; end
  def flush_accordion; end
  def colored_accordion; end
  def always_open; end
  def collapse_all; end
  def custom_icons; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def color_options
    Fluxbit::Config::AccordionComponent.styles[:colors].keys
  end
end
