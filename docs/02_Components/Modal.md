---
label: Modal
title: Fluxbit::ModalComponent or fx_modal
---

The `Fluxbit::ModalComponent` is a component for rendering customizable modals. It extends `Fluxbit::Component` and provides options for configuring the modal's appearance, behavior, and content areas. You can control the modal's title, size, placement, backdrop behavior, and other interactive elements. The modal is divided into different sections (header, content, and footer), each of which can be styled or customized through various properties.

To start using the modal, you can use the default way to call the component:

```html
&lt;%= render Fluxbit::ModalComponent.new(title: "My Modal", opened: true) do %&gt;
  &lt;p>Your modal content goes here.&lt;/p&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_modal(title: "My Modal", opened: true) do %&gt;
  &lt;p&gt;Your modal content goes here.&lt;/p&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ModalComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param              | Default   | Description
|:-------------------|:----------|:-----------
| title:             | nil       | The title text displayed in the modal header.
| opened:            | false     | Determines if the modal is initially open (visible).
| close_button:      | true      | Determines if a close button should be displayed in the header.
| flat:              | false     | Applies a "flat" style for the header and footer (removes border lines, etc.).
| size:              | 1         | The size of the modal, corresponding to predefined Tailwind classes (e.g., `0` to  <%=Fluxbit::Config::ModalComponent.styles[:root][:size].count - 1 %>).
| placement:         | nil       | The placement of the modal (e.g., `:center`, `:top`, `:bottom`). When set, it adds `data-modal-placement="<placement>"` to the outer container.
| only_css:          | false     | If `true`, a button to open isn't obligatory.
| static:            | false     | If `true`, the modal will not close when clicking the backdrop or pressing the ESC key (i.e., it’s “static”).
| remove_class:      | ""        | Classes to be removed from the default modal class list.
| content_html:      | {}        | Additional HTML attributes for the content wrapper (the inner container of the modal).
| header_html:       | {}        | Additional HTML attributes for the header section.
| footer_html:       | {}        | Additional HTML attributes for the footer section.
| close_button_html: | {}        | Additional HTML attributes for the close button.
| **props            |           | Remaining options declared as HTML attributes, applied to the outer modal container.

## Slots

The component supports the following slots:

- **with_title** (or simply `title`): Renders a slot for the modal title.
- **with_footer** (or simply `footer`): Renders a slot for the modal footer.

> **Note:** If you set `title:` via the constructor and also provide `with_title` block content, both will appear unless you handle that manually. Typically, you’d choose one approach.

## Examples

### Default Modal

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ModalComponentPreview" scenario="default_modal" panels="source"></lookbook-embed>

### Modal with slots Title and Footer

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ModalComponentPreview" scenario="with_title_and_footer" panels="source"></lookbook-embed>

### Modal placements

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ModalComponentPreview" scenario="placements" panels="source"></lookbook-embed>

### Modal sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ModalComponentPreview" scenario="sizes" panels="source"></lookbook-embed>

### Flat Modal

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ModalComponentPreview" scenario="flat" panels="source"></lookbook-embed>

### Static (Non-closable) Modal

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ModalComponentPreview" scenario="static" panels="source"></lookbook-embed>

### Backdrop-close (CSS-only) Modal

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ModalComponentPreview" scenario="only_css" panels="source"></lookbook-embed>

### Adding/Removing Classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ModalComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters or adding custom styles. For a more global customization, you could update or override the component’s default styles in an initializer, e.g.:

```ruby
# config/initializers/change_modal_component_defaults.rb

Fluxbit::Config::ModalComponent.styles[:root][:base] = "fixed inset-x-0 top-0 z-[9999] h-screen overflow-y-auto overflow-x-hidden md:inset-0 md:h-full flex"
Fluxbit::Config::ModalComponent.opened = false      # default value
Fluxbit::Config::ModalComponent.close_button = true # default value
Fluxbit::Config::ModalComponent.flat = false        # default value
Fluxbit::Config::ModalComponent.size = 2            # default value
Fluxbit::Config::ModalComponent.only_css = false    # default value
Fluxbit::Config::ModalComponent.static = false      # default value
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons (close button).
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling, including the backdrop and default classes.

## Styles

To view the current styles configuration for the `Fluxbit::ModalComponent`, you can inspect:

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::ModalComponent.styles)) %>
```

which will output a JSON representation of the default style mappings.

## References

[Flowbite Modals](https://flowbite.com/docs/components/modal/)
