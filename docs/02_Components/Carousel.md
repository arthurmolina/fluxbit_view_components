---
label: Carousel
title: Fluxbit::CarouselComponent or fx_carousel
---

The `Fluxbit::CarouselComponent` is a customizable carousel component that extends `Fluxbit::Component`.
It allows you to create image carousels or content sliders with automatic sliding, navigation controls, indicators, and customizable animations.

To start using the carousel, you can use the default way to call the component:

```html
&lt;%= render Fluxbit::CarouselComponent.new do |carousel| %&gt;
  &lt;% carousel.with_slide do %&gt;
    &lt;%= image_tag("slide1.jpg") %&gt;
  &lt;% end %&gt;
  &lt;% carousel.with_slide do %&gt;
    &lt;%= image_tag("slide2.jpg") %&gt;
  &lt;% end %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_carousel do |carousel| %&gt;
  &lt;% carousel.with_slide do %&gt;
    &lt;%= image_tag("slide1.jpg") %&gt;
  &lt;% end %&gt;
  &lt;% carousel.with_slide do %&gt;
    &lt;%= image_tag("slide2.jpg") %&gt;
  &lt;% end %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:-----------
| slide:             | true     | Enables automatic sliding between items when set to `true`. Set to `false` for static carousel.
| slide_interval:    | 3000     | Interval in milliseconds between automatic slides (e.g., `3000` = 3 seconds).
| indicators:        | true     | When `true`, displays slide indicator dots at the bottom of the carousel.
| controls:          | true     | When `true`, shows previous/next navigation control buttons.
| left_control:      | nil      | Custom content/text for the left (previous) control button. Uses default icon if `nil`.
| right_control:     | nil      | Custom content/text for the right (next) control button. Uses default icon if `nil`.
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes applied to the carousel element.

## Slots

The component supports the following slots:

- **with_slide**: Add individual slides to the carousel. Each slide can contain images, text, or any custom HTML content.

## Examples

### Default Carousel

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Static Carousel

A carousel without automatic sliding:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="static_carousel" panels="source"></lookbook-embed>

### Carousel with Custom Interval

Change the automatic slide interval to 5 seconds (5000ms):

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="carousel_with_custom_interval" panels="source"></lookbook-embed>

### Carousel without Indicators

Hide the indicator dots:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="carousel_without_indicators" panels="source"></lookbook-embed>

### Carousel without Controls

Hide the navigation control buttons:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="carousel_without_controls" panels="source"></lookbook-embed>

### Carousel with Custom Controls

Use custom text for navigation controls:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="carousel_with_custom_controls" panels="source"></lookbook-embed>

### Carousel with Custom Content

Use custom HTML content instead of images:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="carousel_with_content" panels="source"></lookbook-embed>

### Adding/Removing Classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding Other Properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CarouselComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters or adding custom styles.
You can also set global defaults or override existing styles in an initializer. For example:

```ruby
# /config/initializers/change_carousel_component_defaults.rb

Fluxbit::Config::CarouselComponent.slide = false            # default is true
Fluxbit::Config::CarouselComponent.slide_interval = 5000    # default is 3000
Fluxbit::Config::CarouselComponent.indicators = false       # default is true
Fluxbit::Config::CarouselComponent.controls = false         # default is true
Fluxbit::Config::CarouselComponent.styles[:base] = 'relative w-screen'  # Override base styles
```

## Dependencies

- [**Flowbite**](https://flowbite.com/): JavaScript library for carousel functionality.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.

## Styles

To view the current styles configuration for the `Fluxbit::CarouselComponent`, you can inspect it as JSON:

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::CarouselComponent.styles)) %>
```

This will output a JSON representation of the default style mappings for the Carousel component.

## References

- [Flowbite Carousel](https://flowbite.com/docs/components/carousel/)
- [Flowbite React Carousel](https://flowbite-react.com/docs/components/carousel)
