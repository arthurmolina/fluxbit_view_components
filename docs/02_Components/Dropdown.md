---
label: Dropdown
title: Fluxbit::DropdownComponent or fx_dropdown
---

The `Fluxbit::DropdownComponent` is a customizable dropdown component that extends `Fluxbit::Component`.
It allows you to create dropdown menus with various sizes, automatic dividers, and multi-level nested dropdowns. The dropdown component supports different item types including links, buttons, and dividers, with icon integration and flexible styling options.

To start using the dropdown you can use the default way to call the component:

```html
&lt;%= render Fluxbit::DropdownComponent.new(sizing: 0, auto_divider: true) do |dropdown| %&gt;
  &lt;% dropdown.with_item "Dashboard", icon: "heroicons_solid:eye", content_html: {href: "#"}, as: :a %&gt;
  &lt;% dropdown.with_item divider: true %&gt;
  &lt;% dropdown.with_item "Earnings", as: :button %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_dropdown(sizing: 0, auto_divider: true) do |dropdown| %&gt;
  &lt;% dropdown.with_item "Dashboard", icon: "heroicons_solid:eye", content_html: {href: "#"}, as: :a %&gt;
  &lt;% dropdown.with_item divider: true %&gt;
  &lt;% dropdown.with_item "Earnings", as: :button %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DropdownComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default | Description
|:-------------------|:--------|:------------
| sizing:            | 0       | Size of the dropdown (0-3: small to extra large)
| auto_divider:      | true    | Automatically add dividers between dropdown items
| remove_class:      | ""      | Classes to be removed from the default class list
| **props            |         | Additional HTML attributes for the dropdown container

### Item Options

Each dropdown item supports the following parameters:

| Param                    | Default | Description
|:-------------------------|:--------|:------------
| as:                      | :div    | HTML element type (`:div`, `:a`, `:button`)
| height:                  | 0       | Height constraint for scrollable items (0-4)
| icon:                    | nil     | Icon identifier to display before the item text (uses Anyicon)
| divider:                 | false   | If true, renders as a divider line instead of content
| content_html:            | {}      | HTML attributes for the item content element
| icon_html:               | {}      | HTML attributes for the icon element
| dropdown_id:             | nil     | ID for nested dropdown (auto-generated if not provided)
| dropdown_placement:      | nil     | Placement for nested dropdown (e.g., "right-start", "left-start")
| **props                  |         | Additional HTML attributes for the item container

## Slots

The component supports the following slots:

- `with_item`: Add dropdown items with text, icons, links, buttons, dividers, or nested dropdowns. Each item can have its own properties and nested items.

### Item Slots

Each dropdown item supports:

- `with_item`: Add nested dropdown items for multi-level dropdown menus.

## Examples

### Default dropdown

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DropdownComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Multi-level dropdown

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DropdownComponentPreview" scenario="multi_level_dropdown" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_dropdown_component_defaults.rb

Fluxbit::Config::DropdownComponent.sizing = 1 # the default is 0
Fluxbit::Config::DropdownComponent.auto_divider = false # the default is true
Fluxbit::Config::DropdownComponent.height = 1 # the default is 0
Fluxbit::Config::DropdownComponent.styles[:sizes] = ["w-40", "w-52", "w-64", "w-80"] # modify size options
Fluxbit::Config::DropdownComponent.styles[:icon] = "mr-3 h-5 w-5" # change icon styling
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons in dropdown items.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::DropdownComponent.styles)) %>
```

## References

[Flowbite Dropdown](https://flowbite.com/docs/components/dropdowns/)