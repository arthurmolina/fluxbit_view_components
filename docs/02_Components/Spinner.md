---
label: Spinner
title: Fluxbit::SpinnerComponent or fx_spinner
---

The `Fluxbit::SpinnerComponent` is a customizable loading spinner component that extends `Fluxbit::Component`.
It allows you to create animated loading indicators with various colors, sizes, and accessibility features for indicating loading states in your application.

To start using the spinner you can use the default way to call the component:

```html
&lt;%= render Fluxbit::SpinnerComponent.new %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::SpinnerComponent.new(color: :success, size: 2, label: "Loading...") %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_spinner %&gt;

&lt;!-- or --&gt;

&lt;%= fx_spinner(color: :success, size: 2, label: "Loading...") %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param              | Default      | Description
|:-------------------|:-------------|:------------
| color:             | :default     | Sets the color scheme of the spinner (:default, :info, :success, :failure, :warning, :pink, :purple).
| size:              | 1            | Specifies the size of the spinner (0 to 4, where 0=xs, 1=sm, 2=md, 3=lg, 4=xl).
| label:             | "Loading..." | The aria-label text for screen readers and accessibility.
| remove_class:      | ""           | Classes to be removed from the default class list.
| **props            |              | Additional HTML attributes.

## Slots

This component does not define any named slots. The spinner is a self-contained SVG element with accessibility features built-in.

## Examples

### Default spinner

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Spinner colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerComponentPreview" scenario="colors" panels="source"></lookbook-embed>

### Spinner sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerComponentPreview" scenario="sizes" panels="source"></lookbook-embed>

### Spinner in buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerComponentPreview" scenario="in_buttons" panels="source"></lookbook-embed>

### Spinner with cards

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerComponentPreview" scenario="with_cards" panels="source"></lookbook-embed>

### Custom labels

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerComponentPreview" scenario="custom_labels" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_spinner_component_defaults.rb

Fluxbit::Config::SpinnerComponent.color = :success # the default is :default
Fluxbit::Config::SpinnerComponent.size = 2 # the default is 1
Fluxbit::Config::SpinnerComponent.label = "Please wait..." # the default is "Loading..."
Fluxbit::Config::SpinnerComponent.styles[:base] = 'animate-pulse' # the default is 'animate-spin'
Fluxbit::Config::SpinnerComponent.styles[:colors][:custom] = 'text-indigo-200 fill-indigo-600' # add custom color
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component and animations.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::SpinnerComponent.styles)) %>
```

## Accessibility

The Spinner component includes several accessibility features:

- **Role attribute**: Uses `role="status"` to indicate a loading status to screen readers
- **ARIA label**: Includes `aria-label` with customizable text for screen readers
- **Screen reader text**: Contains hidden text using `.sr-only` class for assistive technologies
- **Semantic markup**: Uses appropriate SVG structure with descriptive paths
- **Color contrast**: Follows WCAG guidelines with sufficient color contrast ratios

## References

[Flowbite Spinner](https://flowbite.com/docs/components/spinner/)