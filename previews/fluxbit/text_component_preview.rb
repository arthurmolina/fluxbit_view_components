# frozen_string_literal: true

class Fluxbit::TextComponentPreview < ViewComponent::Preview
  # Fluxbit::TextComponent
  # ------------------------
  # You can use this component to display a message to the user
  #
  # @param content text
  # @param color select "Text Color" :color_options
  # @param bg_color select "Background Text Color" :bg_color_options
  # @param size select "Size" :size_options
  # @param weight select "Weight" :weight_options
  # @param transform select "Transform" :transform_options
  # @param decoration_line select "Decoration line" :decoration_line_options
  # @param decoration_type select "Decoration type" :decoration_type_options
  # @param decoration_color select "Decoration color" :decoration_color_options
  # @param decoration_tickness select "Decoration tickness" :decoration_tickness_options
  # @param underline_offset select "Underline offset" :underline_offset_options
  def playground(
    color: nil,
    bg_color: nil,
    size: nil,
    weight: nil,
    transform: nil,
    decoration_line: nil,
    decoration_type: nil,
    decoration_color: nil,
    decoration_tickness: nil,
    underline_offset: nil,
    content: "The quick brown fox jumps over the lazy dog."
  )
    render Fluxbit::TextComponent.new(
      color: color,
      bg_color: bg_color,
      size: size,
      weight: weight,
      transform: transform,
      decoration_line: decoration_line,
      decoration_type: decoration_type,
      decoration_color: decoration_color,
      decoration_tickness: decoration_tickness,
      underline_offset: underline_offset,
    ).with_content(content)
  end

  private

  def color_options
    [ nil ] + Fluxbit::Config::TextComponent.styles[:color].keys
  end

  def bg_color_options
    [ nil ] + Fluxbit::Config::TextComponent.styles[:bg_color].keys
  end

  def size_options
    [ nil ] + Fluxbit::Config::TextComponent.styles[:size].keys
  end

  def weight_options
    [ nil ] + Fluxbit::Config::TextComponent.styles[:weight].keys
  end

  def transform_options
    [ nil ] + Fluxbit::Config::TextComponent.styles[:transform].keys
  end

  def decoration_line_options
    [ nil ] + Fluxbit::Config::TextComponent.styles[:decoration_line].keys
  end

  def decoration_type_options
    [ nil ] + Fluxbit::Config::TextComponent.styles[:decoration_type].keys
  end

  def decoration_color_options
    [ nil ] + Fluxbit::Config::TextComponent.styles[:decoration_color].keys
  end

  def decoration_tickness_options
    [ nil ] + (0..4).to_a
  end

  def underline_offset_options
    [ nil ] + (0..4).to_a
  end
end
