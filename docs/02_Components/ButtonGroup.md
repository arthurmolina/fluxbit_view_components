---
label: ButtonGroup
title: Fluxbit::ButtonGroupComponent or fx_button_group
---

The `Fluxbit::ButtonGroupComponent` is a customizable button group component that extends `Fluxbit::Component`.
It allows you to create visually cohesive groups of buttons that are connected together, perfect for toolbars, navigation elements, or grouped actions.

To start using the button group you can use the default way to call the component:

```html
&lt;%= render Fluxbit::ButtonGroupComponent.new do |group| %&gt;
  &lt;%= group.with_button(color: :default) do %&gt;First&lt;% end %&gt;
  &lt;%= group.with_button(color: :default) do %&gt;Second&lt;% end %&gt;
  &lt;%= group.with_button(color: :default) do %&gt;Third&lt;% end %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_button_group do |group| %&gt;
  &lt;%= group.with_button(color: :default) do %&gt;First&lt;% end %&gt;
  &lt;%= group.with_button(color: :default) do %&gt;Second&lt;% end %&gt;
  &lt;%= group.with_button(color: :default) do %&gt;Third&lt;% end %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| **props            |          | Additional HTML attributes applied to the button group container.

## Slots

The component supports the following slots:

- `with_button`: Add individual buttons to the group with all standard button options (color, size, pill, disabled, etc.)

## Examples

### Basic Button Groups

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="basic_groups" panels="source"></lookbook-embed>

### Outlined Button Groups

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="outlined_groups" panels="source"></lookbook-embed>

### Button Groups with Icons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="groups_with_icons" panels="source"></lookbook-embed>

### Different Sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="different_sizes" panels="source"></lookbook-embed>

### Toolbar Style

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="toolbar_style" panels="source"></lookbook-embed>

### Navigation Groups

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="navigation_groups" panels="source"></lookbook-embed>

### Mixed Button Types

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="mixed_button_types" panels="source"></lookbook-embed>

### Active States

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="active_states" panels="source"></lookbook-embed>

### Disabled Buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="disabled_buttons" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ButtonGroupComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_button_group_component_defaults.rb

Fluxbit::Config::ButtonComponent.styles[:group] = 'inline-flex rounded-lg shadow-md' # the default is 'inline-flex rounded-md shadow-xs'
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons in buttons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::ButtonComponent.styles)) %>
```

## References

[Flowbite Button Group](https://flowbite.com/docs/components/button-group/)