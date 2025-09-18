---
label: Accordion
title: Fluxbit::AccordionComponent or fx_accordion
---

The `Fluxbit::AccordionComponent` is a customizable accordion component that extends `Fluxbit::Component`.
It allows you to create collapsible content panels with headers and content areas, supporting various behaviors like single-panel-open or multiple-panels-open modes.

To start using the accordion you can use the default way to call the component:

```html
&lt;%= render Fluxbit::AccordionComponent.new do |accordion| %&gt;
  &lt;% accordion.with_panel(open: true, index: 0) do |panel| %&gt;
    &lt;% panel.with_header { "What is Flowbite?" } %&gt;
    &lt;% panel.with_body do %&gt;
      &lt;p&gt;Flowbite is an open-source library of interactive components built on top of Tailwind CSS.&lt;/p&gt;
    &lt;% end %&gt;
  &lt;% end %&gt;

  &lt;% accordion.with_panel(index: 1) do |panel| %&gt;
    &lt;% panel.with_header { "Is there a Figma file available?" } %&gt;
    &lt;% panel.with_body do %&gt;
      &lt;p&gt;Yes, Flowbite has a Figma design system available.&lt;/p&gt;
    &lt;% end %&gt;
  &lt;% end %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_accordion do |accordion| %&gt;
  &lt;% accordion.with_panel(open: true, index: 0) do |panel| %&gt;
    &lt;% panel.with_header { "What is Flowbite?" } %&gt;
    &lt;% panel.with_body do %&gt;
      &lt;p&gt;Flowbite is an open-source library of interactive components built on top of Tailwind CSS.&lt;/p&gt;
    &lt;% end %&gt;
  &lt;% end %&gt;

  &lt;% accordion.with_panel(index: 1) do |panel| %&gt;
    &lt;% panel.with_header { "Is there a Figma file available?" } %&gt;
    &lt;% panel.with_body do %&gt;
      &lt;p&gt;Yes, Flowbite has a Figma design system available.&lt;/p&gt;
    &lt;% end %&gt;
  &lt;% end %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AccordionComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| flush:             | false    | Whether to remove outer borders and rounded corners.
| color:             | :default | Sets the color scheme of the accordion (:default, :light, :primary, :secondary, :success, :danger, :warning, :info, :dark).
| collapse_all:      | false    | Whether only one panel can be open at a time (true) or multiple panels can be open (false).
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Additional HTML attributes.

## Panel Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| open:              | false    | Whether the panel is initially open.
| index:             | required | The index of the panel (used for generating unique IDs).

## Slots

The component supports the following slots:

### Accordion Slots
- `with_panel`: Add accordion panels. Each panel accepts `open` and `index` parameters.

### Panel Slots
- `with_header`: Add header content for the panel (typically the clickable title).
- `with_body`: Add collapsible content for the panel.

## Examples

### Basic accordion

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AccordionComponentPreview" scenario="basic_accordion" panels="source"></lookbook-embed>

### Flush accordion

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AccordionComponentPreview" scenario="flush_accordion" panels="source"></lookbook-embed>

### Collapse all behavior

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AccordionComponentPreview" scenario="collapse_all" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AccordionComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::AccordionComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## Behavior

The accordion component generates unique IDs for each panel to ensure proper ARIA relationships and JavaScript functionality. The component follows these patterns:

- **Accordion ID**: Generated automatically using the component's `fx_id` method
- **Panel IDs**: `{accordion_id}-panel-{index}`
- **Header IDs**: `{accordion_id}-header-{index}`
- **Content IDs**: `{accordion_id}-content-{index}`

### Accessibility

The component includes proper ARIA attributes for accessibility:

- `aria-expanded`: Indicates whether a panel is open or closed
- `aria-controls`: Links the button to the content it controls
- `aria-labelledby`: Links the content to the header that labels it
- `data-accordion-target`: Used by JavaScript for panel toggling

### JavaScript Integration

The accordion requires JavaScript to handle the expand/collapse behavior. The component includes the necessary data attributes for integration with Flowbite's JavaScript or custom implementations:

- `data-accordion="open"`: Allows multiple panels to be open simultaneously
- `data-accordion="collapse"`: Only allows one panel to be open at a time
- `data-accordion-target`: Specifies which content panel a button controls

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_accordion_component_defaults.rb

Fluxbit::AccordionComponent.styles[:base] = "space-y-4" # the default is "space-y-2"
Fluxbit::AccordionComponent.styles[:item][:header][:base] = "custom-header-style"
Fluxbit::AccordionComponent.styles[:item][:content][:base] = "custom-content-style"
Fluxbit::AccordionComponent.styles[:colors][:default][:header] = "bg-gray-100 dark:bg-gray-700"
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling and JavaScript behavior.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::AccordionComponent.styles)) %>
```

## References

[Flowbite Accordion](https://flowbite.com/docs/components/accordion/)