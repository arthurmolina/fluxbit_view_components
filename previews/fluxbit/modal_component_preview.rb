# frozen_string_literal: true

class Fluxbit::ModalComponentPreview < ViewComponent::Preview
  # Fluxbit::ButtonComponent
  # ------------------------
  # You can use this component to display a message to the user
  #
  # @param close_button [Boolean] toggle "Close button"
  # @param flat [Boolean] toggle "flat"
  # @param size select "Size" :size_options
  # @param placement select "Placement" :placement_options
  # @param static [Boolean] toggle "Static"
  def playground(close_button: true, flat: false, size: 1, placement: :center, static: false)
    render Fluxbit::ModalComponent.new(
      title: "Title of the modal",
      opened: true,
      only_css: true,
      close_button: close_button,
      flat: flat,
      size: size.to_i,
      placement: placement,
      static: static
    ).with_content("Content of the modal")
  end

  def default_modal; end
  def with_title_and_footer; end
  def placements; end
  def sizes; end
  def flat; end
  def static; end
  def only_css; end
  def adding_removing_classes; end

  private

  def placement_options
    Fluxbit::Config::ModalComponent.styles[:root][:placements].keys
  end

  def size_options
    (0..Fluxbit::Config::ModalComponent.styles[:root][:size].count - 1).map(&:to_s)
  end
end
