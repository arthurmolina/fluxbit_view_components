---
label: Button
title: Fluxbit::ButtonComponent or fx_button
---

The `Fluxbit::ButtonComponent` is a customizable button component that extends `Fluxbit::Component`.
It allows you to create buttons with various styles, sizes, colors, and supports additional features like popovers and tooltips.

To start using the button you can use the default way to call the component:

```html

&lt;%= render Fluxbit::ButtonComponent.new.with_content('A button') %&gt;

<!-- or -->

&lt;%= render Fluxbit::ButtonComponent.new do %&gt;
    A button
&lt;% end %&gt;

```

or you can use the alias (from the helpers):

```html

&lt;%= fx_button(with_content: 'A button') %&gt;

<!-- or -->

&lt;%= fx_button do %&gt;
    A button
&lt;% end %&gt;

```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| form:              | nil      | Form object (better used with FormBuilder)
| color:             | :default | Sets the color scheme of the component, with being the standard color.
| pill:              | false    | If set to true, the component will have rounded corners, giving it a "pill" shape.
| size:              | 1        | Specifies the size of the component. Medium is the default size (e.g., 0 to <%=Fluxbit::Config::ButtonComponent.styles[:size].count - 1 %>).
| as:                | :button  | Change the HTML element, for example, to "a" element.
| selected:          | false    | If set to true, the button will appear darker to indicate selected state.
| popover_text:      | nil      | Popover text
| popover_placement: | :right   | Popover placement
| popover_trigger:   | :hover   | Popover trigger: :hover or :click
| tooltip_text:      | nil      | Tooltip text
| tooltip_placement: | :right   | Tooltip placement
| tooltip_trigger:   | :hover   | Tooltip trigger: :hover or :click
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

## Slots

The component supports the following slots:

- `with_popover`: Add popover title and content with markup.
- `with_tooltip`: Add tooltip content with markup.

## Examples

### Default buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="default_buttons" panels="source"></lookbook-embed>

### Button pills

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="button_pills" panels="source"></lookbook-embed>

### Gradient monochrome

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="gradient_monochrome" panels="source"></lookbook-embed>

### Gradient duotone

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="gradient_duotone" panels="source"></lookbook-embed>

### Outline buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="outline_buttons" panels="source"></lookbook-embed>

### Button sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="button_sizes" panels="source"></lookbook-embed>

### Button with icon (and animation)

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="button_with_icon" panels="source"></lookbook-embed>

### Disabled buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="disabled_buttons" panels="source"></lookbook-embed>

### Selected buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="selected_buttons" panels="source"></lookbook-embed>

### With popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="with_popover" panels="source"></lookbook-embed>

### With tooltip

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="with_tooltip" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

### Override Button base component

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonComponentPreview" scenario="override_button_base_component" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializerss/change_button_component_defaults.rb

Fluxbit::Config::ButtonComponent.color = :danger # the default is :default
Fluxbit::Config::ButtonComponent.pill = :true # the default is false
Fluxbit::Config::ButtonComponent.size = :xl # the default is :md
Fluxbit::Config::ButtonComponent.as = :a # the default is :button
Fluxbit::Config::ButtonComponent.styles[:full_sized] = '' # the default is 'w-full'

```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
  <%= html_escape(JSON.pretty_generate(Fluxbit::Config::ButtonComponent.styles)) %>
```

## References

[Flowbite Buttons](https://flowbite.com/docs/components/buttons/)