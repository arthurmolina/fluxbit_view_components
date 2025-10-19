---
label: Gravatar
title: Fluxbit::GravatarComponent or fx_gravatar
---

The `Fluxbit::GravatarComponent` is a customizable Gravatar avatar component that extends `Fluxbit::AvatarComponent`.
It allows you to display user avatars from Gravatar service with various styles, sizes, colors, and status indicators. The component automatically constructs Gravatar URLs based on email addresses and supports features like different rating levels, file types, and fallback options.

To start using the gravatar you can use the default way to call the component:

```html
&lt;%= render Fluxbit::GravatarComponent.new(email: "user@example.com").with_content('') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::GravatarComponent.new(email: "user@example.com") do %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_gravatar(email: "user@example.com") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_gravatar(email: "user@example.com") do %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param              | Default     | Description
|:-------------------|:------------|:------------
| email:             |             | The email address associated with the Gravatar
| rating:            | :pg         | The rating of the Gravatar (`:g`, `:pg`, `:r`, `:x`)
| secure:            | true        | Whether to use HTTPS for the Gravatar URL
| filetype:          | :png        | The filetype of the Gravatar (`:png`, `:jpg`, `:gif`)
| default:           | :robohash   | The default image to use if no Gravatar is found (`:identicon`, `:monsterid`, `:wavatar`, `:retro`, `:robohash`, `:mp`, `:404`, `:blank`)
| url_only:          | false       | If true, returns only the Gravatar URL string instead of rendering the avatar component
| color:             | nil         | Border color (`:dark`, `:danger`, `:gray`, `:info`, `:light`, `:purple`, `:success`, `:warning`, `:pink`)
| status:            | false       | Status indicator (`:online`, `:busy`, `:offline`, `:away`)
| status_position:   | :top_right  | Position of status indicator (`:top_left`, `:top_right`, `:bottom_left`, `:bottom_right`)
| rounded:           | true        | Whether avatar should be circular (true) or square with rounded corners (false)
| size:              | :md         | Size of avatar (`:xs`, `:sm`, `:md`, `:lg`, `:xl`)
| remove_class:      | ""          | Classes to be removed from the default class list
| **props            |             | Additional HTML attributes

## Slots

This component does not define any named slots. The Gravatar content is automatically generated based on the email address and Gravatar service response.

## Examples

### Default Gravatars

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="default_gravatars" panels="source"></lookbook-embed>

### Different rating levels

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="rating_levels" panels="source"></lookbook-embed>

### Different file types

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="file_types" panels="source"></lookbook-embed>

### Default fallback options

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="default_fallbacks" panels="source"></lookbook-embed>

### Gravatar sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="gravatar_sizes" panels="source"></lookbook-embed>

### Gravatars with status indicators

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="with_status" panels="source"></lookbook-embed>

### Gravatars with colored borders

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="with_borders" panels="source"></lookbook-embed>

### Square Gravatars

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="square_gravatars" panels="source"></lookbook-embed>

### Secure vs non-secure URLs

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="secure_urls" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::GravatarComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

### URL only mode

When you need just the Gravatar URL without rendering the avatar component, you can use the `url_only` option:

```erb
<%= fx_gravatar(email: "user@example.com", url_only: true) %>
<!-- Returns: "https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af.png?d=robohash&r=pg&s=40" -->

<!-- Use it in your own custom markup -->
<img src="<%= fx_gravatar(email: "user@example.com", url_only: true, size: :lg) %>" alt="Avatar" class="my-custom-class" />
```

This is useful when you want to use the Gravatar URL in custom components or pass it to JavaScript.

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_gravatar_component_defaults.rb

Fluxbit::Config::GravatarComponent.rating = :g # the default is :pg
Fluxbit::Config::GravatarComponent.filetype = :jpg # the default is :png
Fluxbit::Config::GravatarComponent.default = :identicon # the default is :robohash
Fluxbit::Config::GravatarComponent.gravatar_styles[:base] = "bg-blue-200 dark:bg-blue-600" # customize base styling
```

## Dependencies

- [**Gravatar Service**](https://gravatar.com/): External service for avatar images
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::GravatarComponent.gravatar_styles)) %>
```

## References

- [Gravatar Documentation](https://gravatar.com/site/implement/)
- [Flowbite Avatars](https://flowbite.com/docs/components/avatar/)