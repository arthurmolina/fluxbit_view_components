# frozen_string_literal: true

# The `Fluxbit::ModalComponent` is a component for rendering customizable modals.
# It extends `Fluxbit::Component` and provides options for configuring the modal's
# appearance, behavior, and content areas. You can control the modal's title, size,
# placement, backdrop behavior, and other interactive elements. The modal is divided
# into different sections (header, content, and footer), each of which can be
# styled or customized through various properties.
class Fluxbit::ModalComponent < Fluxbit::Component
  include Fluxbit::Config::ModalComponent
  renders_one :title
  renders_one :footer

  # Initializes the modal component with the given properties.
  #
  # @param [Hash] props The properties to customize the modal.
  # @option props [String] :title (nil) The title text displayed in the modal header.
  # @option props [Boolean] :opened (false) Determines if the modal is initially open (visible).
  # @option props [Boolean] :close_button (true) Determines if a close button should be displayed in the header.
  # @option props [Boolean] :flat (false) Applies a "flat" style (implementation-defined).
  # @option props [Symbol, Integer] :size (1) The size of the modal (e.g., 0 to 9).
  # @option props [Symbol, String] :placement (nil) The placement of the modal (e.g., :center, :top, :bottom).
  # @option props [Boolean] :only_css (false) Determines if the modal can be closed by clicking the backdrop, using a CSS-based approach.
  # @option props [Boolean] :static (false) If true, the modal will not close when clicking the backdrop or pressing the ESC key.
  # @option props [String] :remove_class ('') Classes to be removed from the default modal class list.
  # @option props [Hash] :content_html ({}) Additional HTML attributes and classes for the content wrapper inside the modal.
  # @option props [Hash] :header_html ({}) Additional HTML attributes and classes for the header section.
  # @option props [Hash] :footer_html ({}) Additional HTML attributes and classes for the footer section.
  # @option props [Hash] :close_button_html ({}) Additional HTML attributes and classes for the close button element.
  # @option props [Hash] **props Remaining options declared as HTML attributes, applied to the modal container.
  def initialize(**props)
    super

    # Main properties
    @props = props
    @title = @props.delete(:title)
    @opened = options(@props.delete(:opened), default: @@opened)
    @close_button = options(@props.delete(:close_button), default: @@close_button)
    @flat = options(@props.delete(:flat), default: @@flat)
    @size = options(@props.delete(:size), default: @@size)
    @placement = options(@props.delete(:placement), default: @@placement)
    @only_css = options(@props.delete(:only_css), default: @@only_css)
    @static = options(@props.delete(:static), default: @@static)

    add(class: modal_classes, to: @props, first_element: true)
    @props["data-modal-placement"] = @placement.to_s if @placement
    @props["aria-hidden"] = !@opened
    @props["data-modal-backdrop"] = "static" if @static
    @props["onclick"] = "if(event.target === this) this.classList.add('hidden')" if @only_css && !@static
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])

    # Content properties
    @content_html = @props.delete(:content_html) || {}
    add(class: content_classes, to: @content_html, first_element: true)
    @content_html[:class] = remove_class(@content_html.delete(:remove_class) || "", @content_html[:class])

    # Header properties
    @header_html = @props.delete(:header_html) || {}
    add(class: header_classes, to: @header_html, first_element: true)
    @header_html[:class] = remove_class(@header_html.delete(:remove_class) || "", @header_html[:class])

    # Footer properties
    @footer_html = @props.delete(:footer_html) || {}
    add(class: footer_classes, to: @footer_html, first_element: true)
    @footer_html[:class] = remove_class(@footer_html.delete(:remove_class) || "", @footer_html[:class])

    # Close button properties
    @close_button_html = @props.delete(:close_button_html) || {}
    add(class: styles[:header][:close][:base], to: @close_button_html, first_element: true)
    @close_button_html[:class] = remove_class(@close_button_html.delete(:remove_class) || "", @close_button_html[:class])
    @close_button_html[:type] = "button"
    @close_button_html["data-modal-hide"] = @props[:id]
    @close_button_html["aria-label"] = "Close"
  end

  def call
    content_tag(
      :div,
      **@props
    ) do
      content_tag(:div, **@content_html) do
        content_tag(:div, class: styles[:content][:inner]) do
          concat(header) if title? || @title.present? || @close_button
          concat(content_tag(:div, content, class: body_classes))
          concat(content_tag(:div, footer, **@footer_html)) if footer?
        end
      end
    end
  end

  private

  def content_classes
    [ styles[:content][:base], styles[:root][:size][@size] ].join(" ")
  end

  def modal_classes
    [
      styles[:root][:base],
      styles[:root][:show][@opened ? :on : :off],
      (@only_css ? styles[:root][:backdrop] : ""),
      (@only_css ? styles[:root][:placements][@placement || :center] : "")
    ].join(" ")
  end

  def body_classes
    [
      styles[:body][:base],
      (@flat ? styles[:body][:flat] : nil),
      (@close_button && !title? && !@title.present? ? styles[:body][:no_title] : "")
    ].compact.join(" ")
  end

  def header
    return close_button if @close_button && !title? && !@title.present?

    content_tag(:div, **@header_html) do
      concat(title) if title?
      concat(content_tag(:h3, @title, class: styles[:header][:title])) if @title.present?
      concat(close_button) if @close_button
    end
  end

  def header_classes
    [ styles[:header][:base], (@flat ? styles[:header][:flat] : nil) ].compact.join(" ")
  end

  def close_button
    content_tag(
      :button,
      **@close_button_html
    ) do
      concat content_tag(:span, "Dismiss", class: "sr-only")
      concat anyicon("heroicons_outline:x-mark", class: "size-5")
    end
  end

  def footer_classes
    [ styles[:footer][:base], (@flat ? styles[:footer][:flat] : nil) ].compact.join(" ")
  end
end
