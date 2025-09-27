---
label: Timeline
title: Fluxbit::TimelineComponent or fx_timeline
---

The `Fluxbit::TimelineComponent` is a customizable timeline component that extends `Fluxbit::Component`.
It allows you to create chronological sequences of events, activities, or steps with support for multiple variants including default, vertical, stepper, and activity timelines with customizable positioning and styling.

To start using the timeline you can use the default way to call the component:

```html
&lt;%= render Fluxbit::TimelineComponent.new do |timeline| %&gt;
  &lt;%= timeline.with_item(
    title: "Application UI code in Tailwind CSS",
    description: "Get access to over 20+ free and open source activity examples built with the utility classes from Tailwind CSS and Flowbite.",
    date: "February 2022"
  ) %&gt;
  &lt;%= timeline.with_item(
    title: "Marketing UI design in Figma",
    description: "All of the pages and components are first designed in Figma and we keep a parity between the two versions even as we update the project.",
    date: "March 2022"
  ) %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_timeline do |timeline| %&gt;
  &lt;%= timeline.with_item(
    title: "Application UI code in Tailwind CSS",
    description: "Get access to over 20+ free and open source activity examples built with the utility classes from Tailwind CSS and Flowbite.",
    date: "February 2022"
  ) %&gt;
  &lt;%= timeline.with_item(
    title: "Marketing UI design in Figma",
    description: "All of the pages and components are first designed in Figma and we keep a parity between the two versions even as we update the project.",
    date: "March 2022"
  ) %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default    | Description
|:-------------------|:-----------|:------------
| variant:           | :default   | Timeline style (:default, :vertical, :stepper, :activity).
| position:          | :left      | Timeline position (:left, :center, :right).
| remove_class:      | ""         | Classes to be removed from the default class list.
| **props            |            | Additional HTML attributes.

## Slots

The component supports the following slots:

- `with_item`: Add timeline items with customizable properties including title, description, date, icon, status, color, and more.

### Timeline Item Options

| Param              | Default    | Description
|:-------------------|:-----------|:------------
| title:             | nil        | The title of the timeline item.
| description:       | nil        | The description text for the item.
| date:              | nil        | Date or time information for the item.
| icon:              | nil        | Icon name (Heroicons format) to display in the timeline indicator.
| status:            | :default   | Item status (:default, :completed, :current, :pending).
| color:             | :blue      | Color theme (:blue, :green, :red, :yellow, :purple, :indigo).
| href:              | nil        | URL to make the item clickable.
| ring:              | :default   | Ring size around indicator (:none, :small, :default, :large).
| remove_class:      | ""         | Classes to be removed from the default class list.
| **props            |            | Additional HTML attributes.

## Examples

### Default timeline

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="default_timeline" panels="source"></lookbook-embed>

### Vertical timeline

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="vertical_timeline" panels="source"></lookbook-embed>

### Stepper timeline

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="stepper_timeline" panels="source"></lookbook-embed>

### Activity timeline

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="activity_timeline" panels="source"></lookbook-embed>

### Timeline with icons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="with_icons" panels="source"></lookbook-embed>

### Timeline item status

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="item_status" panels="source"></lookbook-embed>

### Timeline colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="colors" panels="source"></lookbook-embed>

### Clickable items

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="clickable_items" panels="source"></lookbook-embed>

### Timeline positioning

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="positioning" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::TimelineComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_timeline_component_defaults.rb

Fluxbit::Config::TimelineComponent.variant = :vertical # the default is :default
Fluxbit::Config::TimelineComponent.position = :center # the default is :left
Fluxbit::Config::TimelineComponent.styles[:base] = 'relative custom-timeline' # the default is 'relative'
Fluxbit::Config::TimelineComponent.styles[:variants][:default] = 'space-y-6 border-l-2 border-blue-200' # customize default variant
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::TimelineComponent.styles)) %>
```

## References

[Flowbite Timeline](https://flowbite.com/docs/components/timeline/)