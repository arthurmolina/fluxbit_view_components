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

  def test_renders_rounded_by_default
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :avatar))
    assert_includes rendered_content, "rounded-full"
  end

  def test_renders_with_rounded_true
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, rounded: true))
    assert_includes rendered_content, "rounded-full"
  end

  def test_renders_with_rounded_false
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, rounded: false))
    assert_includes rendered_content, "rounded-lg"
    assert_no_selector ".rounded-full"
  end

  def test_renders_with_initials
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, initials: "JD"))
    assert_selector "div[data-initials-placeholder]", count: 2 # mobile and desktop
    assert_text "JD"
    assert_includes rendered_content, "bg-gradient-to-br"
  end

  def test_renders_with_initials_uppercase
    render_inline(Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, initials: "ab"))
    assert_text "AB" # Should be uppercased
  end

  def test_initials_override_image_placeholder
    render_inline(Fluxbit::Form::UploadImageComponent.new(
      attribute: :avatar,
      initials: "XY",
      image_placeholder: "/placeholder.png"
    ))
    assert_selector "div[data-initials-placeholder]", count: 2
    assert_text "XY"
    assert_no_selector "img[src='/placeholder.png']"
  end

  def test_renders_without_initials_uses_image
    render_inline(Fluxbit::Form::UploadImageComponent.new(
      attribute: :avatar,
      image_placeholder: "/placeholder.png"
    ))
    assert_selector "img.img_photo", visible: false
    assert_includes rendered_content, "/placeholder.png"
    assert_no_selector "div[data-initials-placeholder]"
  end

  def test_initials_gradient_is_consistent
    component1 = Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, initials: "JD")
    component2 = Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, initials: "JD")

    gradient1 = component1.send(:initials_gradient_class)
    gradient2 = component2.send(:initials_gradient_class)

    assert_equal gradient1, gradient2, "Same initials should produce same gradient"
  end

  def test_initials_text_size_varies_by_length
    component_short = Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, initials: "JD")
    component_medium = Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, initials: "ABC")
    component_long = Fluxbit::Form::UploadImageComponent.new(attribute: :avatar, initials: "ABCD")

    assert_equal "text-4xl", component_short.send(:initials_text_size_class)
    assert_equal "text-3xl", component_medium.send(:initials_text_size_class)
    assert_equal "text-2xl", component_long.send(:initials_text_size_class)
  end
end
