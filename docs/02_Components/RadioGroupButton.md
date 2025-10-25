---
label: Radio Group Button
title: Fluxbit::Form::RadioGroupButtonComponent or fx_radio_group_button
---

The `Fluxbit::Form::RadioGroupButtonComponent` is a component for rendering radio buttons styled as a button group. It provides the visual appearance of grouped buttons while maintaining radio button behavior (only one option can be selected at a time).

This component is useful for creating segmented controls, view toggles, or any interface where users need to select one option from a group with a button-like appearance.

To start using the radio group button you can use the default way to call the component:

```html
<%= render Fluxbit::Form::RadioGroupButtonComponent.new(name: "view_mode") do |radio| %>
  <%= radio.with_radio_option(value: "list", checked: true) do %>List View<% end %>
  <%= radio.with_radio_option(value: "grid") do %>Grid View<% end %>
<% end %>
```

or you can use the alias (from the helpers):

```html
<%= fx_radio_group_button(name: "view_mode") do |radio| %>
  <%= radio.with_radio_option(value: "list", checked: true) do %>List View<% end %>
  <%= radio.with_radio_option(value: "grid") do %>Grid View<% end %>
<% end %>
```

or within a form using the form builder:

```erb
<%= fx_form_with(model: @post) do |form| %>
  <%= form.fx_radio_group_button(:status, color: :info) do |radio| %>
    <%= radio.with_radio_option(value: "draft") do %>Draft<% end %>
    <%= radio.with_radio_option(value: "published", checked: true) do %>Published<% end %>
    <%= radio.with_radio_option(value: "archived") do %>Archived<% end %>
  <% end %>
<% end %>
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RadioGroupButtonComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| name:              | auto-generated | The name attribute for the radio button group (required for proper radio functionality).
| color:             | :default | The color style of the buttons (same options as ButtonComponent).
| size:              | 1        | The size of the buttons (e.g., `0` to `4`).
| pill:              | false    | If set to true, the buttons will have rounded "pill" edges.
| **props            |          | Additional HTML attributes.

## Slot Options

The component supports the following slot:

- `with_radio_option`: Add individual radio button options. Each option supports:
  - `value`: The value for this radio option (required)
  - `checked`: Whether this option is initially selected (boolean)
  - `disabled`: Whether this option is disabled (boolean)

## Examples

### Basic radio group button

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RadioGroupButtonComponentPreview" scenario="basic_radio_group" panels="source"></lookbook-embed>

### Different colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RadioGroupButtonComponentPreview" scenario="colored_radio_groups" panels="source"></lookbook-embed>

### Different sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RadioGroupButtonComponentPreview" scenario="sized_radio_groups" panels="source"></lookbook-embed>

### Pill style

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RadioGroupButtonComponentPreview" scenario="pill_radio_groups" panels="source"></lookbook-embed>

### With icons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RadioGroupButtonComponentPreview" scenario="with_icons" panels="source"></lookbook-embed>

### With disabled options

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::RadioGroupButtonComponentPreview" scenario="with_disabled" panels="source"></lookbook-embed>

## Use Cases

### View Mode Toggle

```erb
<%= fx_radio_group_button(name: "display_mode") do |radio| %>
  <%= radio.with_radio_option(value: "list", checked: true) do %>
    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
      <path d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"></path>
    </svg>
  <% end %>
  <%= radio.with_radio_option(value: "grid") do %>
    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
      <path d="M5 3a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2V5a2 2 0 00-2-2H5zM5 11a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H5zM11 5a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V5zM11 13a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path>
    </svg>
  <% end %>
<% end %>
```

### Time Period Selector

```erb
<%= fx_radio_group_button(name: "period", color: :info) do |radio| %>
  <%= radio.with_radio_option(value: "day") do %>Day<% end %>
  <%= radio.with_radio_option(value: "week", checked: true) do %>Week<% end %>
  <%= radio.with_radio_option(value: "month") do %>Month<% end %>
  <%= radio.with_radio_option(value: "year") do %>Year<% end %>
<% end %>
```

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters. The component uses ButtonComponent styles for colors, sizes, and other visual properties.

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for button styling.

## Styles

The component leverages styles from both:
- `Fluxbit::Config::RadioGroupButtonComponent.styles` - For group and label specific styling
- `Fluxbit::Config::ButtonComponent.styles` - For button colors, sizes, and variants

## References

- [Flowbite Buttons](https://flowbite.com/docs/components/buttons/)
- [Flowbite Button Group](https://flowbite.com/docs/components/button-group/)
