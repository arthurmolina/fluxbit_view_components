# frozen_string_literal: true

class Fluxbit::TableGroupComponent < Fluxbit::Component
  include Fluxbit::Config::TableComponent

  renders_many :cells, lambda { |*args, **props, &block|
    cells_html_now = @cells_html.dup
    add(class: props[:class], to: cells_html_now)
    cells_html_now = props.merge cells_html_now
    add(class: styles[:row][:cell][:selected], to: cells_html_now) if props.delete(:selected) || false
    remove_class_from_props(cells_html_now)

    content_tag(@as_cells, block.call, **cells_html_now)
  }

  def initialize(**props)
    super
    @props = props
    @as = @props.delete(:as) || :tr
    @cells_html = @props.delete(:cells_html) || { as: :td }

    @as_cells = @cells_html.delete(:as) || :td
  end

  def call
    content_tag(:tr, safe_join(cells), @props)
  end
end
