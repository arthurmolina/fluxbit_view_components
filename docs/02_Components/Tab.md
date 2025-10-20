---
label: Tab
title: Fluxbit::TabComponent or fx_tab
---

The `Fluxbit::TabComponent` is a customizable tab component that extends `Fluxbit::Component`.
It allows you to create tabbed interfaces with multiple variants, colors, and orientations, supporting both standalone tab navigation and full tabbed content panels.

To start using the tab you can use the default way to call the component:

```html
&lt;%= render Fluxbit::TabComponent.new do |tabs| %&gt;
  &lt;%= tabs.with_tab title: "Tab 1", active: true do %&gt;
    Tab 1 content
  &lt;% end %&gt;
  &lt;%= tabs.with_tab title: "Tab 2" do %&gt;
    Tab 2 content  
  &lt;% end %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_tab do |tabs| %&gt;
  &lt;%= tabs.with_tab title: "Tab 1", active: true do %&gt;
    Tab 1 content
  &lt;% end %&gt;
  &lt;%= tabs.with_tab title: "Tab 2" do %&gt;
    Tab 2 content
  &lt;% end %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| variant:           | :default | Tab variant style (`:default`, `:underline`, `:pills`, `:full_width`).
| color:             | :blue    | Color theme for active tabs (`:blue`, `:cyan`, `:green`, `:indigo`, `:pink`, `:purple`, `:red`, `:yellow`, `:gray`).
| vertical:          | false    | Display tabs vertically instead of horizontally.
| align:             | :left    | Horizontal alignment of tabs (`:left`, `:center`, `:right`). Only applies to horizontal tabs.
| tab_panel:         | :default | Panel styling variant (`:default`, `:hidden`).
| ul_html:           | {}       | Additional HTML attributes for the tab list container.
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

## Slots

The component supports the following slots:

- `with_tab`: Add individual tab items. Each tab supports:
  - `title`: Tab label text (required)
  - `active`: Whether the tab is initially active (boolean)
  - `disabled`: Whether the tab is disabled (boolean)
  - `icon`: Icon to display alongside the title
  - `content_html`: HTML attributes for the tab panel content
  - `li_html`: HTML attributes for the tab list item

## Examples

### Basic tabs

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="basic_tabs" panels="source"></lookbook-embed>

### Underline tabs

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="underline_tabs" panels="source"></lookbook-embed>

### Pills tabs

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="pills_tabs" panels="source"></lookbook-embed>

### Full width tabs

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="full_width_tabs" panels="source"></lookbook-embed>

### Vertical tabs

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="vertical_tabs" panels="source"></lookbook-embed>

### Tabs with icons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="tabs_with_icons" panels="source"></lookbook-embed>

### Different colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="colored_tabs" panels="source"></lookbook-embed>

### Tabs without panels

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="navigation_only" panels="source"></lookbook-embed>

### Disabled tabs

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="disabled_tabs" panels="source"></lookbook-embed>

### Tab alignment

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="tab_alignment" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TabComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_tab_component_defaults.rb

Fluxbit::Config::TabComponent.variant = :underline # the default is :default
Fluxbit::Config::TabComponent.color = :green # the default is :blue
Fluxbit::Config::TabComponent.vertical = false # the default is false
Fluxbit::Config::TabComponent.align = :center # the default is :left
Fluxbit::Config::TabComponent.tab_panel = :default # the default is :default
Fluxbit::Config::TabComponent.styles[:tab_list][:variant][:custom] = 'custom-tab-styling' # Custom variant
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering tab icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for tab switching functionality.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::TabComponent.styles)) %>
```

## References

[Flowbite Tabs](https://flowbite.com/docs/components/tabs/)