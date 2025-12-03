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

  def test_renders_gravatar_with_initials_default
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", default: :initials))

    assert_selector "img[src*='d=initials']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_color_default
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", default: :color))

    assert_selector "img[src*='d=color']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_name_parameter
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", name: "John Doe"))

    assert_selector "img[src*='name=John Doe']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_without_name_parameter
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com"))

    assert_no_selector "img[src*='name=']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_initials_and_name
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", default: :initials, name: "Jane Smith"))

    assert_selector "img[src*='d=initials']"
    assert_selector "img[src*='name=Jane Smith']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_initials_parameter
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", initials: "AB"))

    assert_selector "img[src*='initials=AB']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_without_initials_parameter
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com"))

    assert_no_selector "img[src*='initials=']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end

  def test_renders_gravatar_with_initials_default_and_initials_parameter
    render_inline(Fluxbit::GravatarComponent.new(email: "user@example.com", default: :initials, initials: "XY"))

    assert_selector "img[src*='d=initials']"
    assert_selector "img[src*='initials=XY']"
    assert_selector "img[src*='gravatar.com/avatar']"
  end
end
