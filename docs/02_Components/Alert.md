---
label: Alert
title: Fluxbit::Components::AlertComponent or fx_alert
---

The `Fluxbit::Components::AlertComponent` is a customizable alert component that extends `Fluxbit::Component`.
It provides various options to display alert messages with different styles, icons, and behaviors such as close functionality and animations.

To start using the alert box you can you the default way to call the component:

```html

&lt;%= render Fluxbit::AlertComponent.new(color: :danger).with_content('Alert') %&gt;

or

&lt;%= render Fluxbit::AlertComponent.new(color: :danger) do %&gt;
    Alert
&lt;% end %&gt;

```

or you can use the alias (from the helpers):

```html

&lt;%= fx_alert(color: :danger).with_content('Alert') %&gt;

or

&lt;%= fx_alert(color: :danger) do %&gt;
    Alert
&lt;% end %&gt;

```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param              | Default   | Description
|:-------------------|:----------|:------------
| color:             | :info     | Sets the color scheme of the component, with being the standard color.
| icon:              | :default  | Icon to be displayed (`:default` for default icon based on color).
| can_close:         | true      | Adds a close button.
| dismiss_timeout:   | 3000      | Number of miliseconds before the alert disappears. Set to 0 to disable. Only works with **Stimulus Component Notification** installed.
| out_animation:     | :fade_out | Choose the dismiss animation. You can see the available options on the styles below.
| fade_in_animation: | true      | Set to true to fade in when the alert opens.
| all_rounded:       | true      | Rounded corners on all sides with a border.
| class_icon:        | nil       | Custom class styles to icon element
| remove_class:      | ""        | Classes to be removed from the default class list.
| **props            |           | Additional HTML attributes.

> **Note:** The Fade out / Dissiming timeout animation only works with **Stimulus Component Notification** installed.

## Examples

### Default alert (with default icons)

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="default_alerts" panels="source"></lookbook-embed>

### Alerts with icon

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="alert_with_icon" panels="source"></lookbook-embed>

### Alerts without icon

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="alert_without_icon" panels="source"></lookbook-embed>

### Alerts with list

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="alert_with_list" panels="source"></lookbook-embed>

### Fade Out / Dismissing timeout

> **Note:** This Fade out / Dissiming timeout animation only works with **Stimulus Component Notification** installed.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="dismissing_timeout" panels="source"></lookbook-embed>

### Fade Out/Dismissing animation

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="dismissing_animation" panels="source"></lookbook-embed>

### Additional content

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="additional_content" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AlertComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializerss/change_alert_component_defaults.rb

Fluxbit::Config::AlertComponent.color = :danger # the default is :info
Fluxbit::Config::AlertComponent.icon = :default # the default is :default
Fluxbit::Config::AlertComponent.can_close = false # the default is true
Fluxbit::Config::AlertComponent.out_animation = :fade_out # the default is :fade_out
Fluxbit::Config::AlertComponent.fade_in = true # the default is true
Fluxbit::Config::AlertComponent.dismiss_timeout = 5000 # the default is 3000
Fluxbit::Config::AlertComponent.all_rounded = true # the default is true
Fluxbit::Config::AlertComponent.styles[:all_rounded][:on] = '' # the default is 'rounded-lg border-2'

```

## Dependencies

- [**Stimulus Component Notification**](https://www.stimulus-components.com/docs/stimulus-notification): Used for removing the element with animation.
- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
  <%= html_escape(JSON.pretty_generate(Fluxbit::Config::AlertComponent.styles)) %>
```

## References

[Flowbite Alert](https://flowbite.com/docs/components/alerts/)