---
label: ThemeButton
title: Fluxbit::ThemeButtonComponent or fx_theme_button
---

The `Fluxbit::ThemeButtonComponent` is a round button component that extends `Fluxbit::ButtonComponent`.
It allows you to toggle between dark, light, and system themes with automatic persistence and icon indicators.

To start using the theme button you can use the default way to call the component:

```html

&lt;%= render Fluxbit::ThemeButtonComponent.new %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::ThemeButtonComponent.new do %&gt;
  &lt;!-- Custom content (optional) --&gt;
&lt;% end %&gt;

```

or you can use the alias (from the helpers):

```html

&lt;%= fx_theme_button %&gt;

&lt;!-- or with options --&gt;

&lt;%= fx_theme_button(tooltip_text: 'Toggle theme', size: 3) %&gt;

```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ThemeButtonComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default        | Description
|:-------------------|:---------------|:------------
| color:             | :transparent   | Sets the color scheme of the component.
| pill:              | true           | Makes the button round (always enabled for theme button).
| size:              | 2              | Specifies the size of the component (0 to <%=Fluxbit::Config::ButtonComponent.styles[:size].count - 1 %>).
| as:                | :button        | Change the HTML element, for example, to "a" element.
| tooltip_text:      | nil            | Tooltip text
| tooltip_placement: | :right         | Tooltip placement: :top, :right, :bottom, :left
| tooltip_trigger:   | :hover         | Tooltip trigger: :hover or :click
| popover_text:      | nil            | Popover text
| popover_placement: | :right         | Popover placement: :top, :right, :bottom, :left
| popover_trigger:   | :hover         | Popover trigger: :hover or :click
| remove_class:      | ""             | Classes to be removed from the default class list.
| **props            |                | Additional HTML attributes.

## Slots

The component supports the following slots:

- `with_tooltip`: Add tooltip content with markup.
- `with_popover`: Add popover title and content with markup.

## Examples

### Default theme button

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ThemeButtonComponentPreview" scenario="default" panels="source"></lookbook-embed>

### With tooltip

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ThemeButtonComponentPreview" scenario="with_tooltip" panels="source"></lookbook-embed>

### Different sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ThemeButtonComponentPreview" scenario="sizes" panels="source"></lookbook-embed>

### Different colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ThemeButtonComponentPreview" scenario="colors" panels="source"></lookbook-embed>

## Theme Modes

The button cycles through three theme modes when clicked:

1. **Light Mode**: Displays sun icon, applies light theme
2. **Dark Mode**: Displays moon icon, applies dark theme
3. **System Mode**: Displays computer icon, respects OS preference

The theme preference is automatically saved to localStorage and persists across sessions.

## JavaScript Integration

The component uses the `fx-theme-button` Stimulus controller which:

- Loads saved theme from localStorage on connect
- Applies theme to document root element (`html` tag)
- Dispatches custom events for theme changes
- Supports system preference detection

### Listening to Theme Changes

```html

&lt;script&gt;
document.addEventListener('fx-theme-button:changed', (event) =&gt; {
  console.log('Theme changed to:', event.detail.theme);
});
&lt;/script&gt;

```

## Tailwind Dark Mode Setup

Ensure your Tailwind configuration uses the `class` strategy for dark mode:

```javascript
// tailwind.config.js
module.exports = {
  darkMode: 'class',
  // ... other config
}
```

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_theme_button_component_defaults.rb

Fluxbit::Config::ThemeButtonComponent.color = :info # the default is :transparent
Fluxbit::Config::ThemeButtonComponent.pill = true # the default is true
Fluxbit::Config::ThemeButtonComponent.size = 3 # the default is 2
Fluxbit::Config::ThemeButtonComponent.as = :a # the default is :button

```

## Dependencies

- [**Stimulus**](https://stimulus.hotwired.dev/): Used for theme switching behavior.
- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons (sun, moon, computer).
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component and dark mode support.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

The component inherits all styles from ButtonComponent:

```ruby
  <%= html_escape(JSON.pretty_generate(Fluxbit::Config::ButtonComponent.styles)) %>
```

## References

- [Flowbite Buttons](https://flowbite.com/docs/components/buttons/)
- [Tailwind CSS Dark Mode](https://tailwindcss.com/docs/dark-mode)
