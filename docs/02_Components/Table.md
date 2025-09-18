---
label: Table
title: Fluxbit::TableComponent or fx_table
---

The `Fluxbit::TableComponent` is a customizable table component that extends `Fluxbit::Component`.
It allows you to create responsive data tables with various styling options including striped rows, borders, hover effects, and shadows.

To start using the table you can use the default way to call the component:

```html
&lt;%= render Fluxbit::TableComponent.new do |table| %&gt;
  &lt;% table.with_header do |header| %&gt;
    &lt;% header.with_cell { "Column 1" } %&gt;
    &lt;% header.with_cell { "Column 2" } %&gt;
  &lt;% end %&gt;
  
  &lt;% table.with_row do |row| %&gt;
    &lt;% row.with_cell { "Data 1" } %&gt;
    &lt;% row.with_cell { "Data 2" } %&gt;
  &lt;% end %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_table do |table| %&gt;
  &lt;% table.with_header do |header| %&gt;
    &lt;% header.with_cell { "Column 1" } %&gt;
    &lt;% header.with_cell { "Column 2" } %&gt;
  &lt;% end %&gt;
  
  &lt;% table.with_row do |row| %&gt;
    &lt;% row.with_cell { "Data 1" } %&gt;
    &lt;% row.with_cell { "Data 2" } %&gt;
  &lt;% end %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| striped:           | false    | Determines if the table rows should be striped.
| bordered:          | false    | Determines if the table should have borders.
| hover:             | false    | Determines if the table rows should highlight on hover.
| shadow:            | false    | Determines if the table should have a shadow effect.
| only_rows:         | false    | If true, only renders rows without wrapper/table structure (useful for partials).
| wrapper_html:      | {}       | Additional HTML attributes for the table wrapper.
| thead_html:        | {}       | Additional HTML attributes for the table header.
| tbody_html:        | {}       | Additional HTML attributes for the table body.
| tfoot_html:        | {}       | Additional HTML attributes for the table footer.
| tr_html:           | {}       | Additional HTML attributes for the table rows.
| cells_html:        | {}       | Additional HTML attributes for the table cells.
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

## Slots

The component supports the following slots:

- `with_header`: Add table header rows with columns.
- `with_row`: Add table body rows with cells. Supports color parameter for row styling.
- `with_footer`: Add table footer rows with columns.

Each slot provides access to cell methods:
- `with_cell`: Add individual cells to rows/headers/footers.

## Examples

### Basic table

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="basic_table" panels="source"></lookbook-embed>

### Striped rows

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="striped_rows" panels="source"></lookbook-embed>

### Bordered table

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="bordered_table" panels="source"></lookbook-embed>

### Hover effects

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="hover_effects" panels="source"></lookbook-embed>

### Table with shadow

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="table_shadow" panels="source"></lookbook-embed>

### Colored rows

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="colored_rows" panels="source"></lookbook-embed>

### Table with footer

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="table_footer" panels="source"></lookbook-embed>

### Selected cells

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="selected_cells" panels="source"></lookbook-embed>

### Only rows (for partials)

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="only_rows" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TableComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_table_component_defaults.rb

Fluxbit::Config::TableComponent.striped = true # the default is false
Fluxbit::Config::TableComponent.bordered = true # the default is false
Fluxbit::Config::TableComponent.hover = true # the default is false
Fluxbit::Config::TableComponent.shadow = true # the default is false
Fluxbit::Config::TableComponent.styles[:root][:base] = 'w-full text-sm text-gray-600' # Custom base styling
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::TableComponent.styles)) %>
```

## References

[Flowbite Tables](https://flowbite.com/docs/components/tables/)