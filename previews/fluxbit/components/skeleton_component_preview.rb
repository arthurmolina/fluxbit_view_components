# frozen_string_literal: true

class Fluxbit::Components::SkeletonComponentPreview < ViewComponent::Preview
  # Fluxbit::SkeletonComponent
  # --------------------------
  # You can use this component to create loading placeholders for various content types
  #
  # @param variant select "Variant" :variant_options
  # @param animation [Boolean] toggle "Animation"
  # @param rows select "Rows" :rows_options
  # @param size select "Size" :size_options
  def playground(variant: :default, animation: true, rows: 3, size: :medium)
    render Fluxbit::SkeletonComponent.new(
      variant: variant,
      animation: animation,
      rows: rows.to_i,
      size: size
    )
  end

  def default_skeleton; end
  def text_skeleton; end
  def image_skeleton; end
  def video_skeleton; end
  def avatar_skeleton; end
  def card_skeleton; end
  def widget_skeleton; end
  def list_skeleton; end
  def testimonial_skeleton; end
  def button_skeleton; end
  def different_sizes; end
  def without_animation; end
  def custom_rows; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def variant_options
    [ :default, :text, :image, :video, :avatar, :card, :widget, :list, :testimonial, :button ]
  end

  def rows_options
    [ "1", "2", "3", "4", "5" ]
  end

  def size_options
    [ :small, :medium, :large ]
  end
end
