---
label: Popover
title: Fluxbit::PopoverComponent or fx_popover
---

The `Fluxbit::PopoverComponent` is a component for rendering customizable popovers. It extends `Fluxbit::Component` and provides options for configuring the popover's appearance, behavior, and content areas. You can control the popover's trigger, placement, and other interactive elements. The popover is divided into different sections (trigger and content), each of which can be styled or customized through various properties.

To start using the popover, you can use the default way to call the component:

```html
&lt;%= render Fluxbit::PopoverComponent.new(title: "A Title") do %&gt;
  Content
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_popover(title: "A Title") do %&gt;
  Content
&lt;% end %&gt;
```

The result look like this:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PopoverComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param           | Default| Description
|:----------------|:-------|:-----------
| title:          | nil    | The title text displayed in the popover.
| has_arrown:     | true   | Determines if an arrow should be displayed on the popover.
| image:          | nil    | he URL of an image to be displayed in the popover.
| image_position: | :right | The position of the image relative to the content (:left or :right).
| image_props:    | {}     | Additional HTML attributes for the image element.
| size:           | 1      | The size of the popover, corresponding to predefined Tailwind classes (e.g., `0` to  <%=Fluxbit::Config::PopoverComponent.styles[:size].count - 1 %>).
| remove_class:   | ""     | Classes to be removed from the default popover class list.
| **props         |        | Remaining options declared as HTML attributes, applied to the outer popover container.

## Examples

### Default Popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PopoverComponentPreview" scenario="default_popover" panels="source"></lookbook-embed>

### Image Popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PopoverComponentPreview" scenario="image_popover" panels="source"></lookbook-embed>

### User profile example

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PopoverComponentPreview" scenario="user_profile" panels="source"></lookbook-embed>


## Customization

You can customize the appearance and behavior of the popover component by modifying the `styles` and `classes` options in the `Fluxbit::Config::PopoverComponent` module.

Here's an example of how you can customize the popover component:

```ruby
# config/initializers/fluxbit.rb

Fluxbit::Config::PopoverComponent.styles[:size] = 1
Fluxbit::Config::PopoverComponent.styles[:has_arrow] = false
Fluxbit::Config::PopoverComponent.styles[:image_position] = :left

Fluxbit::Config::PopoverComponent.classes[:base] = "fixed inset-x-0 top-0 h-screen overflow-y-auto overflow-x-hidden md:inset-0 md:h-full flex"
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling, including the backdrop and default classes.

## Styles

To view the current styles configuration for the `Fluxbit::PopoverComponent`, you can inspect:

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::PopoverComponent.styles)) %>
```

which will output a JSON representation of the default style mappings.

## References

[Flowbite Modals](https://flowbite.com/docs/components/popover/)
