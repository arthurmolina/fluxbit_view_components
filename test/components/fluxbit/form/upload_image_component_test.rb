require "test_helper"

class Fluxbit::Form::UploadImageComponentTest < ViewComponent::TestCase
  def test_renders_with_label
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, label: "Profile Photo"))
    assert_text "Profile Photo"
    assert_selector "input[type='file']"
  end

  def test_renders_with_custom_title_and_subtitle
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :pic, title: "Envie uma imagem"))
    assert_text "Envie uma imagem"
  end

  def test_renders_default_title_and_subtitle
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :pic))
    assert_text "Change"
  end

  def test_renders_with_image_path
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :logo, image_path: "/uploads/logo.png"))
    assert_selector "img.img_photo", visible: false
    assert_includes rendered_content, "/uploads/logo.png"
  end

  def test_renders_with_image_placeholder
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :icon, image_placeholder: "/images/placeholder.png"))
    assert_selector "img.img_photo", visible: false
    assert_includes rendered_content, "/images/placeholder.png"
  end

  def test_renders_mobile_and_desktop_inputs
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :photo))
    assert_selector "input[type='file'][id^='mobile-']", count: 1
    assert_selector "input[type='file'][id^='desktop-']", count: 1
  end

  def test_renders_with_help_text
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :pic, help_text: "Max 5MB"))
    assert_text "Max 5MB"
  end

  def test_renders_with_custom_height
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :photo, height: :lg))
    assert_selector "div.w-40"
  end

  def test_renders_with_custom_id
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :pic, id: "custom-id"))
    assert_selector "div#custom-id"
  end

  def test_adds_js_function_for_preview
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :photo))
    assert_includes rendered_content, "function loadFile"
  end
end
