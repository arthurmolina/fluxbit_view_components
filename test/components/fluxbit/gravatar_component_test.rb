# frozen_string_literal: true

require "test_helper"

class Fluxbit::GravatarComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::AvatarComponent
  include Fluxbit::Config::GravatarComponent

  def test_renders_gravatar_with_default_styles
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com"))

    assert_selector styled(:base, variable: "gravatar_styles")
    assert_selector "img[src*='gravatar.com/avatar']"
    assert_selector "img[src*='d=robohash']"
    assert_selector "img[src*='s=#{gravatar_styles[:size][:md]}']"
  end

  def test_renders_gravatar_with_custom_size
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", size: :lg))

    assert_selector "img[src*='s=#{gravatar_styles[:size][:lg]}']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_custom_rating
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", rating: :pg))

    assert_selector "img[src*='r=pg']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_custom_filetype
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", filetype: :jpg))

    assert_selector "img[src*='.jpg']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_custom_default_image
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", default: :monsterid))

    assert_selector "img[src*='d=monsterid']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_secure_url
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", secure: true))

    assert_selector "img[src^='https://secure.gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_insecure_url
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", secure: false))

    assert_selector "img[src^='http://gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_removed_classes
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", remove_class: "bg-gray-200"))

    assert_no_selector "bg-gray-200"
    assert_selector "img[src*='gravatar.com/avatar']"
  end
end
