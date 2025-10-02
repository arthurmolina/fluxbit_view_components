class Fluxbit::Components::CarouselComponentPreview < ViewComponent::Preview
  # Fluxbit::CarouselComponent
  # ---------------------------
  # You can use this component to create an image carousel or content slider
  #
  # @param slide [Boolean] toggle "Auto Slide"
  # @param slide_interval text "Slide Interval (ms)"
  # @param indicators [Boolean] toggle "Show Indicators"
  # @param controls [Boolean] toggle "Show Controls"
  def playground(slide: true, slide_interval: 3000, indicators: true, controls: true)
    render Fluxbit::CarouselComponent.new(
      slide: slide,
      slide_interval: slide_interval.to_i,
      indicators: indicators,
      controls: controls
    ) do |carousel|
      carousel.with_slide do
        tag.img(src: "https://flowbite.com/docs/images/carousel/carousel-1.svg", class: "absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2", alt: "Slide 1")
      end
      carousel.with_slide do
        tag.img(src: "https://flowbite.com/docs/images/carousel/carousel-2.svg", class: "absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2", alt: "Slide 2")
      end
      carousel.with_slide do
        tag.img(src: "https://flowbite.com/docs/images/carousel/carousel-3.svg", class: "absolute block w-full -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2", alt: "Slide 3")
      end
    end
  end

  def default; end
  def static_carousel; end
  def carousel_with_custom_interval; end
  def carousel_without_indicators; end
  def carousel_without_controls; end
  def carousel_with_custom_controls; end
  def carousel_with_content; end
  def adding_removing_classes; end
  def adding_other_properties; end
end
