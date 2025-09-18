---
label: Breadcrumb
title: Fluxbit::BreadcrumbComponent or fx_breadcrumb
---

The `Fluxbit::BreadcrumbComponent` is a navigation component that extends `Fluxbit::Component`.
It allows you to create breadcrumb navigation trails with customizable items, icons, and dropdown support. The breadcrumb component follows Flowbite styles and provides proper accessibility with ARIA labels and semantic HTML structure.

To start using the breadcrumb you can use the default way to call the component:

```html
&lt;%= render Fluxbit::BreadcrumbComponent.new do |c| %&gt;
  &lt;% c.with_item href: "/" do %&gt;Home&lt;% end %&gt;
  &lt;% c.with_item href: "/projects" do %&gt;Projects&lt;% end %&gt;
  &lt;% c.with_item current_page: true do %&gt;Current Page&lt;% end %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_breadcrumb do |c| %&gt;
  &lt;% c.with_item href: "/" do %&gt;Home&lt;% end %&gt;
  &lt;% c.with_item href: "/projects" do %&gt;Projects&lt;% end %&gt;
  &lt;% c.with_item current_page: true do %&gt;Current Page&lt;% end %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BreadcrumbComponentPreview" scenario="basic" panels="params,source"></lookbook-embed>

## Options

| Param              | Default      | Description
|:-------------------|:-------------|:------------
| aria-label:        | "Breadcrumb" | ARIA label for the navigation element for screen readers
| remove_class:      | ""           | Classes to be removed from the default class list
| **props            |              | Additional HTML attributes for the nav element

### Item Options

Each breadcrumb item supports the following parameters:

| Param                    | Default | Description
|:-------------------------|:--------|:------------
| href:                    | nil     | URL for the breadcrumb item link. If blank, renders as plain text
| current_page:            | false   | If true, renders the item as current page (no link, different styling)
| icon:                    | nil     | Icon identifier to display before the item text (uses Anyicon)
| remove_dropdown_arrow:   | false   | If true, hides the dropdown arrow even when dropdown is present
| **props                  |         | Additional HTML attributes for the item element

## Slots

The component supports the following slots:

- `with_item`: Add breadcrumb items with text, links, icons, and optional dropdowns. Each item can have its own properties and nested dropdown content.

### Item Slots

Each breadcrumb item supports:

- `with_dropdown`: Add dropdown content to a breadcrumb item with expandable menu options.

## Examples

### Basic breadcrumb with current page

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BreadcrumbComponentPreview" scenario="basic" panels="source"></lookbook-embed>

### Breadcrumb with icons on items

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BreadcrumbComponentPreview" scenario="with_icons" panels="source"></lookbook-embed>

### Breadcrumb demonstrating dropdown on an item

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BreadcrumbComponentPreview" scenario="with_dropdown" panels="source"></lookbook-embed>

### Custom aria-label on nav

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BreadcrumbComponentPreview" scenario="custom_aria" panels="source"></lookbook-embed>

### Only link items (no current page)

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BreadcrumbComponentPreview" scenario="links_only" panels="source"></lookbook-embed>

### Long trail to showcase separators and layout

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BreadcrumbComponentPreview" scenario="long_trail" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_breadcrumb_component_defaults.rb

# Customize default styles for different breadcrumb elements
Fluxbit::Config::BreadcrumbComponent.styles[:root][:list] = 'inline-flex items-center space-x-2' # modify list styling
Fluxbit::Config::BreadcrumbComponent.styles[:item][:chevron] = 'mx-2 h-5 w-5 text-gray-500' # change separator styling
Fluxbit::Config::BreadcrumbComponent.styles[:item][:icon] = 'mr-1 h-3 w-3' # modify icon size and spacing
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons in breadcrumb items.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::BreadcrumbComponent.styles)) %>
```

## References

[Flowbite Breadcrumb](https://flowbite.com/docs/components/breadcrumb/)