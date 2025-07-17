# frozen_string_literal: true

class Fluxbit::Components::DrawerComponentPreview < ViewComponent::Preview
  # Fluxbit::DrawerComponent
  # ------------------------
  # You can use this component to preview the Fluxbit DrawerComponent with various styles and configurations.
  def default; end
  def use_with_stimulus; end
  def use_with_stimulus_second_way; end
  def right_drawer; end
  def top_drawer; end
  def bottom_drawer; end

  def swipeable_drawer; end
  def body_scrolling_enabled; end
  def backdrop_disabled; end

  def right_drawer_with_stimulus; end
  def swipeable_drawer_with_stimulus; end
  def body_scrolling_enabled_with_stimulus; end
  def backdrop_disabled_with_stimulus; end
  def auto_show; end
end
