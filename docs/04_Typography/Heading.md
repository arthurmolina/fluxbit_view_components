---
label: Heading
title: Fluxbit::HeadingComponent or fx_heading
---

The **Fluxbit::HeadingComponent** is a customizable heading component that extends **Fluxbit::Component**. 
It provides a straightforward way to generate heading elements (`<h1>` through `<h6>`) with configurable sizes, 
letter spacing, and line heights. Additional HTML attributes can be passed to further control the component’s 
behavior and styling.

To start using the heading you can you the default way to call the component:

```html
&lt;%= render Fluxbit::HeadingComponent.new(size: 2, spacing: :wider, line_height: :relaxed) do %&gt;
  My Heading
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_heading(size: 2, spacing: :wider, line_height: :relaxed) do %&gt;
  My Heading
&lt;% end %&gt;
```
The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Typography::HeadingComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param       | Default | Description
|:----------- |:------- |:-----------
| size        | 1       | An integer from 1 to 6 that determines which heading level is rendered (`<h1>` through `<h6>`).
| spacing     | :tight  | The letter spacing style for the heading. Must be one of the keys defined in `styles[:spacings]`, such as `:tighter`, `:tight`, `:normal`, `:wide`, `:wider`, or `:widest`.
| line_height | :none   | The line height style for the heading. Must be one of the keys defined in `styles[:line_heights]`, such as `:none`, `:tight`, `:snug`, `:normal`, `:relaxed`, or `:loose`.
| props       |         | Additional HTML attributes to be applied to the heading element, such as `class`, `id`, `data-*`, etc. (e.g. `props: { class: 'my-heading-class' }`).

## Slots

This component does not define any named slots. The text/content for the heading is provided through the default block:

```html
&lt;%= render Fluxbit::HeadingComponent.new(size: 3) do %&gt;
  This is the heading content
&lt;% end %&gt;
```

## Examples

### Different heading sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Typography::HeadingComponentPreview" scenario="heading_sizes" panels="source"></lookbook-embed>

### Different letter spacing

<lookbook-embed app="/lookbook/" preview="Fluxbit::Typography::HeadingComponentPreview" scenario="heading_spacing" panels="source"></lookbook-embed>

### Different line heights

<lookbook-embed app="/lookbook/" preview="Fluxbit::Typography::HeadingComponentPreview" scenario="heading_line_height" panels="source"></lookbook-embed>

### Adding other HTML attributes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Typography::HeadingComponentPreview" scenario="adding_other_attributes" panels="source"></lookbook-embed>

## Customization

You can customize the appearance of this component by passing different parameters and by adding or overriding 
the default styles. For instance, you can create an initializer (e.g., `config/initializers/change_heading_component_defaults.rb`) 
to modify the default styles:

```ruby
Fluxbit::Config::HeadingComponent.size = 1 # this is the default value
Fluxbit::Config::HeadingComponent.spacing = :tight # this is the default value
Fluxbit::Config::HeadingComponent.line_height = :none # this is the default value
Fluxbit::Config::HeadingComponent.styles[:line_heights] = [
  none: "leading-none",
  # ...
]
```

This allows you to centrally manage your default styles for headings throughout your application.

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
  <%= html_escape(JSON.pretty_generate(Fluxbit::Config::HeadingComponent.styles)) %>
```

## References

- [Tailwind CSS Typography](https://tailwindcss.com/docs/typography-plugin)
- [Flowbite Components](https://flowbite.com/docs/typography/headings/)