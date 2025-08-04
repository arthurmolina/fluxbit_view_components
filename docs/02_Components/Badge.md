---
label: Badge
title: Fluxbit::BadgeComponent or fx_badge
---

The `Fluxbit::BadgeComponent` is a customizable badge component that extends `Fluxbit::Component`.  
It allows you to create badges with different colors, sizes, borders, shapes (pill), and includes support for popovers and tooltips.

To start using the badge, you can use the default way to call the component:

```html
&lt;%= render Fluxbit::BadgeComponent.new.with_content("I'm a badge!") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::BadgeComponent.new do %&gt;
  I'm a badge!
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_badge(with_content: "I'm a badge!") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_badge do %&gt;
  I'm a badge!
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="default" panels="params,source"></lookbook-embed>


## Options

| Param              | Default  | Description
|:-------------------|:---------|:-----------
| color:             | :default | Sets the color of the badge (e.g., `:default`, `:danger`, `:success`, etc.), which corresponds to predefined styles.
| pill:              | false    | If set to `true`, the badge will have a "pill" shape (fully rounded edges).
| size:              | 0        | Defines the size of the badge (0 to <%=Fluxbit::Config::BadgeComponent.styles[:sizes].count - 1 %>).
| perfect_rounded:   | 0        | If set to something other than `0` (e.g., 0 to <%=Fluxbit::Config::BadgeComponent.styles[:perfect_rounded].count - 1 %>), the badge becomes a perfectly rounded shape sized accordingly.
| as:                | :span    | The HTML element tag to use for the badge (e.g., `:span`, `:div`, etc.).
| remove_class:      | ""       | Classes to be removed from the default badge class list.
| popover_text:      | nil      | Text to display in a popover (from `Fluxbit::Component`).
| popover_placement: | :right   | Placement of the popover (e.g., `:right`, `:left`, `:top`, `:bottom`).
| popover_trigger:   | :hover   | Popover trigger (`:hover` or `:click`).
| tooltip_text:      | nil      | Text to display in a tooltip (from `Fluxbit::Component`).
| tooltip_placement: | :right   | Placement of the tooltip (e.g., `:right`, `:left`, `:top`, `:bottom`).
| tooltip_trigger:   | :hover   | Tooltip trigger (`:hover` or `:click`).
| **props            |          | Additional HTML attributes applied to the badge element.

## Slots

The component supports the following slots:

- **with_popover**: Add popover content (title and/or text) with markup.
- **with_tooltip**: Add tooltip content with markup.

## Examples

### Default Badges

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="default_badges" panels="source"></lookbook-embed>

### Pill Badges

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="badge_pills" panels="source"></lookbook-embed>

### Different Sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="badge_sizes" panels="source"></lookbook-embed>

### Badge link

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="badge_link" panels="source"></lookbook-embed>

### Badge with icon

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="badge_with_icon" panels="source"></lookbook-embed>

### Badge with icon only

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="badge_with_icon_only" panels="source"></lookbook-embed>

### Notification Badge

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="notification_badge" panels="source"></lookbook-embed>

### Button with badge

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="button_with_badge" panels="source"></lookbook-embed>

### Dismissible badges

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="dismissible_badges" panels="source"></lookbook-embed>

### With Popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="with_popover" panels="source"></lookbook-embed>

### With Tooltip

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="with_tooltip" panels="source"></lookbook-embed>

### Adding/Removing Classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding Other Properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BadgeComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>


## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters or adding custom styles.  
You can also set global defaults or override existing styles in an initializer. For example:

```ruby
# /config/initializers/change_badge_component_defaults.rb

Fluxbit::Config::BadgeComponent.color = :success       # default is :default
Fluxbit::Config::BadgeComponent.pill = true            # default is false
Fluxbit::Config::BadgeComponent.size = 1               # default is 0
Fluxbit::Config::BadgeComponent.as = :div              # default is :span
Fluxbit::Config::BadgeComponent.styles[:custom_style] = 'bg-pink-200'  # Add or override custom styles
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.


## Styles

To view the current styles configuration for the `Fluxbit::BadgeComponent`, you can inspect it as JSON:

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::BadgeComponent.styles)) %>
```

This will output a JSON representation of the default style mappings for the Badge component.

## References

[Flowbite Badges](https://flowbite.com/docs/components/badge/)
