---
label: Tooltip
title: Fluxbit::TooltipComponent or fx_tooltip
---

The `Fluxbit::TooltipComponent` is a customizable tooltip component that extends `Fluxbit::Component`.
It allows you to display contextual information when users hover over or focus on elements, with support for arrow indicators and custom positioning.

To start using the tooltip you can use the default way to call the component:

```html
&lt;%= render Fluxbit::TooltipComponent.new.with_content('Tooltip content') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::TooltipComponent.new do %&gt;
    Tooltip content
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_tooltip(with_content: 'Tooltip content') %&gt;

&lt;!-- or --&gt;

&lt;%= fx_tooltip do %&gt;
    Tooltip content
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TooltipComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| has_arrow:         | true     | Determines if an arrow should be displayed on the tooltip.
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

## Slots

This component does not define any named slots. The content for the tooltip is provided through the default block:

```html
&lt;%= render Fluxbit::TooltipComponent.new do %&gt;
  This is the tooltip content
&lt;% end %&gt;
```

## Examples

### Basic tooltip

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TooltipComponentPreview" scenario="basic_tooltip" panels="source"></lookbook-embed>

### Tooltip without arrow

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TooltipComponentPreview" scenario="without_arrow" panels="source"></lookbook-embed>

### Tooltip with HTML content

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TooltipComponentPreview" scenario="with_html_content" panels="source"></lookbook-embed>

### Tooltip positioning

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TooltipComponentPreview" scenario="positioning" panels="source"></lookbook-embed>

### Interactive tooltip with buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TooltipComponentPreview" scenario="interactive_tooltip" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TooltipComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TooltipComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_tooltip_component_defaults.rb

Fluxbit::Config::TooltipComponent.styles[:base] = 'absolute z-10 invisible inline-block px-2 py-1 text-xs font-normal text-white bg-black rounded shadow-sm opacity-0 tooltip' # Custom styling
```

## Dependencies

- [**Flowbite**](https://flowbite.com/): Used for tooltip positioning and behavior.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Floating UI**](https://floating-ui.com/): Used for advanced positioning (via Flowbite).

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::TooltipComponent.styles)) %>
```

## References

[Flowbite Tooltips](https://flowbite.com/docs/components/tooltips/)