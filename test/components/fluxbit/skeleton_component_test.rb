# frozen_string_literal: true

require "test_helper"

class Fluxbit::SkeletonComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::SkeletonComponent

  def test_renders_skeleton_with_default_styles
    render_inline(Fluxbit::SkeletonComponent.new)

    assert_selector "div[role='status'][aria-label='Loading']"
    assert_selector ".animate-pulse"
    assert_selector ".w-full"
    assert_selector "span.sr-only", text: "Loading..."
  end

  def test_renders_default_text_skeleton
    render_inline(Fluxbit::SkeletonComponent.new(variant: :default))

    assert_selector ".h-2\\.5", count: 3  # Default 3 rows
    assert_selector ".w-48", count: 1     # First line
    assert_selector ".w-full", count: 2   # Middle line + container
    assert_selector ".w-32", count: 1     # Last line
  end

  def test_renders_text_skeleton_with_custom_rows
    render_inline(Fluxbit::SkeletonComponent.new(variant: :text, rows: 5))

    assert_selector ".h-2\\.5", count: 5
  end

  def test_renders_image_skeleton
    render_inline(Fluxbit::SkeletonComponent.new(variant: :image))

    assert_selector ".h-48"  # Medium size default
    assert_selector "svg"
    assert_match(/viewBox.*0 0 20 18/, rendered_content)
  end

  def test_renders_image_skeleton_with_sizes
    [:small, :medium, :large].each do |size|
      render_inline(Fluxbit::SkeletonComponent.new(variant: :image, size: size))

      case size
      when :small
        assert_selector ".h-32"
      when :medium
        assert_selector ".h-48"
      when :large
        assert_selector ".h-64"
      end
    end
  end

  def test_renders_video_skeleton
    render_inline(Fluxbit::SkeletonComponent.new(variant: :video))

    assert_selector ".h-48"  # Medium size default
    assert_selector "svg"
    # The viewBox attribute might be rendered differently by Rails
    assert_match(/viewBox.*0 0 16 20/, rendered_content)
  end

  def test_renders_avatar_skeleton_with_sizes
    [:small, :medium, :large].each do |size|
      render_inline(Fluxbit::SkeletonComponent.new(variant: :avatar, size: size))

      case size
      when :small
        assert_selector ".w-8.h-8"
      when :medium
        assert_selector ".w-10.h-10"
      when :large
        assert_selector ".w-14.h-14"
      end
    end
  end

  def test_renders_card_skeleton
    render_inline(Fluxbit::SkeletonComponent.new(variant: :card))

    assert_selector ".p-4.border"
    assert_selector ".h-4", count: 1    # Header
    assert_selector ".h-2", count: 3    # Body lines (default rows = 3)
  end

  def test_renders_widget_skeleton
    render_inline(Fluxbit::SkeletonComponent.new(variant: :widget))

    assert_selector ".p-6.bg-white.border"
    assert_selector ".h-4.mb-4", count: 1    # Title
    assert_selector ".h-2", count: 3         # Content lines (default rows = 3)
  end

  def test_renders_list_skeleton
    render_inline(Fluxbit::SkeletonComponent.new(variant: :list))

    assert_selector ".space-y-3"
    assert_selector ".flex.items-center.space-x-4", count: 3  # 3 list items (default rows = 3)
    assert_selector ".w-10.h-10.rounded-full", count: 3       # Avatars
  end

  def test_renders_testimonial_skeleton
    render_inline(Fluxbit::SkeletonComponent.new(variant: :testimonial))

    assert_selector ".p-4"
    assert_selector ".h-2", count: 4         # 3 quote lines + 1 author line (default rows = 3)
    assert_selector ".w-8.h-8.rounded-full"  # Author avatar
  end

  def test_renders_button_skeleton
    render_inline(Fluxbit::SkeletonComponent.new(variant: :button))

    assert_selector ".h-8.w-20"
  end

  def test_disables_animation_when_false
    render_inline(Fluxbit::SkeletonComponent.new(animation: false))

    assert_no_selector ".animate-pulse"
  end

  def test_enables_animation_when_true
    render_inline(Fluxbit::SkeletonComponent.new(animation: true))

    assert_selector ".animate-pulse"
  end

  def test_applies_custom_html_attributes
    render_inline(Fluxbit::SkeletonComponent.new(
      id: "my-skeleton",
      data: { controller: "skeleton" }
    ))

    assert_selector "div#my-skeleton[data-controller='skeleton']"
  end

  def test_removes_custom_classes
    render_inline(Fluxbit::SkeletonComponent.new(remove_class: "animate-pulse"))

    assert_no_selector ".animate-pulse"
  end

  def test_applies_custom_classes
    render_inline(Fluxbit::SkeletonComponent.new(class: "custom-skeleton bg-red-100"))

    assert_selector ".custom-skeleton.bg-red-100"
  end

  def test_accessibility_attributes
    render_inline(Fluxbit::SkeletonComponent.new)

    assert_selector "[role='status']"
    assert_selector "[aria-label='Loading']"
    assert_selector ".sr-only", text: "Loading..."
  end

  def test_handles_invalid_variant_gracefully
    # Should fall back to default
    render_inline(Fluxbit::SkeletonComponent.new(variant: :invalid))

    # Should render default text skeleton
    assert_selector ".h-2\\.5", count: 3
  end

  def test_handles_invalid_size_gracefully
    # Should fall back to medium
    render_inline(Fluxbit::SkeletonComponent.new(variant: :image, size: :invalid))

    assert_selector ".h-48"  # Medium size
  end

  def test_custom_lines_parameter
    render_inline(Fluxbit::SkeletonComponent.new(variant: :text, lines: 7))

    assert_selector ".h-2\\.5", count: 7
  end

  def test_lines_takes_precedence_over_rows
    render_inline(Fluxbit::SkeletonComponent.new(variant: :text, rows: 3, lines: 6))

    assert_selector ".h-2\\.5", count: 6
  end

  def test_all_variants_render_successfully
    variants = [:default, :text, :image, :video, :avatar, :card, :widget, :list, :testimonial, :button]

    variants.each do |variant|
      render_inline(Fluxbit::SkeletonComponent.new(variant: variant))

      assert_selector "[role='status']"
      assert_selector ".sr-only", text: "Loading..."
    end
  end

  def test_different_sizes_for_sizeable_variants
    sizeable_variants = [:image, :video, :avatar]
    sizes = [:small, :medium, :large]

    sizeable_variants.each do |variant|
      sizes.each do |size|
        render_inline(Fluxbit::SkeletonComponent.new(variant: variant, size: size))

        assert_selector "[role='status']"
        # Each variant should render successfully with all sizes
      end
    end
  end

  def test_rows_parameter_affects_card_variant
    render_inline(Fluxbit::SkeletonComponent.new(variant: :card, rows: 5))

    assert_selector ".h-4", count: 1    # Header
    assert_selector ".h-2", count: 5    # Body lines
  end

  def test_rows_parameter_affects_widget_variant
    render_inline(Fluxbit::SkeletonComponent.new(variant: :widget, rows: 4))

    assert_selector ".h-4.mb-4", count: 1    # Title
    assert_selector ".h-2", count: 4         # Content lines
  end

  def test_rows_parameter_affects_list_variant
    render_inline(Fluxbit::SkeletonComponent.new(variant: :list, rows: 2))

    assert_selector ".flex.items-center.space-x-4", count: 2  # 2 list items
    assert_selector ".w-10.h-10.rounded-full", count: 2       # Avatars
  end

  def test_rows_parameter_affects_testimonial_variant
    render_inline(Fluxbit::SkeletonComponent.new(variant: :testimonial, rows: 4))

    assert_selector ".h-2", count: 5         # 4 quote lines + 1 author line
    assert_selector ".w-8.h-8.rounded-full"  # Author avatar (unchanged)
  end
end