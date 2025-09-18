---
label: Drawer
title: Fluxbit::DrawerComponent or fx_drawer
---

The `Fluxbit::DrawerComponent` is a customizable drawer component that extends `Fluxbit::Component`.
It allows you to create slide-out panels with various placements, sizes, and interactive behaviors. The drawer supports Stimulus integration for enhanced JavaScript interactions, swipeable functionality, and backdrop control for creating modal-like experiences.

To start using the drawer you can use the default way to call the component:

```html
&lt;%= render Fluxbit::DrawerComponent.new(placement: :left, sizing: :md) do |drawer| %&gt;
  &lt;% drawer.with_header do %&gt;
    Header Content
  &lt;% end %&gt;
  Drawer content goes here
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_drawer(placement: :left, sizing: :md) do |drawer| %&gt;
  &lt;% drawer.with_header do %&gt;
    Header Content
  &lt;% end %&gt;
  Drawer content goes here
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default | Description
|:-------------------|:--------|:------------
| placement:         | :left   | Position of the drawer (`:left`, `:right`, `:top`, `:bottom`)
| sizing:            | :sm     | Size of the drawer (`:sm`, `:md`, `:lg`, `:xl`, `:full`)
| show_close_button: | true    | Whether to show a close button in the drawer
| swipeable:         | false   | Enable swipe-to-open functionality (forces `:bottom` placement)
| shadow:            | true    | Apply shadow effect to the drawer
| backdrop:          | true    | Show backdrop behind the drawer
| auto_show:         | false   | Automatically show drawer when component loads
| body_scrolling:    | false   | Allow body scrolling when drawer is open
| edge_offset:       | nil     | Offset from edge for swipeable drawers (pixels)
| backdrop_classes:  | nil     | Custom CSS classes for the backdrop element
| remove_class:      | ""      | Classes to be removed from the default class list
| **props            |         | Additional HTML attributes

## Slots

The component supports the following slots:

- `with_header`: Add header content to the drawer with optional icon and title styling.

## Examples

### Default drawer

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Using with Stimulus controller

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="use_with_stimulus" panels="source"></lookbook-embed>

### Alternative Stimulus usage

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="use_with_stimulus_second_way" panels="source"></lookbook-embed>

### Right drawer

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="right_drawer" panels="source"></lookbook-embed>

### Top drawer

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="top_drawer" panels="source"></lookbook-embed>

### Bottom drawer

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="bottom_drawer" panels="source"></lookbook-embed>

### Swipeable drawer

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="swipeable_drawer" panels="source"></lookbook-embed>

### Body scrolling enabled

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="body_scrolling_enabled" panels="source"></lookbook-embed>

### Backdrop disabled

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="backdrop_disabled" panels="source"></lookbook-embed>

### Right drawer with Stimulus

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="right_drawer_with_stimulus" panels="source"></lookbook-embed>

### Swipeable drawer with Stimulus

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="swipeable_drawer_with_stimulus" panels="source"></lookbook-embed>

### Body scrolling enabled with Stimulus

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="body_scrolling_enabled_with_stimulus" panels="source"></lookbook-embed>

### Backdrop disabled with Stimulus

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="backdrop_disabled_with_stimulus" panels="source"></lookbook-embed>

### Auto show

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DrawerComponentPreview" scenario="auto_show" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_drawer_component_defaults.rb

Fluxbit::Config::DrawerComponent.placement = :right # the default is :left
Fluxbit::Config::DrawerComponent.sizing = :lg # the default is :sm
Fluxbit::Config::DrawerComponent.show_close_button = false # the default is true
Fluxbit::Config::DrawerComponent.swipeable = true # the default is false
Fluxbit::Config::DrawerComponent.shadow = false # the default is true
Fluxbit::Config::DrawerComponent.backdrop = false # the default is true
Fluxbit::Config::DrawerComponent.auto_show = true # the default is false
Fluxbit::Config::DrawerComponent.body_scrolling = true # the default is false
Fluxbit::Config::DrawerComponent.styles[:sizes][:horizontal][:xxl] = 'w-160' # add custom size
```

## Dependencies

- [**Stimulus**](https://stimulus.hotwired.dev/): Used for JavaScript behavior and interactions.
- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons in drawer headers.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::DrawerComponent.styles)) %>
```

## References

[Flowbite Drawer](https://flowbite.com/docs/components/drawer/)