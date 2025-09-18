---
label: CheckBox
title: Fluxbit::Form::CheckBoxComponent or fx_check_box
---

The `Fluxbit::Form::CheckBoxComponent` is a flexible form input component that extends `Fluxbit::Form::FieldComponent`.
It provides checkbox and radio button inputs for forms with support for labels, helper text, validation states, and different visual styles. The component automatically handles the correct styling for both checkbox and radio types and works seamlessly with or without Rails form builders.

To start using the check box you can use the default way to call the component:

```html
&lt;%= render Fluxbit::Form::CheckBoxComponent.new(name: "accept_terms", label: "Accept the terms").with_content('') %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::CheckBoxComponent.new(name: "accept_terms", label: "Accept the terms") do %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_check_box(name: "accept_terms", label: "Accept the terms") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_check_box(name: "accept_terms", label: "Accept the terms") do %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="playground" panels="params,source"></lookbook-embed>

## Options

| Param              | Default     | Description
|:-------------------|:------------|:------------
| name:              |             | Field name (required unless using a form builder)
| label:             |             | Label text next to the input
| value:             |             | Value for the field (optional)
| type:              | :check_box  | Input type (`:check_box`, `:checkbox`, `:radio_button`)
| help_text:         |             | Help or error text below the field
| helper_popover:    |             | Content for a popover helper
| helper_popover_placement: | :right | Placement of the popover (`:top`, `:right`, `:bottom`, `:left`)
| disabled:          | false       | Disables the input if true
| checked:           | false       | Marks the input as checked if true
| remove_class:      | ""          | Classes to be removed from the default class list
| **props            |             | Additional HTML attributes for the input element

## Slots

This component does not define any named slots. The checkbox content is determined by the form data and input state.

## Examples

### Basic checkbox

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="basic_checkbox" panels="source"></lookbook-embed>

### Radio buttons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="radio_buttons" panels="source"></lookbook-embed>

### Checkbox group

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="checkbox_group" panels="source"></lookbook-embed>

### Checked states

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="checked_states" panels="source"></lookbook-embed>

### Disabled checkboxes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="disabled_checkboxes" panels="source"></lookbook-embed>

### With helper text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="with_helper_text" panels="source"></lookbook-embed>

### With helper popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="with_helper_popover" panels="source"></lookbook-embed>

### Inline checkboxes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="inline_checkboxes" panels="source"></lookbook-embed>

### With form builder

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="with_form_builder" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::CheckBoxComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `CheckBox` for:
- **Binary choices**: Yes/No, Accept/Decline, Enable/Disable options
- **Multiple selections**: When users can select multiple items from a list
- **Radio buttons**: When users need to select exactly one option from multiple choices
- **Terms acceptance**: Privacy policies, terms of service, newsletter subscriptions
- **Feature toggles**: Settings and preferences that can be turned on/off

## Internationalization (I18n)

Labels, help texts, and helper popovers can be automatically loaded from translation files. The component will look for translations using Rails' I18n system based on the form object and attribute names.

### Translation Structure

```yaml
en:
  model_name:
    fields:
      attribute_name: "Custom Label"
    help_text:
      attribute_name: "Custom help text"
    helper_popover:
      attribute_name: "Custom popover content"
```

### Usage Examples

```ruby
# Translation file (config/locales/en.yml)
en:
  user:
    fields:
      accept_terms: "I accept the terms and conditions"
      newsletter: "Subscribe to newsletter"
    help_text:
      accept_terms: "Required to create your account"
      newsletter: "Get updates about new features"
    helper_popover:
      accept_terms: "Please read our terms of service before accepting"

# In your form
&lt;%= fx_check_box(form: form, attribute: :accept_terms) %&gt;
# Automatically uses labels and help text from translations

# Override with custom values
&lt;%= fx_check_box(form: form, attribute: :accept_terms, label: "Custom Label") %&gt;

# Disable automatic labels/help text
&lt;%= fx_check_box(form: form, attribute: :accept_terms, label: false, help_text: false) %&gt;
```

### Override Behavior

- **Custom value**: Pass a string to override the translation
- **Disable**: Pass `false` to disable automatic translation lookup
- **Default**: Leave blank to use automatic translation lookup

## Input Types

- **`:check_box`** or **`:checkbox`**: Standard checkbox for binary or multiple selections
- **`:radio_button`**: Radio button for single selection from multiple options

## Accessibility

* Labels use `<label for="...">` and are properly associated with inputs
* Pass `disabled: true` for ARIA compliance
* Supports all standard ARIA attributes via props
* Radio buttons should be grouped with the same `name` attribute
* Checkboxes provide clear visual and programmatic state indication

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_check_box_component_defaults.rb

Fluxbit::Config::Form::CheckBoxComponent.type = :radio_button # the default is :check_box
Fluxbit::Config::Form::CheckBoxComponent.helper_popover_placement = :top # the default is :right
Fluxbit::Config::Form::CheckBoxComponent.styles[:base] = 'w-4 h-4 text-blue-600 rounded focus:ring-blue-500' # modify base styles
Fluxbit::Config::Form::CheckBoxComponent.styles[:checkbox] = 'border-gray-300 rounded' # modify checkbox-specific styles
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::Form::CheckBoxComponent.styles)) %>
```

## References

[Flowbite Checkbox](https://flowbite.com/docs/forms/checkbox/)