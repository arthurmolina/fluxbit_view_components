---
label: Card
title: Fluxbit::CardComponent or fx_card
---

The `Fluxbit::CardComponent` is a customizable card component that extends `Fluxbit::Component`.
It allows you to create cards with various styles, colors, images, and supports additional features like headers, footers, sections, popovers and tooltips.

To start using the card you can use the default way to call the component:

```html
&lt;%= render Fluxbit::CardComponent.new do |card| %&gt;
  &lt;% card.with_header do %&gt;
    &lt;h5&gt;Card Title&lt;/h5&gt;
  &lt;% end %&gt;
  &lt;% card.with_section do %&gt;
    &lt;p&gt;Card content goes here.&lt;/p&gt;
  &lt;% end %&gt;
  &lt;% card.with_footer do %&gt;
    &lt;small&gt;Footer text&lt;/small&gt;
  &lt;% end %&gt;
&lt;% end %&gt;

&lt;!-- or with simple content --&gt;

&lt;%= render Fluxbit::CardComponent.new.with_content('Simple card content') %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_card do |card| %&gt;
  &lt;% card.with_header do %&gt;
    &lt;h5&gt;Card Title&lt;/h5&gt;
  &lt;% end %&gt;
  &lt;% card.with_section do %&gt;
    &lt;p&gt;Card content goes here.&lt;/p&gt;
  &lt;% end %&gt;
  &lt;% card.with_footer do %&gt;
    &lt;small&gt;Footer text&lt;/small&gt;
  &lt;% end %&gt;
&lt;% end %&gt;

&lt;!-- or with simple content --&gt;

&lt;%= fx_card(with_content: 'Simple card content') %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| color:             | :default | Sets the color scheme of the card (:default, :primary, :success, :danger).
| shadow:            | true     | Whether to apply a drop shadow to the card.
| border:            | true     | Whether to display a border around the card.
| rounded:           | true     | Whether the card has rounded corners.
| hoverable:         | false    | Whether to apply a hover effect that enhances the shadow.
| image:             | nil      | URL or path of an image to display on the card.
| image_position:    | :top     | Position of the image (:top or :left).
| image_html:        | {}       | Additional HTML attributes for the image element.
| href:              | nil      | If provided, makes the entire card clickable as a link.
| tooltip_text:      | nil      | Text for a tooltip (optional).
| tooltip_placement: | "top"    | Placement of the tooltip (e.g., "top", "right", "bottom", "left").
| tooltip_trigger:   | "hover"  | Trigger event for the tooltip ("hover" or "click").
| popover_text:      | nil      | Text for a popover (optional).
| popover_placement: | "top"    | Placement of the popover (e.g., "top", "right", "bottom", "left").
| popover_trigger:   | "click"  | Trigger event for the popover ("hover" or "click").
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

## Slots

The component supports the following slots:

- `with_header`: Add header content with markup (typically used for titles).
- `with_footer`: Add footer content with markup (typically used for metadata or actions).
- `with_section`: Add body sections with markup. Multiple sections can be added and each will be wrapped with proper styling.
- `with_popover`: Add popover title and content with markup.
- `with_tooltip`: Add tooltip content with markup.

## Examples

### Basic cards

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="basic_cards" panels="source"></lookbook-embed>

### Cards with colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="colored_cards" panels="source"></lookbook-embed>

### Cards with images

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="cards_with_images" panels="source"></lookbook-embed>

### Horizontal cards

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="horizontal_cards" panels="source"></lookbook-embed>

### Clickable cards

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="clickable_cards" panels="source"></lookbook-embed>

### Hoverable cards

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="hoverable_cards" panels="source"></lookbook-embed>

### Cards without border or shadow

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="minimal_cards" panels="source"></lookbook-embed>

### Cards with sections

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="cards_with_sections" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::CardComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_card_component_defaults.rb

Fluxbit::CardComponent.styles[:base] = "custom-card-base" # the default is ""
Fluxbit::CardComponent.styles[:border] = "border-2 border-blue-300" # the default is "border border-gray-200 dark:border-gray-700"
Fluxbit::CardComponent.styles[:shadow] = "shadow-xl" # the default is "shadow-sm"
Fluxbit::CardComponent.styles[:colors][:primary] = "bg-purple-50 text-purple-900 border-purple-200 dark:bg-purple-900 dark:text-white dark:border-purple-800"
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::CardComponent.styles)) %>
```

## References

[Flowbite Cards](https://flowbite.com/docs/components/card/)