---
label: Flex
title: Fluxbit::FlexComponent or fx_flex
---

The `Fluxbit::FlexComponent` is a customizable flex container component that extends `Fluxbit::Component`.
It allows you to create responsive layouts with full control over flex direction, alignment, wrapping, gap spacing, and responsive behavior across different screen sizes. The component provides a clean interface for managing complex flexbox layouts with Tailwind CSS classes.

To start using the flex container you can use the default way to call the component:

```html
&lt;%= render Fluxbit::FlexComponent.new(justify_content: :center, align_items: :center, gap: 2) do %&gt;
  &lt;div&gt;Item 1&lt;/div&gt;
  &lt;div&gt;Item 2&lt;/div&gt;
  &lt;div&gt;Item 3&lt;/div&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_flex(justify_content: :center, align_items: :center, gap: 2) do %&gt;
  &lt;div&gt;Item 1&lt;/div&gt;
  &lt;div&gt;Item 2&lt;/div&gt;
  &lt;div&gt;Item 3&lt;/div&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::FlexComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default | Description
|:-------------------|:--------|:------------
| vertical:          | false   | Set flex direction to column instead of row
| reverse:           | false   | Reverse the flex direction (row-reverse or column-reverse)
| justify_content:   | nil     | Content justification (`:start`, `:end`, `:center`, `:baseline`, `:stretch`, `:space_around`, `:space_between`, `:space_evenly`, `:normal`)
| align_items:       | nil     | Items alignment (`:start`, `:end`, `:center`, `:baseline`, `:stretch`)
| wrap:              | false   | Enable flex wrapping
| wrap_reverse:      | false   | Enable reverse flex wrapping
| gap:               | nil     | Gap between flex items (0-10: 0px to 80px spacing)
| sm:                | {}      | Small screen responsive settings (same options as above)
| md:                | {}      | Medium screen responsive settings (same options as above)
| lg:                | {}      | Large screen responsive settings (same options as above)
| xl:                | {}      | Extra large screen responsive settings (same options as above)
| :'2xl':            | {}      | 2X large screen responsive settings (same options as above)
| remove_class:      | ""      | Classes to be removed from the default class list
| **props            |         | Additional HTML attributes for the flex container

### Responsive Options

Each responsive breakpoint (sm, md, lg, xl, 2xl) accepts the same flex options:

```html
&lt;%= fx_flex(
  justify_content: :start,
  md: { justify_content: :center, vertical: true },
  lg: { justify_content: :space_between, gap: 4 }
) do %&gt;
  Content here
&lt;% end %&gt;
```

## Slots

This component does not define any named slots. The flex container content is provided through the default block:

```html
&lt;%= fx_flex(justify_content: :center) do %&gt;
  &lt;div&gt;This is the flex container content&lt;/div&gt;
&lt;% end %&gt;
```

## Examples

### Default flex container

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::FlexComponentPreview" scenario="default" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_flex_component_defaults.rb

# Add custom gap sizes
Fluxbit::Config::FlexComponent.styles[:gap] += ["gap-24", "gap-32", "gap-40"]

# Add custom justify content options
Fluxbit::Config::FlexComponent.styles[:justify_content][:custom] = "justify-custom"

# Add custom align items options
Fluxbit::Config::FlexComponent.styles[:align_items][:custom] = "items-custom"

# Add new responsive breakpoints
Fluxbit::Config::FlexComponent.styles[:resolutions] += [:'3xl', :'4xl']
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::FlexComponent.styles)) %>
```

## References

[Tailwind CSS Flexbox](https://tailwindcss.com/docs/flexbox-grid)