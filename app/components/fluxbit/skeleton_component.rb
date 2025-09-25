# frozen_string_literal: true

##
# The `Fluxbit::SkeletonComponent` is a customizable skeleton loading component that extends `Fluxbit::Component`.
# It provides animated placeholders for content that is loading, supporting various types like text, images, cards,
# avatars, and more complex layouts.
#
# @example Basic usage
#   = fx_skeleton
#   = fx_skeleton(variant: :image)
#   = fx_skeleton(variant: :card)
#
# @see docs/02_Components/Skeleton.md For detailed documentation.
class Fluxbit::SkeletonComponent < Fluxbit::Component
  include Fluxbit::Config::SkeletonComponent

  ##
  # Initializes the skeleton component with the given properties.
  #
  # @param [Hash] **props The properties to customize the skeleton.
  # @option props [Symbol] :variant (:default) The type of skeleton (:default, :text, :image, :video, :avatar, :card, :widget, :list, :testimonial, :button).
  # @option props [Boolean] :animation (true) Whether to show the pulse animation.
  # @option props [Integer] :rows (3) Number of text rows for default/text variants.
  # @option props [Symbol] :size (:medium) Size for avatar, image, and video variants (:small, :medium, :large).
  # @option props [Integer] :lines (nil) Number of lines for text-based variants.
  # @option props [String] :remove_class ('') CSS classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::SkeletonComponent]
  def initialize(**props)
    super
    @props = props

    @variant = options(@props.delete(:variant),
                       collection: [:default, :text, :image, :video, :avatar, :card, :widget, :list, :testimonial, :button],
                       default: @@variant)
    @animation = options(@props.delete(:animation), default: @@animation)
    @rows = options(@props.delete(:rows), default: @@rows).to_i
    @size = options(@props.delete(:size), collection: [:small, :medium, :large], default: :medium)
    @lines = @props.delete(:lines)&.to_i

    declare_classes
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
    @props[:role] = "status"
    @props["aria-label"] = "Loading"
  end

  def call
    tag.div(**@props) do
      case @variant
      when :default, :text
        render_text_skeleton
      when :image
        render_image_skeleton
      when :video
        render_video_skeleton
      when :avatar
        render_avatar_skeleton
      when :card
        render_card_skeleton
      when :widget
        render_widget_skeleton
      when :list
        render_list_skeleton
      when :testimonial
        render_testimonial_skeleton
      when :button
        render_button_skeleton
      end
    end
  end

  private

  def declare_classes
    base_classes = []
    base_classes << styles[:base] if @animation
    base_classes << styles[:container]

    add(class: base_classes.join(" "), to: @props, first_element: true)
  end

  def render_text_skeleton
    lines_count = @lines || @rows
    content = []

    lines_count.times do |index|
      width_class = case index
                    when 0 then "w-48"
                    when lines_count - 1 then "w-32"
                    else "w-full"
                    end

      content << tag.div(class: "#{styles[:text][:line]} #{width_class} #{styles[:spacing][:small]}")
    end

    content << tag.span("Loading...", class: "sr-only")
    safe_join(content)
  end

  def render_image_skeleton
    content = []
    content << tag.div(class: "flex items-center justify-center #{styles[:image][@size]} w-full") do
      concat(
        tag.svg(class: "w-8 h-8 text-gray-200 dark:text-gray-600",
                "aria-hidden": "true",
                xmlns: "http://www.w3.org/2000/svg",
                fill: "currentColor",
                viewBox: "0 0 20 18") do
          concat(
            tag.path(d: "M18 0H2a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2Zm-5.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3Zm4.376 10.481A1 1 0 0 1 16 15H4a1 1 0 0 1-.895-1.447l3.5-7A1 1 0 0 1 7.468 6a.965.965 0 0 1 .9.5l2.775 4.757 1.546-1.887a1 1 0 0 1 1.618.1l2.541 4a1 1 0 0 1 .028 1.011Z")
          )
        end
      )
    end
    content << tag.span("Loading...", class: "sr-only")
    safe_join(content)
  end

  def render_video_skeleton
    content = []
    content << tag.div(class: "flex items-center justify-center #{styles[:video][@size]} w-full") do
      concat(
        tag.svg(class: "w-10 h-10 text-gray-200 dark:text-gray-600",
                "aria-hidden": "true",
                xmlns: "http://www.w3.org/2000/svg",
                fill: "currentColor",
                viewBox: "0 0 16 20") do
          concat(
            tag.path(d: "M5 5V.13a2.96 2.96 0 0 0-1.293.749L.879 3.707A2.98 2.98 0 0 0 .13 5H5Z")
          )
          concat(
            tag.path(d: "M14.066 0H7v5a2 2 0 0 1-2 2H0v11a1.97 1.97 0 0 0 1.934 2h12.132A1.97 1.97 0 0 0 16 18V2a1.97 1.97 0 0 0-1.934-2ZM9 13a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-2a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2Zm4 .382a1 1 0 0 1-1.447.894L10 13v-2l1.553-1.276a1 1 0 0 1 1.447.894v2.764Z")
          )
        end
      )
    end
    content << tag.span("Loading...", class: "sr-only")
    safe_join(content)
  end

  def render_avatar_skeleton
    content = []
    content << tag.div(class: styles[:avatar][@size])
    content << tag.span("Loading...", class: "sr-only")
    safe_join(content)
  end

  def render_card_skeleton
    tag.div(class: styles[:card][:container]) do
      content = []
      content << tag.div(class: "#{styles[:card][:header]} #{styles[:spacing][:medium]} w-48")

      lines_count = @lines || @rows
      lines_count.times do |index|
        width_class = index == lines_count - 1 ? "w-32" : "w-full"
        spacing_class = index < lines_count - 1 ? styles[:spacing][:small] : ""
        content << tag.div(class: "#{styles[:card][:body]} #{spacing_class} #{width_class}")
      end

      content << tag.span("Loading...", class: "sr-only")
      safe_join(content)
    end
  end

  def render_widget_skeleton
    tag.div(class: styles[:widget][:container]) do
      content = []
      content << tag.div(class: "#{styles[:widget][:title]} w-48")

      lines_count = @lines || @rows
      lines_count.times do |index|
        width_class = index == lines_count - 1 ? "w-32" : "w-full"
        spacing_class = index < lines_count - 1 ? styles[:spacing][:small] : ""
        content << tag.div(class: "#{styles[:widget][:content]} #{spacing_class} #{width_class}")
      end

      content << tag.span("Loading...", class: "sr-only")
      safe_join(content)
    end
  end

  def render_list_skeleton
    tag.div(class: styles[:list][:container]) do
      content = []

      lines_count = @lines || @rows
      lines_count.times do
        content << tag.div(class: styles[:list][:item]) do
          concat(tag.div(class: styles[:list][:avatar]))
          concat(
            tag.div(class: styles[:list][:content]) do
              concat(tag.div(class: "#{styles[:text][:line]} w-24 #{styles[:spacing][:small]}"))
              concat(tag.div(class: "#{styles[:text][:small]} w-32"))
            end
          )
        end
      end

      content << tag.span("Loading...", class: "sr-only")
      safe_join(content)
    end
  end

  def render_testimonial_skeleton
    tag.div(class: styles[:testimonial][:container]) do
      content = []

      lines_count = @lines || @rows
      lines_count.times do |index|
        width = index == lines_count - 1 ? "w-24" : "w-full"
        spacing_class = index < lines_count - 1 ? styles[:spacing][:small] : ""
        content << tag.div(class: "#{styles[:testimonial][:quote]} #{width} #{spacing_class}")
      end

      content << tag.div(class: styles[:testimonial][:author]) do
        concat(tag.div(class: "w-8 h-8 bg-gray-200 rounded-full dark:bg-gray-700"))
        concat(
          tag.div do
            concat(tag.div(class: "#{styles[:text][:line]} w-32 #{styles[:spacing][:small]}"))
            concat(tag.div(class: "#{styles[:text][:small]} w-24"))
          end
        )
      end

      content << tag.span("Loading...", class: "sr-only")
      safe_join(content)
    end
  end

  def render_button_skeleton
    content = []
    content << tag.div(class: styles[:button])
    content << tag.span("Loading...", class: "sr-only")
    safe_join(content)
  end
end