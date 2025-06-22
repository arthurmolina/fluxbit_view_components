# frozen_string_literal: true

class Fluxbit::Form::FormBuilderComponent < Fluxbit::Component
  TEXT_TYPES = %w[text email password number search time date datetime-local].freeze
  INPUT_TYPES = %w[upload upload_image toggle textarea spacer select select_free range radio checkbox].freeze

  cattr_accessor :styles
  self.styles = %i[
    grid-cols-1
    grid-cols-2
    grid-cols-3
    grid-cols-4
    gap-1
    gap-2
    gap-3
    gap-4
    col-span-1
    col-span-2
    col-span-3
    col-span-4
  ]

  renders_many :elements,
               lambda { |**props, &block|
                 choose_element(props.merge({ form: @form }), block)
               }

  def initialize(form: nil, gap: 4, grid_cols: 2, show_errors: true, elements: [], **props)
    super
    @form = form
    @object = form&.object
    @elements = elements
    @props = props
    @gap = gap
    @grid_cols = grid_cols
    @show_errors = show_errors
    add(class: grid_styles, to: @props) unless grid_styles && grid_styles.empty?
  end

  def grid_styles
    return "grid gap-#{@gap} grid-cols-#{@grid_cols}" if @grid_cols.class != Hash

    "grid gap-#{@gap} " + @grid_cols.map do |size, col|
      "#{size == :default ? '' : "#{size}:"}grid-cols-#{col}"
    end.join(" ")
  end

  def colspan(colspan_element)
    return "" if colspan_element.nil?
    return "col-span-#{colspan_element}" if colspan_element.class != Hash

    colspan_element.map { |size, col| "#{size == :default ? '' : "#{size}:"}col-span-#{col}" }.join(" ")
  end

  def errors?
    return "" if !@show_errors || @object.nil? || @object.errors&.none?

    content_tag :div, class: "col-span-4" do
      Fluxbit::AlertComponent.new(type: :danger).with_content(
        I18n.t(
          "form_error",
          scope: [ :activerecord, :messages, @object.class.name.underscore.to_sym ],
          count: @object.errors.count,
          default: "#{pluralize(@object.errors.count, 'error')}."
        )
      ).render_in(view_context)
    end
  end

  def choose_element(kwargs, block = nil)
    colspan_element = kwargs.key?(:colspan) ? kwargs.delete(:colspan) : nil
    outer_div = kwargs.key?(:outer_div) ? kwargs.delete(:outer_div) : ""
    outer_div += colspan(colspan_element)
    return content_tag(:div, block.call, class: outer_div) if kwargs[:type] == :html

    kwargs[:show_errors] = false if kwargs[:type] == :group
    component_klass = "Fluxbit::#{if (TEXT_TYPES + INPUT_TYPES + [ 'label', 'group', '' ]).include?(kwargs[:type].to_s)
                                    'Form::'
                                  else
                                    ''
                                  end}#{element_type(kwargs[:type])}Component".constantize

    unless kwargs[:with_content]
      return content_tag(:div, render(component_klass.new(**kwargs), &block), class: outer_div)
    end

    content = kwargs.delete(:with_content)
    content_tag :div, render(component_klass.new(**kwargs).with_content(content), &block), class: outer_div
  end

  def element_type(type)
    return "TextField" if type.nil? || type.to_s.in?(TEXT_TYPES)
    return type.to_s.concat("_input").camelcase if type.to_s.in?(INPUT_TYPES)

    case type
    when :submit
      "Button"
    when :group
      "FormBuilder"
    else
      type.to_s.camelcase
    end
  end

  def generate_elements
    return elements if elements?

    safe_join(@elements.map { |element| choose_element(element.merge({ form: @form }), nil) })
  end

  def call
    elements_rendered = elements? ? elements : safe_join(@elements.map { |element| choose_element(element.merge({ form: @form }), nil) })
    safe_join [ errors?, content_tag(:div, elements_rendered, @props) ]
  end
end
