---
label: SpeedDial
title: Fluxbit::SpeedDialComponent or fx_speed_dial
---

The `Fluxbit::SpeedDialComponent` is a customizable speed dial component that extends `Fluxbit::Component`.
It allows you to create floating action buttons that reveal additional action buttons when triggered. The speed dial component supports different positions, shapes (rounded or square), text placement options, and flexible action configurations with icons, tooltips, and custom styling.

To start using the speed dial you can use the default way to call the component:

```html
&lt;%= render Fluxbit::SpeedDialComponent.new(position: :bottom_right, square: false, text_outside: false) do |speed_dial| %&gt;
  &lt;% speed_dial.with_action icon: "plus", tooltip: "Add new item" %&gt;
  &lt;% speed_dial.with_action icon: "pencil", tooltip: "Edit item" %&gt;
  &lt;% speed_dial.with_action icon: "trash", tooltip: "Delete item" %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_speed_dial(position: :bottom_right, square: false, text_outside: false) do |speed_dial| %&gt;
  &lt;% speed_dial.with_action icon: "plus", tooltip: "Add new item" %&gt;
  &lt;% speed_dial.with_action icon: "pencil", tooltip: "Edit item" %&gt;
  &lt;% speed_dial.with_action icon: "trash", tooltip: "Delete item" %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpeedDialComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default        | Description
|:-------------------|:---------------|:------------
| position:          | :bottom_right  | Position of the speed dial (`:top_left`, `:top_right`, `:bottom_left`, `:bottom_right`)
| square:            | false          | Whether to use square shape instead of rounded buttons
| text_outside:      | false          | Whether to display text outside action buttons
| trigger_icon:      | "plus"         | Icon for the main trigger button
| remove_class:      | ""             | Classes to be removed from the default class list
| **props            |                | Additional HTML attributes for the speed dial container

### Action Options

Each speed dial action supports the following parameters:

| Param                    | Default | Description
|:-------------------------|:--------|:------------
| icon:                    | nil     | Icon identifier to display in the action button (uses Anyicon)
| text:                    | nil     | Text label for the action (used as tooltip if tooltip not specified)
| tooltip:                 | nil     | Tooltip text to display on hover (defaults to text if not provided)
| href:                    | nil     | URL to link to (creates an anchor tag instead of button)
| text_outside:            | false   | Whether to display text outside this specific button (inherits from parent if not specified)
| **props                  |         | Additional HTML attributes for the action button

## Slots

The component supports the following slots:

- `with_action`: Add action buttons with icons, text, tooltips, links, and custom properties. Actions can be either buttons or links depending on the `href` parameter.

## Examples

### Default speed dial

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpeedDialComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Different positions

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpeedDialComponentPreview" scenario="positions" panels="source"></lookbook-embed>

### Square buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpeedDialComponentPreview" scenario="square_buttons" panels="source"></lookbook-embed>

### Text outside buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpeedDialComponentPreview" scenario="text_outside" panels="source"></lookbook-embed>

### Custom actions and icons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpeedDialComponentPreview" scenario="custom_actions" panels="source"></lookbook-embed>

### Comprehensive example

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpeedDialComponentPreview" scenario="comprehensive" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_speed_dial_component_defaults.rb

Fluxbit::Config::SpeedDialComponent.position = :top_right # the default is :bottom_right
Fluxbit::Config::SpeedDialComponent.square = true # the default is false
Fluxbit::Config::SpeedDialComponent.text_outside = true # the default is false

# Customize positioning
Fluxbit::Config::SpeedDialComponent.styles[:positions][:custom] = "top-20 end-20"

# Customize trigger button styling
Fluxbit::Config::SpeedDialComponent.styles[:trigger][:base] = "flex items-center justify-center text-white bg-purple-700 hover:bg-purple-800"

# Customize action button styling
Fluxbit::Config::SpeedDialComponent.styles[:action][:base] = "flex justify-center items-center w-12 h-12 text-gray-500 hover:text-gray-900"
```

## JavaScript Behavior

The speed dial component requires JavaScript to function properly. It uses Flowbite's speed dial behavior which should be initialized automatically. The component includes the following data attributes:

- `data-dial-init`: Initializes the speed dial functionality
- `data-dial-toggle`: Connects the trigger button to the menu
- `aria-controls` and `aria-expanded`: Provide accessibility support

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons in action buttons and trigger.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling and JavaScript behavior.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::SpeedDialComponent.styles)) %>
```

## References

[Flowbite Speed Dial](https://flowbite.com/docs/components/speed-dial/)