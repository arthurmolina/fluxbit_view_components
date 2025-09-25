---
label: Skeleton
title: Fluxbit::SkeletonComponent or fx_skeleton
---

The `Fluxbit::SkeletonComponent` is a customizable skeleton loading component that extends `Fluxbit::Component`.
It provides animated placeholders for content that is loading, supporting various types like text, images, cards, avatars, and more complex layouts.

To start using the skeleton you can use the default way to call the component:

```html
&lt;%= render Fluxbit::SkeletonComponent.new %&gt;

<!-- or -->

&lt;%= render Fluxbit::SkeletonComponent.new(variant: :image) %&gt;

<!-- or -->

&lt;%= render Fluxbit::SkeletonComponent.new(variant: :card) %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_skeleton %&gt;

<!-- or -->

&lt;%= fx_skeleton(variant: :image) %&gt;

<!-- or -->

&lt;%= fx_skeleton(variant: :card) %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default     | Description
|:-------------------|:------------|:------------
| variant:           | :default    | The type of skeleton (:default, :text, :image, :video, :avatar, :card, :widget, :list, :testimonial, :button).
| animation:         | true        | Whether to show the pulse animation.
| rows:              | 3           | Number of text rows for default/text variants.
| size:              | :medium     | Size for avatar, image, and video variants (:small, :medium, :large).
| lines:             | nil         | Number of lines for text-based variants (takes precedence over rows).
| remove_class:      | ""          | Classes to be removed from the default class list.
| **props            |             | Additional HTML attributes.

## Examples

### Default Skeleton (Text)

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="default_skeleton" panels="source"></lookbook-embed>

### Text Skeleton

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="text_skeleton" panels="source"></lookbook-embed>

### Image Skeleton

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="image_skeleton" panels="source"></lookbook-embed>

### Video Skeleton

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="video_skeleton" panels="source"></lookbook-embed>

### Avatar Skeleton

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="avatar_skeleton" panels="source"></lookbook-embed>

### Card Skeleton

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="card_skeleton" panels="source"></lookbook-embed>

### Widget Skeleton

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="widget_skeleton" panels="source"></lookbook-embed>

### List Skeleton

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="list_skeleton" panels="source"></lookbook-embed>

### Testimonial Skeleton

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="testimonial_skeleton" panels="source"></lookbook-embed>

### Button Skeleton

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="button_skeleton" panels="source"></lookbook-embed>

### Different Sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="different_sizes" panels="source"></lookbook-embed>

### Without Animation

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="without_animation" panels="source"></lookbook-embed>

### Custom Rows

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="custom_rows" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SkeletonComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `Skeleton` to provide visual feedback during loading states:

- **Content Loading** - Show placeholders while fetching data from APIs
- **Image Loading** - Display placeholder while images are loading
- **Page Transitions** - Provide smooth loading experience during navigation
- **Progressive Enhancement** - Show content structure before data arrives
- **Better UX** - Replace generic spinners with content-specific placeholders

## Accessibility

* Uses `role="status"` to announce loading state to screen readers
* Includes hidden "Loading..." text for screen reader users
* `aria-label="Loading"` provides additional context
* Animated placeholders help users understand content is loading
* Component supports additional ARIA attributes through **props

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_skeleton_component_defaults.rb

Fluxbit::Config::SkeletonComponent.variant = :card # the default is :default
Fluxbit::Config::SkeletonComponent.animation = false # the default is true
Fluxbit::Config::SkeletonComponent.rows = 5 # the default is 3

# Customize skeleton styles
Fluxbit::Config::SkeletonComponent.styles[:text][:line] = 'h-3 bg-blue-200 rounded-full dark:bg-blue-700'
Fluxbit::Config::SkeletonComponent.styles[:avatar][:large] = 'w-20 h-20 bg-gray-300 rounded-full dark:bg-gray-600'
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::SkeletonComponent.styles)) %>
```

## References

[Flowbite Skeleton](https://flowbite.com/docs/components/skeleton/)