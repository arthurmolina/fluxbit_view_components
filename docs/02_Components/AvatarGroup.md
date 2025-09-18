---
label: AvatarGroup
title: Fluxbit::AvatarGroupComponent or fx_avatar_group
---

The `Fluxbit::AvatarGroupComponent` is a component for rendering a group of avatars that extends `Fluxbit::Component`.
It allows you to display multiple avatars and gravatars in a stacked or overlapping layout, commonly used for showing team members, participants, or contributors.

To start using the avatar group you can use the default way to call the component:

```html
&lt;%= render Fluxbit::AvatarGroupComponent.new do |group| %&gt;
  &lt;%= group.with_avatar(placeholder_initials: "AM") %&gt;
  &lt;%= group.with_avatar(placeholder_initials: "FX") %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_avatar_group do |group| %&gt;
  &lt;%= group.with_avatar(placeholder_initials: "AM") %&gt;
  &lt;%= group.with_avatar(placeholder_initials: "FX") %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

The AvatarGroupComponent itself doesn't take specific parameters, but the avatars within the group inherit all avatar configuration options:

| Param              | Default  | Description
|:-------------------|:---------|:------------
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes for the group container.

### Avatar Options (for each avatar in the group)

| Param              | Default    | Description
|:-------------------|:-----------|:------------
| color:             | nil        | Sets the border color of the avatar (:dark, :danger, :gray, :info, :light, :purple, :success, :warning, :pink).
| placeholder_initials: | false   | Text initials to display when no image is provided.
| status:            | false      | Status indicator (:online, :busy, :offline, :away).
| status_position:   | :top_right | Position of the status indicator (:top_right, :top_left, :bottom_right, :bottom_left).
| rounded:           | true       | Whether the avatar has rounded corners.
| size:              | :md        | Size of the avatar (:xs, :sm, :md, :lg, :xl).
| src:               | nil        | Image source URL for the avatar.
| alt:               | ""         | Alt text for the avatar image.
| **props            |            | Additional HTML attributes for individual avatars.

## Slots

The component supports the following slots:

- `with_avatar`: Add avatar components with all avatar options (color, size, initials, etc.).
- `with_gravatar`: Add gravatar components with gravatar-specific options.

## Examples

### Basic avatar group

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="basic_group" panels="source"></lookbook-embed>

### Avatar group with different colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="colored_group" panels="source"></lookbook-embed>

### Avatar group with different sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="sized_group" panels="source"></lookbook-embed>

### Avatar group with images

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="image_group" panels="source"></lookbook-embed>

### Gravatar group

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="gravatar_group" panels="source"></lookbook-embed>

### Mixed avatars and gravatars

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="mixed_group" panels="source"></lookbook-embed>

### Avatar group with status indicators

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="status_group" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AvatarGroupComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_avatar_component_defaults.rb

Fluxbit::Config::AvatarComponent.size = :lg # the default is :md
Fluxbit::Config::AvatarComponent.rounded = false # the default is true
Fluxbit::Config::AvatarComponent.status_position = :bottom_right # the default is :top_right
Fluxbit::Config::AvatarComponent.styles[:group] = "flex -space-x-2 rtl:space-x-reverse" # customize group spacing
Fluxbit::Config::AvatarComponent.styles[:stacked] = "ring-4 ring-white dark:ring-gray-800" # customize stacking ring
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering avatar placeholder icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::AvatarComponent.styles)) %>
```

## References

[Flowbite Avatar Groups](https://flowbite.com/docs/components/avatar/)