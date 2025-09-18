---
label: Banner
title: Fluxbit::BannerComponent or fx_banner
---

The `Fluxbit::BannerComponent` is a customizable banner component that extends `Fluxbit::Component`.
It provides various options to display important information or announcements to users with different styles, positions, and interactive elements such as close functionality and call-to-action buttons.

To start using the banner component you can use the default way to call the component:

```html
&lt;%= render Fluxbit::BannerComponent.new(color: :info).with_content('Banner message') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::BannerComponent.new(color: :info) do %&gt;
    Banner message
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_banner(color: :info).with_content('Banner message') %&gt;

&lt;!-- or --&gt;

&lt;%= fx_banner(color: :info) do %&gt;
    Banner message
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param        | Default | Description
|:-------------|:--------|:------------
| position:    | :top    | Sets the position of the banner (`:top`, `:bottom`, `:sticky_top`, `:sticky_bottom`).
| color:       | :info   | Sets the color scheme of the component.
| icon:        | :default| Icon to be displayed (`:default` for default icon based on color, `false` to omit).
| dismissible: | true    | Adds a close/dismiss button.
| full_width:  | true    | Determines if the banner spans the full width or uses constrained layout.
| class_icon:  | nil     | Custom class styles to icon element.
| remove_class:| ""      | Classes to be removed from the default class list.
| **props      |         | Additional HTML attributes.

## Slots

| Slot        | Description
|:------------|:------------
| cta_button  | Optional call-to-action button using `Fluxbit::ButtonComponent`.
| logo        | Optional logo image element.

## Examples

### Default banner

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="default_banner" panels="source"></lookbook-embed>

### Sticky banners

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="sticky_banners" panels="source"></lookbook-embed>

### Marketing banner

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="marketing_banner" panels="source"></lookbook-embed>

### Newsletter signup banner

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="newsletter_banner" panels="source"></lookbook-embed>

### Informational banner

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="informational_banner" panels="source"></lookbook-embed>

### Banner colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="banner_colors" panels="source"></lookbook-embed>

### Banner without icon

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="banner_without_icon" panels="source"></lookbook-embed>

### Banner with call-to-action

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="banner_with_cta" panels="source"></lookbook-embed>

### Banner with logo

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="banner_with_logo" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BannerComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Usage with slots

You can use the banner component with CTA buttons and logos:

```erb
&lt;%= fx_banner(color: :primary, icon: false) do |banner| %&gt;
  &lt;% banner.with_logo(src: "logo.svg", alt: "Company Logo", class: "h-6") %&gt;
  &lt;strong&gt;Special Offer!&lt;/strong&gt; Get 50% off your first order.
  &lt;% banner.with_cta_button(href: "/offer", color: :primary, size: 1) do %&gt;
    Claim Now
  &lt;% end %&gt;
&lt;% end %&gt;
```

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_banner_component_defaults.rb

Fluxbit::Config::BannerComponent.position = :sticky_top # the default is :top
Fluxbit::Config::BannerComponent.color = :warning # the default is :info
Fluxbit::Config::BannerComponent.icon = false # the default is :default
Fluxbit::Config::BannerComponent.dismissible = false # the default is true
Fluxbit::Config::BannerComponent.full_width = false # the default is true
Fluxbit::Config::BannerComponent.styles[:colors][:custom] = 'bg-purple-50 text-purple-800 border-purple-200'

```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
  <%= html_escape(JSON.pretty_generate(Fluxbit::Config::BannerComponent.styles)) %>
```

## References

[Flowbite Banner](https://flowbite.com/docs/components/banner/)