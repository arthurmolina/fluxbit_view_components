# frozen_string_literal: true

require "test_helper"

class Fluxbit::AvatarComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::AvatarComponent

  def test_renders_avatar_with_image
    render_inline(Fluxbit::AvatarComponent.new(src: "https://example.com/avatar.jpg", size: :lg))

    assert_selector "img[src='https://example.com/avatar.jpg']"
    assert_selector styled(:size, :lg)
  end

  def test_renders_avatar_with_placeholder_initials
    render_inline(Fluxbit::AvatarComponent.new(placeholder_initials: "AB", size: :md))

    assert_selector "span", text: "AB"
    assert_selector styled(:size, :md)
  end

  def test_renders_avatar_with_status
    render_inline(Fluxbit::AvatarComponent.new(status: :online, size: :sm))

    assert_selector "div.relative"
    assert_selector "span#{styled(:status, :base)}"
    assert_selector styled(:status, :options, :online)
    assert_selector styled(:size, :sm)
  end

  def test_renders_avatar_with_color
    render_inline(Fluxbit::AvatarComponent.new(color: :info))

    assert_selector styled(:bordered)
    assert_selector styled(:color, :info)
  end

  def test_renders_avatar_with_default_color_when_invalid_color_is_provided
    render_inline(Fluxbit::AvatarComponent.new(color: :invalid_color))

    assert_selector styled(:bordered)
    assert_selector styled(:color, :info)
  end

  def test_renders_avatar_with_rounded_corners
    render_inline(Fluxbit::AvatarComponent.new(rounded: true))

    assert_selector styled(:rounded, :base)
  end

  def test_renders_avatar_with_square_corners
    render_inline(Fluxbit::AvatarComponent.new(rounded: false))

    assert_selector styled(:not_rounded, :base)
  end

  def test_renders_avatar_with_dot_indicator
    render_inline(Fluxbit::AvatarComponent.new(status: :busy, status_position: "top_right"))

    assert_selector "span#{styled(:status, :base)}"
    assert_selector styled(:status, :options, :busy)
    assert_selector styled(:rounded, :status_position, :top)
  end

  def test_renders_avatar_with_placeholder_icon
    render_inline(Fluxbit::AvatarComponent.new)

    assert_selector "svg"
    assert_selector "path[d='M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z']"
  end

  def test_renders_avatar_with_custom_classes
    render_inline(Fluxbit::AvatarComponent.new(class: "custom-class"))

    assert_selector ".custom-class"
  end

  def test_renders_avatar_with_removed_classes
    render_inline(Fluxbit::AvatarComponent.new(remove_class: styles[:initials][:base]))

    assert_no_selector styled(:initials, :base)
  end
end
