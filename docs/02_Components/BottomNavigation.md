---
label: BottomNavigation
title: Fluxbit::BottomNavigationComponent or fx_bottom_navigation
---

The `Fluxbit::BottomNavigationComponent` is a customizable bottom navigation component that extends `Fluxbit::Component`.
It allows you to create fixed bottom navigation bars with multiple menu items, icons, and text labels, perfect for mobile applications.

To start using the bottom navigation you can use the default way to call the component:

```html
&lt;%= render Fluxbit::BottomNavigationComponent.new do |nav| %&gt;
  &lt;% nav.with_item(href: "/", icon: "heroicons_solid:home") { "Home" } %&gt;
  &lt;% nav.with_item(href: "/wallet", icon: "heroicons_solid:wallet") { "Wallet" } %&gt;
  &lt;% nav.with_item(href: "/settings", icon: "heroicons_solid:cog-6-tooth") { "Settings" } %&gt;
  &lt;% nav.with_item(href: "/profile", icon: "heroicons_solid:user") { "Profile" } %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_bottom_navigation do |nav| %&gt;
  &lt;% nav.with_item(href: "/", icon: "heroicons_solid:home") { "Home" } %&gt;
  &lt;% nav.with_item(href: "/wallet", icon: "heroicons_solid:wallet") { "Wallet" } %&gt;
  &lt;% nav.with_item(href: "/settings", icon: "heroicons_solid:cog-6-tooth") { "Settings" } %&gt;
  &lt;% nav.with_item(href: "/profile", icon: "heroicons_solid:user") { "Profile" } %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:-----------
| variant:           | :default | The style variant (`:default` or `:app_bar`). App bar variant features rounded design and centered CTA support.
| border:            | true     | Shows a border at the top of the navigation bar (default variant only).
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

**Note:** The number of grid columns is automatically calculated based on the number of items. A CTA counts as 1 additional column, while pagination spans 2 columns.

### Item Options

| Param              | Default  | Description
|:-------------------|:---------|:-----------
| href:              | "#"      | The URL the navigation item links to.
| icon:              | nil      | Icon to display above the text (uses Anyicon format).
| active:            | false    | Whether the item is currently active.
| tooltip_text:      | nil      | Tooltip text to display on hover.
| sr_only:           | false    | Show text for screen readers only (automatically enabled for app_bar variant).
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

### CTA Options

| Param              | Default  | Description
|:-------------------|:---------|:-----------
| href:              | "#"      | The URL the CTA button links to.
| icon:              | nil      | Icon to display in the button (uses Anyicon format).
| tooltip_text:      | nil      | Tooltip text to display on hover.
| **props            |          | Additional HTML attributes.

### Pagination Options

| Param              | Default     | Description
|:-------------------|:------------|:-----------
| current_page:      | 1           | The current page number.
| total_pages:       | 1           | The total number of pages.
| previous_href:     | "#"         | The URL for the previous page.
| next_href:         | "#"         | The URL for the next page.
| previous_label:    | "Previous"  | The label for the previous button (screen reader only).
| next_label:        | "Next"      | The label for the next button (screen reader only).

### ButtonGroup Options

| Param              | Default     | Description
|:-------------------|:------------|:-----------
| columns:           | 3           | Number of columns for button grid (2 to 5).

### Button Options (ButtonGroup)

| Param              | Default  | Description
|:-------------------|:---------|:-----------
| href:              | "#"      | The URL the button links to.
| active:            | false    | Whether the button is currently active.
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

## Slots

The component supports the following slots:

- **with_item**: Add navigation items with href, icon, and text content.
- **with_cta**: Add a centered call-to-action button (works with all variants).
- **with_pagination**: Add pagination controls with previous/next buttons and page counter (spans 2 columns).
- **with_button_group**: Add a segmented button group at the top of the navigation (similar to Flowbite's button group bottom bar example).

## Examples

### Default Bottom Navigation

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Application Bar Variant

The app bar variant features a rounded design with centered CTA button and tooltips, perfect for mobile applications:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="app_bar_variant" panels="source"></lookbook-embed>

### With Tooltips

Add helpful tooltips to navigation items:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="with_tooltips" panels="source"></lookbook-embed>

### Without Border

Remove the top border for a cleaner look:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="without_border" panels="source"></lookbook-embed>

### Three Columns Layout

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="three_columns" panels="source"></lookbook-embed>

### Five Columns Layout

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="five_columns" panels="source"></lookbook-embed>

### With Active Item

Highlight the currently active navigation item:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="with_active_item" panels="source"></lookbook-embed>

### Without Icons

Use text-only navigation items:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="without_icons" panels="source"></lookbook-embed>

### With Pagination

Add pagination controls to navigate through pages:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="with_pagination" panels="source"></lookbook-embed>

### Button Group Bottom Bar

Create a segmented button group at the top of the navigation, similar to Flowbite's example. Perfect for content filters or tab-like navigation:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="button_group_bottom_bar" panels="source"></lookbook-embed>

### Meeting Control Bar

A clean control bar layout perfect for video conferencing or media controls:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="meeting_control_bar" panels="source"></lookbook-embed>

### Adding/Removing Classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding Other Properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::BottomNavigationComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_bottom_navigation_component_defaults.rb

Fluxbit::Config::BottomNavigationComponent.variant = :app_bar # default is :default
Fluxbit::Config::BottomNavigationComponent.border = false      # default is true
Fluxbit::Config::BottomNavigationComponent.styles[:variants][:default][:base] = 'fixed bottom-0 left-0 z-50 w-full h-20 bg-white dark:bg-gray-700' # Change height
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::BottomNavigationComponent.styles)) %>
```

## References

- [Flowbite Bottom Navigation](https://flowbite.com/docs/components/bottom-navigation/)
