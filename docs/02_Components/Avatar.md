---
label: Avatar
title: Fluxbit::AvatarComponent or fx_avatar
---

The `Fluxbit::AvatarComponent` is a customizable avatar component that extends `Fluxbit::Component`.
It allows you to display user avatars with various styles, sizes, colors, and status indicators. The avatar can display an image, placeholder initials, or a default placeholder icon, and supports features like colored borders and status dots.

To start using the avatar you can use the default way to call the component:

```html
&lt;%= render Fluxbit::AvatarComponent.new(src: "/path/to/avatar.jpg").with_content('') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::AvatarComponent.new(placeholder_initials: "AB") do %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_avatar(src: "/path/to/avatar.jpg") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_avatar(placeholder_initials: "AB") %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param              | Default     | Description
|:-------------------|:------------|:------------
| src:               |             | The source URL of the avatar image
| placeholder_initials: | false    | Initials to display as placeholder text (e.g., "AB", "JD")
| color:             | nil         | Border color (`:dark`, `:danger`, `:gray`, `:info`, `:light`, `:purple`, `:success`, `:warning`, `:pink`)
| status:            | false       | Status indicator (`:online`, `:busy`, `:offline`, `:away`)
| status_position:   | :top_right  | Position of status indicator (`:top_left`, `:top_right`, `:bottom_left`, `:bottom_right`)
| rounded:           | true        | Whether avatar should be circular (true) or square with rounded corners (false)
| size:              | :md         | Size of avatar (`:xs`, `:sm`, `:md`, `:lg`, `:xl`)
| remove_class:      | ""          | Classes to be removed from the default class list
| **props            |             | Additional HTML attributes

## Slots

This component does not define any named slots. The avatar content is determined by the `src`, `placeholder_initials`, or displays a default user icon.

## Examples

### Default avatars with images

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="with_images" panels="source"></lookbook-embed>

### Placeholder avatars with initials

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="with_initials" panels="source"></lookbook-embed>

### Default placeholder icons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="placeholder_icons" panels="source"></lookbook-embed>

### Avatar sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="avatar_sizes" panels="source"></lookbook-embed>

### Avatars with status indicators

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="with_status" panels="source"></lookbook-embed>

### Avatars with colored borders

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="with_borders" panels="source"></lookbook-embed>

### Square avatars

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="square_avatars" panels="source"></lookbook-embed>

### Status indicator positions

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="status_positions" panels="source"></lookbook-embed>

### Avatar groups (stacked)

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="avatar_group" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_avatar_component_defaults.rb

Fluxbit::Config::AvatarComponent.color = :info # the default is nil
Fluxbit::Config::AvatarComponent.rounded = false # the default is true
Fluxbit::Config::AvatarComponent.size = :lg # the default is :md
Fluxbit::Config::AvatarComponent.status = :online # the default is false
Fluxbit::Config::AvatarComponent.status_position = :bottom_right # the default is :top_right
Fluxbit::Config::AvatarComponent.styles[:size][:xxl] = 'size-48' # add custom size
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::AvatarComponent.styles)) %>
```

## References

[Flowbite Avatars](https://flowbite.com/docs/components/avatar/)