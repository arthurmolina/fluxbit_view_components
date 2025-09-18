---
label: Select
title: Fluxbit::Form::SelectComponent or fx_select
---

The `Fluxbit::Form::SelectComponent` is a flexible dropdown form field component that extends `Fluxbit::Form::TextFieldComponent`.
It provides styled select inputs with support for standard options, grouped options, time zone selection, validation states, and integrates seamlessly with Rails form builders.

To start using the select you can use the default way to call the component:

```html
&lt;%= render Fluxbit::Form::SelectComponent.new(name: "role", options: ["Admin", "User", "Guest"], label: "User Role") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::SelectComponent.new(name: "country", label: "Country") do %&gt;
    &lt;option value="us"&gt;United States&lt;/option&gt;
    &lt;option value="ca"&gt;Canada&lt;/option&gt;
    &lt;option value="mx"&gt;Mexico&lt;/option&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_select(name: "role", options: ["Admin", "User", "Guest"], label: "User Role") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_select(name: "country", label: "Country") do %&gt;
    &lt;option value="us"&gt;United States&lt;/option&gt;
    &lt;option value="ca"&gt;Canada&lt;/option&gt;
    &lt;option value="mx"&gt;Mexico&lt;/option&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| name:              |          | Field name (required unless using a form builder)
| label:             |          | Text label above the field
| value:             |          | Selected value for the select
| options:           | {}       | Array or hash of options for the select
| choices:           |          | Alternative to options - list of choices for options
| grouped:           | false    | Enables grouped select options (optgroups)
| time_zone:         | false    | Uses Rails time zone select options
| select_options:    | {}       | Options for select tag (prompt, selected, disabled, etc)
| color:             | :default | State: `:default`, `:success`, `:danger`, `:warning`, `:info`
| help_text:         |          | Help or error text below the field
| sizing:            | 1        | Field size (0 to 2)
| shadow:            | false    | Adds a drop shadow if true
| disabled:          | false    | Disables the select
| multiple:          | false    | Allows multiple selections
| remove_class:      | ""       | Classes to be removed from the default class list.
| **props            |          | Any other HTML attribute for `<select>`

## Slots

This component does not define any named slots. The select options can be provided through the `options` parameter or as block content with `<option>` tags.

## Examples

### Basic select

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="basic_select" panels="source"></lookbook-embed>

### Select with prompt

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="with_prompt" panels="source"></lookbook-embed>

### Grouped options

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="grouped_options" panels="source"></lookbook-embed>

### Time zone select

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="time_zone_select" panels="source"></lookbook-embed>

### Multiple selection

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="multiple_selection" panels="source"></lookbook-embed>

### Validation states

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="validation_states" panels="source"></lookbook-embed>

### Different sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="sizes" panels="source"></lookbook-embed>

### Disabled select

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="disabled" panels="source"></lookbook-embed>

### With helper text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="with_helper_text" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `Select` when you need users to choose from a predefined list of options. It's ideal for dropdowns with multiple choices, country/state selection, role assignment, category selection, and any scenario where you need to limit user input to specific values.

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
      role: "User Role"
      country: "Country"
      status: "Account Status"
    help_text:
      role: "Select the appropriate role for this user"
      country: "Choose your country of residence"
      status: "Current status of the user account"
    helper_popover:
      role: "Roles determine what actions users can perform in the system"

# In your form
&lt;%= fx_select(form: form, attribute: :role, options: role_options) %&gt;
# Automatically uses labels and help text from translations

# Override with custom values
&lt;%= fx_select(form: form, attribute: :role, label: "Custom Label") %&gt;

# Disable automatic labels/help text
&lt;%= fx_select(form: form, attribute: :role, label: false, help_text: false) %&gt;
```

### Override Behavior

- **Custom value**: Pass a string to override the translation
- **Disable**: Pass `false` to disable automatic translation lookup
- **Default**: Leave blank to use automatic translation lookup

## Option Formats

The component supports multiple option formats:

- **Simple array**: `["Option 1", "Option 2", "Option 3"]`
- **Array of arrays**: `[["Display Text", "value"], ["Another Option", "value2"]]`
- **Hash**: `{"Option 1" => "value1", "Option 2" => "value2"}`
- **Grouped options**: `{"Group 1" => [["Option 1", "value1"]], "Group 2" => [["Option 2", "value2"]]}`

## Accessibility

* Labels use `<label for="...">` if provided.
* Pass `disabled: true` for ARIA compliance.
* Supports all standard ARIA attributes via props.
* Grouped options use proper `<optgroup>` semantics.

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_select_component_defaults.rb

Fluxbit::Config::Form::SelectComponent.color = :info # the default is :default
Fluxbit::Config::Form::SelectComponent.sizing = 2 # the default is 1
Fluxbit::Config::Form::SelectComponent.shadow = true # the default is false
Fluxbit::Config::Form::SelectComponent.styles[:default] = 'block w-full px-3 py-2 border border-gray-300 rounded-md' # modify base styles
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
No styles
```

## References

[Flowbite Form Elements](https://flowbite.com/docs/forms/select/)