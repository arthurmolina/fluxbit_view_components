# frozen_string_literal: true

require "test_helper"

class Fluxbit::AvatarGroupComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::AvatarComponent
  include Fluxbit::Config::GravatarComponent

  def test_renders_avatar_group_with_avatars
    render_inline(Fluxbit::AvatarGroupComponent.new) do |group|
      group.with_avatar(placeholder_initials: "AB", size: :md)
      group.with_avatar(placeholder_initials: "CD", size: :lg)
    end

    assert_selector styled(:group)
    assert_selector styled(:size, :md), text: "AB"
    assert_selector styled(:size, :lg), text: "CD"
  end

  def test_renders_avatar_group_with_gravatars
    render_inline(Fluxbit::AvatarGroupComponent.new) do |group|
      group.with_gravatar(email: "user1@example.com", size: :sm)
      group.with_gravatar(email: "user2@example.com", size: :lg)
    end

    assert_selector styled(:group)
    assert_selector styled(:size, :sm)
    assert_selector styled(:size, :lg)
  end

  def test_renders_avatar_group_with_mixed_content
    render_inline(Fluxbit::AvatarGroupComponent.new) do |group|
      group.with_avatar(placeholder_initials: "XY", size: :sm)
      group.with_gravatar(email: "user@example.com", size: :md)
    end

    assert_selector styled(:group)
    assert_selector styled(:size, :sm), text: "XY"
    assert_selector styled(:size, :md)
  end

  def test_renders_empty_avatar_group
    render_inline(Fluxbit::AvatarGroupComponent.new)

    assert_selector styled(:group)
    assert_no_selector styled(:size, :sm)
    assert_no_selector styled(:size, :md)
    assert_no_selector styled(:size, :lg)
  end
end
