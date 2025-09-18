---
label: Label
title: Fluxbit::Form::LabelComponent or fx_label
---

The `Fluxbit::Form::LabelComponent` is a flexible and accessible label component that extends `Fluxbit::Form::Component`.
It provides customizable labels for form fields with support for different colors, sizes, helper popovers, and associated help text. The component is fully compatible with Rails form builders and follows accessibility best practices.

**Attention: This component isn't used alone. It is used with the other form components.**

To start using the label you can use the default way to call the component:

```html
&lt;%= render Fluxbit::Form::LabelComponent.new(with_content: "Your Name") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::LabelComponent.new do %&gt;
    Your Name
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_label(with_content: "Your Name") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_label do %&gt;
    Your Name
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param                         | Default  | Description
|:------------------------------|:---------|:------------
| with_content:                 |          | The label text to display (alternative to block content)
| help_text:                    |          | One or more help text messages to render below the label (string or array)
| helper_popover:               |          | Popover content shown on icon hover
| helper_popover_placement:     | "right"  | Placement of the popover (`:top`, `:right`, `:bottom`, `:left`)
| sizing:                       | 1        | Size index for label text (0 to &lt;%= Fluxbit::Config::Form::LabelComponent.styles[:sizes].count - 1 %&gt;)
| color:                        | :default | Label color scheme (`:default`, `:success`, `:danger`, `:info`, `:warning`)
| for:                          |          | ID of the associated form element (for accessibility)
| remove_class:                 | ""       | Classes to be removed from the default class list
| **props                       |          | Additional HTML attributes for the label element

## Slots

This component does not define any named slots. The label text content is provided through the default block or `with_content` parameter:

```html
&lt;%= fx_label(for: "username") do %&gt;
  Username
&lt;% end %&gt;
```

## Examples

### Basic labels

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="basic_labels" panels="source"></lookbook-embed>

### Label sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="label_sizes" panels="source"></lookbook-embed>

### Color variations

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="color_variations" panels="source"></lookbook-embed>

### Labels with help text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="with_help_text" panels="source"></lookbook-embed>

### Labels with helper popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="with_helper_popover" panels="source"></lookbook-embed>

### Multiple help text messages

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="multiple_help_text" panels="source"></lookbook-embed>

### Different popover placements

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="popover_placements" panels="source"></lookbook-embed>

### Complete form field example

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="complete_form_field" panels="source"></lookbook-embed>

### Validation states

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="validation_states" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::LabelComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `Label` for:
- **Form field labels**: Providing clear, descriptive labels for input fields
- **Accessibility**: Ensuring proper form field association and screen reader support
- **Validation feedback**: Displaying different label colors for validation states
- **Help documentation**: Adding contextual help via popovers for complex fields
- **Multi-step guidance**: Providing progressive disclosure of field requirements
- **Required field indication**: Marking mandatory fields with visual indicators
- **Internationalization**: Supporting multilingual form labels

## Color States

- **`:default`**: Standard dark text for normal form labels
- **`:success`**: Green text for successfully validated fields
- **`:danger`**: Red text for fields with validation errors
- **`:warning`**: Yellow text for fields requiring attention
- **`:info`**: Cyan text for informational field labels

## Label Sizes

- **`0`**: Small text (`text-sm`) for compact forms
- **`1`**: Medium text (`text-md`) - default size
- **`2`**: Large text (`text-lg`) for emphasis or large forms

## Accessibility

* Uses semantic `<label>` element for proper form association
* Supports `for` attribute to link labels with form controls
* Helper popovers use proper ARIA attributes for screen readers
* Color variations maintain sufficient contrast ratios
* Help text is programmatically associated with the label
* Compatible with keyboard navigation and screen readers
* Supports all standard ARIA attributes via props

## Best Practices

- Always associate labels with form controls using the `for` attribute
- Use helper popovers sparingly to avoid overwhelming users
- Choose appropriate colors based on field validation state
- Keep label text concise and descriptive
- Use help text for additional guidance rather than cluttering the label
- Consider label placement and alignment for form layout consistency

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_label_component_defaults.rb

Fluxbit::Config::Form::LabelComponent.color = :info # the default is :default
Fluxbit::Config::Form::LabelComponent.sizing = 2 # the default is 1
Fluxbit::Config::Form::LabelComponent.helper_popover_placement = "top" # the default is "right"
Fluxbit::Config::Form::LabelComponent.helper_popover_icon = "heroicons_solid:information-circle" # custom icon
Fluxbit::Config::Form::LabelComponent.styles[:base] = 'flex font-semibold' # the default is 'flex font-medium'
Fluxbit::Config::Form::LabelComponent.styles[:colors][:custom] = 'text-purple-700 dark:text-purple-400' # add custom color
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering helper popover icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.
- [**Fluxbit::PopoverComponent**](../02_Components/Popover.md): Used for helper popover functionality.
- [**Fluxbit::Form::HelpTextComponent**](HelpText.md): Used for rendering help text messages.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::Form::LabelComponent.styles)) %>
```

## References

[Flowbite Form Labels](https://flowbite.com/docs/forms/input-field/#labels)