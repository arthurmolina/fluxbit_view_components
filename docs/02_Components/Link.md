---
label: Link
title: Fluxbit::LinkComponent or fx_link
---

The `Fluxbit::LinkComponent` is a customizable link component that extends `Fluxbit::Component`.
It allows you to create anchor elements with various color styles and supports additional features like hover effects and custom styling.

To start using the link you can use the default way to call the component:

```html
&lt;%= render Fluxbit::LinkComponent.new(href: "/path").with_content('Link text') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::LinkComponent.new(href: "/path") do %&gt;
    Link text
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_link(with_content: 'Link text', href: '/path') %&gt;

&lt;!-- or --&gt;

&lt;%= fx_link(href: '/path') do %&gt;
    Link text
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::LinkComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| color:             | :primary | Sets the color scheme of the link (:default, :primary, :secondary, :success, :danger, :warning, :info, :light, :dark).
| href:              | "#"      | The URL that the link points to.
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

## Slots

This component does not define any named slots. The text/content for the link is provided through the default block:

```html
&lt;%= render Fluxbit::LinkComponent.new(href: "/path") do %&gt;
  This is the link content
&lt;% end %&gt;
```

## Examples

### Default links

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::LinkComponentPreview" scenario="default_links" panels="source"></lookbook-embed>

### Colored links

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::LinkComponentPreview" scenario="colored_links" panels="source"></lookbook-embed>

### Links with custom attributes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::LinkComponentPreview" scenario="links_with_attributes" panels="source"></lookbook-embed>

### External links

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::LinkComponentPreview" scenario="external_links" panels="source"></lookbook-embed>

### Links in text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::LinkComponentPreview" scenario="links_in_text" panels="source"></lookbook-embed>

### Navigation links

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::LinkComponentPreview" scenario="navigation_links" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::LinkComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::LinkComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_link_component_defaults.rb

Fluxbit::Config::LinkComponent.color = :danger # the default is :primary
Fluxbit::Config::LinkComponent.styles[:base] = "font-semibold text-blue-700 dark:text-blue-600 hover:text-blue-800" # customize base styling
Fluxbit::Config::LinkComponent.styles[:colors][:custom] = "text-purple-600 dark:text-purple-500 hover:text-purple-800"
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::LinkComponent.styles)) %>
```

## References

[Flowbite Links](https://flowbite.com/docs/typography/links/)