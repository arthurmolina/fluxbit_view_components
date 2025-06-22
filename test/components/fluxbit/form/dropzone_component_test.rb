require "test_helper"

class Fluxbit::Form::DropzoneComponentTest < ViewComponent::TestCase
  def test_renders_default
    render_inline(Fluxbit::Form::DropzoneComponent.new(name: "avatar"))
    assert_selector ".flex.items-center.justify-center.w-full"
    assert_selector "input[type='file'][name='avatar']"
    assert_text "Click to upload"
    assert_text "SVG, PNG, JPG or GIF"
  end

  def test_renders_with_custom_title
    render_inline(Fluxbit::Form::DropzoneComponent.new(name: "doc", title: "Arraste o PDF aqui"))
    assert_text "Arraste o PDF aqui"
  end

  def test_renders_with_custom_subtitle
    render_inline(Fluxbit::Form::DropzoneComponent.new(name: "file", subtitle: "Apenas imagens PNG ou JPG"))
    assert_text "Apenas imagens PNG ou JPG"
  end

  def test_renders_with_title_and_subtitle_false
    render_inline(Fluxbit::Form::DropzoneComponent.new(name: "upload", title: false, subtitle: false))
    refute_text "Click to upload"
    refute_text "SVG, PNG, JPG or GIF"
  end

  def test_renders_with_custom_height
    render_inline(Fluxbit::Form::DropzoneComponent.new(name: "bigfile", height: 2))
    assert_selector ".h-64"
  end

  def test_renders_with_help_text
    render_inline(Fluxbit::Form::DropzoneComponent.new(name: "doc", help_text: "Max size 5MB"))
    assert_text "Max size 5MB"
  end

  def test_renders_custom_classes
    render_inline(Fluxbit::Form::DropzoneComponent.new(name: "file", class: "custom-dropzone"))
    assert_selector "input.custom-dropzone.hidden"
  end
end
