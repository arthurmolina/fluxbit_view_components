# frozen_string_literal: true

class Fluxbit::Components::TooltipComponentPreview < ViewComponent::Preview
  # Fluxbit::TooltipComponent
  # ------------------------
  # You can use this component to display contextual information in tooltips
  #
  # @param has_arrow [Boolean] toggle "Show Arrow"
  def playground(has_arrow: true)
    render Fluxbit::TooltipComponent.new(
      has_arrow: has_arrow,
      id: "tooltip-default"
    ).with_content("This is a tooltip")
  end

  def default; end
  def basic_tooltip; end
  def without_arrow; end
  def with_html_content; end
  def positioning; end
  def interactive_tooltip; end
  def adding_removing_classes; end
  def adding_other_properties; end
end
