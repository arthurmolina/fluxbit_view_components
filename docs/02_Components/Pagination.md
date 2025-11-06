---
label: Pagination
title: Fluxbit::PaginationComponent or fx_pagination
---

The `Fluxbit::PaginationComponent` is a navigation component that extends `Fluxbit::Component`.
It allows you to create pagination controls with customizable appearance, behavior, and content areas. The pagination component supports various layouts, sizes, and integration with pagination libraries like Pagy. It provides proper accessibility with ARIA labels and semantic HTML structure following Flowbite styles.

To start using the pagination you can use the default way to call the component:

```html
&lt;%= render Fluxbit::PaginationComponent.new(page: 1, last: 10, count: 100) %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_pagination(page: 1, last: 10, count: 100) %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="basic" panels="params,source"></lookbook-embed>

## Options

| Param              | Default    | Description
|:-------------------|:-----------|:------------
| pagy:              | nil        | Pagy object for automatic pagination (overrides manual parameters)
| page:              | 1          | Current page number
| last:              | 1          | Total number of pages
| count:             | 0          | Total number of items
| next:              | nil        | Next page number (calculated automatically if not provided)
| previous:          | nil        | Previous page number (calculated automatically if not provided)
| size:              | 3          | Number of page links to display around current page (Integer >= 0)
| ends:              | true       | Whether to show first/last pages with gaps in long pagination
| request_path:      | nil        | Base path for pagination links (uses current request path if not provided)
| show_first_last:   | true       | Whether to show first/last page buttons
| show_prev_next:    | true       | Whether to show previous/next buttons
| show_pages:        | true       | Whether to show individual page number links
| show_icons:        | true       | Whether to show icons in navigation buttons
| show_texts:        | true       | Whether to show text labels in navigation buttons
| sizing:            | :default   | Size variant (`:sm`, `:default`, `:lg`)
| aria_label:        | "Page navigation" | ARIA label for the navigation element
| remove_class:      | ""         | Classes to be removed from the default class list
| **props            |            | Additional HTML attributes for the nav element

## Examples

### Basic pagination
Shows a simple pagination with page numbers and navigation buttons.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="basic" panels="source"></lookbook-embed>

### Different sizes
Demonstrates small, default, and large pagination sizes.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="sizes" panels="source"></lookbook-embed>

### Icons only pagination
Shows pagination with icons but no text labels.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="icons_only" panels="source"></lookbook-embed>

### Text only pagination
Shows pagination with text labels but no icons.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="texts_only" panels="source"></lookbook-embed>

### With first/last buttons
Demonstrates pagination including first and last page buttons.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="with_first_last" panels="source"></lookbook-embed>

### Long series with gaps
Shows how pagination handles long page ranges with ellipsis gaps.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="long_series_with_gaps" panels="source"></lookbook-embed>

### Custom ARIA labels and URLs
Demonstrates custom accessibility labels and URL building.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="custom_aria_and_urls" panels="source"></lookbook-embed>

### Edge cases
Shows how pagination handles edge cases like single pages and boundary conditions.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="edge_cases" panels="source"></lookbook-embed>

### Zero size pagination
Demonstrates pagination with size set to 0 (no page number links).

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::PaginationComponentPreview" scenario="zero_size" panels="source"></lookbook-embed>

## Integration with Pagy

The component works seamlessly with the [Pagy gem](https://github.com/ddnexus/pagy):

```ruby
# In your controller
@pagy, @records = pagy(User.all)

# In your view
&lt;%= fx_pagination(@pagy) %&gt;
```

When using Pagy, the component automatically extracts all necessary parameters from the Pagy object.

## Internationalization (i18n)

The component supports internationalization through Rails i18n. It looks for translations under the `fluxbit.pagination` scope:

```yaml
# config/locales/en.yml
en:
  fluxbit:
    pagination:
      first: "First"
      last: "Last" 
      next: "Next"
      prev: "Previous"
      aria_label:
        nav: "Page navigation (%{count} pages)"
        first: "Go to first page"
        last: "Go to last page"
        next: "Go to next page"
        prev: "Go to previous page"
```

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_pagination_component_defaults.rb

# Customize default pagination settings
Fluxbit::Config::PaginationComponent.show_first_last = false # default is true
Fluxbit::Config::PaginationComponent.show_prev_next = true # default is true
Fluxbit::Config::PaginationComponent.show_pages = true # default is true
Fluxbit::Config::PaginationComponent.show_icons = false # default is true
Fluxbit::Config::PaginationComponent.show_texts = true # default is true
Fluxbit::Config::PaginationComponent.sizing = :lg # default is :default

# Customize styling for different pagination sizes
Fluxbit::Config::PaginationComponent.styles[:sizes][:xl] = {
  root: 'text-xl',
  page_link: 'px-5 py-3'
} # add extra large size
```

## Dependencies

- [**Pagy**](https://github.com/ddnexus/pagy): Optional - for automatic pagination integration.
- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering navigation icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling reference.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::PaginationComponent.styles)) %>
```

## References

[Flowbite Pagination](https://flowbite.com/docs/components/pagination/)