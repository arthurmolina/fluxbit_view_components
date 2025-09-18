# frozen_string_literal: true

class Fluxbit::Components::AvatarGroupComponentPreview < ViewComponent::Preview
  # @param avatar_count [Integer] number { min: 2, max: 8, step: 1 }
  # @param size select "Avatar Size" :size_options
  # @param show_status [Boolean]
  def default(avatar_count: 3, size: :md, show_status: false)
    render Fluxbit::AvatarGroupComponent.new do |group|
      avatar_count.times do |i|
        initials = [ "AM", "FX", "BG", "JS", "RB", "PY", "GO", "TS" ][i] || "#{i+1}"
        group.with_avatar(
          placeholder_initials: initials,
          size: size,
          status: show_status ? [ :online, :busy, :offline, :away ].sample : false
        )
      end
    end
  end

  # Interactive playground for testing different configurations
  # @param playground_count [Integer] number { min: 2, max: 6, step: 1 }
  # @param playground_size select "Size" :size_options
  # @param playground_color select "Color" :color_options
  def playground(playground_count: 3, playground_size: :md, playground_color: nil)
    render Fluxbit::AvatarGroupComponent.new do |group|
      playground_count.times do |i|
        initials = [ "AM", "FX", "BG", "JS", "RB", "PY" ][i] || "#{i+1}"
        group.with_avatar(
          color: playground_color,
          placeholder_initials: initials,
          size: playground_size
        )
      end
    end
  end

  def basic_group; end
  def colored_group; end
  def sized_group; end
  def image_group; end
  def gravatar_group; end
  def mixed_group; end
  def status_group; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def size_options
    [ :xs, :sm, :md, :lg, :xl ]
  end

  def color_options
    [ nil, :dark, :danger, :gray, :info, :light, :purple, :success, :warning, :pink ]
  end
end
