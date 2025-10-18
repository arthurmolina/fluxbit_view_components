---
label: Select
title: Fluxbit::Form::SelectComponent or fx_select
---

The `Fluxbit::Form::SelectComponent` is a flexible dropdown form field component that extends `Fluxbit::Form::TextFieldComponent`.
It provides styled select inputs with support for standard options, grouped options, time zone selection, validation states, and integrates seamlessly with Rails form builders.

To start using the select you can use the default way to call the component:

```erb
&lt;%= render Fluxbit::Form::SelectComponent.new(name: "role", options: ["Admin", "User", "Guest"], label: "User Role") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::SelectComponent.new(name: "country", label: "Country") do %&gt;
    &lt;option value="us"&gt;United States&lt;/option&gt;
    &lt;option value="ca"&gt;Canada&lt;/option&gt;
    &lt;option value="mx"&gt;Mexico&lt;/option&gt;
&lt;% end %&gt;
```

## Helper Method Signatures

The `fx_select` helper mimics Rails' native `select` and `select_tag` helpers for maximum compatibility.

### Standalone Usage (like `select_tag`)

```erb
&lt;%# Rails-style: fx_select(name, option_tags = nil, options = {}) %&gt;
&lt;%= fx_select "role", ["Admin", "User", "Guest"] %&gt;
&lt;%= fx_select "country", countries, prompt: "Select a country", class: "custom-select" %&gt;
&lt;%= fx_select "status", options_for_select(statuses, selected: "active") %&gt;

&lt;%# Named parameters (backwards compatible) %&gt;
&lt;%= fx_select name: "role", options: ["Admin", "User"], prompt: "Choose..." %&gt;

&lt;%# Block syntax %&gt;
&lt;%= fx_select "country", label: "Country" do %&gt;
    &lt;option value="us"&gt;United States&lt;/option&gt;
    &lt;option value="ca"&gt;Canada&lt;/option&gt;
&lt;% end %&gt;
```

### Form Builder Usage (like `form.select`)

```erb
&lt;%# Rails-style: form.fx_select(method, choices = nil, options = {}, html_options = {}) %&gt;
&lt;%= form.fx_select :role, ["Admin", "User", "Guest"] %&gt;
&lt;%= form.fx_select :country, countries, { prompt: "Select a country" }, { class: "custom-select" } %&gt;
&lt;%= form.fx_select :status, options_for_select(statuses, selected: "active") %&gt;
&lt;%= form.fx_select :priority, priorities, prompt: "Select priority level" %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param                      | Default  | Description
|:---------------------------|:---------|:------------
| name:                      |          | Field name (required unless using a form builder)
| label:                     |          | Text label above the field (auto-generated from attribute if using form builder, pass `false` to hide)
| help_text:                 |          | Help or error text below the field (supports i18n, pass `false` to hide)
| helper_popover:            |          | Content for info popover next to label (supports i18n, pass `false` to hide)
| helper_popover_placement:  | "right"  | Popover placement: `"top"`, `"right"`, `"bottom"`, `"left"`
| value:                     |          | Selected value for the select
| options:                   | {}       | Array, hash, or pre-formatted HTML string of options (see [Option Formats](#option-formats))
| choices:                   |          | Alternative to options - list of choices for options
| grouped:                   | false    | Enables grouped select options (optgroups)
| time_zone:                 | false    | Uses Rails time zone select options
| select_options:            | {}       | Hash of options for select (prompt, selected, disabled, include_blank, etc)
| prompt:                    |          | Prompt text shown as first option (can also be in select_options)
| include_blank:             |          | Include blank option (boolean or string, can also be in select_options)
| selected:                  |          | Pre-selected value (can also be in select_options)
| disabled:                  |          | Disabled option values as array or single value (can also be in select_options)
| color:                     | :default | State: `:default`, `:success`, `:danger`, `:warning`, `:info`
| sizing:                    | 1        | Field size (0 to 2)
| shadow:                    | false    | Adds a drop shadow if true
| multiple:                  | false    | Allows multiple selections
| remove_class:              | ""       | Classes to be removed from the default class list
| **props                    |          | Any other HTML attribute for `<select>`

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

### With label, help text, and helper popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="with_label_and_help" panels="source"></lookbook-embed>

### Rails helper compatibility

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="rails_helper_compatibility" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::SelectComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `Select` when you need users to choose from a predefined list of options. It's ideal for dropdowns with multiple choices, country/state selection, role assignment, category selection, and any scenario where you need to limit user input to specific values.

## Labels, Help Text, and Helper Popovers

The select component supports three types of supplementary content to enhance user experience:

### Label

A label is automatically rendered above the select field:

```erb
&lt;%= fx_select "country", countries, label: "Country of Residence" %&gt;
```

When using with a form builder, labels are auto-generated from the attribute name:

```erb
&lt;%= form.fx_select :country, countries %&gt;
&lt;!-- Automatically generates label "Country" from attribute name --&gt;
```

To hide the label, pass `false`:

```erb
&lt;%= fx_select "country", countries, label: false %&gt;
```

### Help Text

Help text appears below the select field to provide additional guidance:

```erb
&lt;%= fx_select "country", countries,
    label: "Country",
    help_text: "Select your country of residence" %&gt;
```

Help text can be an array for multiple lines:

```erb
&lt;%= fx_select "country", countries,
    help_text: ["Select your country", "This will determine your tax rate"] %&gt;
```

### Helper Popover

An info icon next to the label that shows a popover with additional information:

```erb
&lt;%= fx_select "country", countries,
    label: "Country",
    helper_popover: "Your country determines shipping rates and taxes",
    helper_popover_placement: "right" %&gt;
```

Popover placement options: `"top"`, `"right"`, `"bottom"`, `"left"`

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

## Rails Helper Compatibility

The `fx_select` helper is fully compatible with Rails' native `select` and `select_tag` helpers, using identical signatures:

### Form Builder: `form.fx_select` (matches `form.select`)

**Signature:** `form.fx_select(method, choices = nil, options = {}, html_options = {})`

```erb
&lt;%= form_with model: @user do |form| %&gt;
  &lt;%# Basic usage %&gt;
  &lt;%= form.fx_select :role, ["Admin", "User", "Guest"] %&gt;

  &lt;%# With prompt %&gt;
  &lt;%= form.fx_select :country, countries, prompt: "Select a country" %&gt;

  &lt;%# With options hash and html_options %&gt;
  &lt;%= form.fx_select :status, statuses, { prompt: "Choose..." }, { class: "custom-select" } %&gt;

  &lt;%# With pre-formatted options %&gt;
  &lt;%= form.fx_select :priority, options_for_select(priorities, selected: "high") %&gt;

  &lt;%# With grouped options %&gt;
  &lt;%= form.fx_select :category, grouped_categories, grouped: true %&gt;
&lt;% end %&gt;
```

### Standalone: `fx_select` (matches `select_tag`)

**Signature:** `fx_select(name, option_tags = nil, options = {})`

```erb
&lt;%# Basic usage %&gt;
&lt;%= fx_select "role", ["Admin", "User", "Guest"] %&gt;

&lt;%# With prompt and HTML attributes %&gt;
&lt;%= fx_select "country", countries, prompt: "Select a country", class: "custom-select" %&gt;

&lt;%# With pre-formatted options %&gt;
&lt;%= fx_select "status", options_for_select(statuses, selected: "active") %&gt;

&lt;%# Named parameters (backwards compatible) %&gt;
&lt;%= fx_select name: "role", options: ["Admin", "User"], prompt: "Choose..." %&gt;
```

### Migration from Rails Helpers

You can replace Rails helpers directly:

```erb
&lt;%# Replace select_tag with fx_select %&gt;
- &lt;%= select_tag "role", options_for_select(["Admin", "User"]) %&gt;
+ &lt;%= fx_select "role", options_for_select(["Admin", "User"]) %&gt;

&lt;%# Replace form.select with form.fx_select %&gt;
- &lt;%= form.select :role, ["Admin", "User"], prompt: "Choose..." %&gt;
+ &lt;%= form.fx_select :role, ["Admin", "User"], prompt: "Choose..." %&gt;
```

## Option Formats

The component supports multiple option formats, matching Rails' native helpers:

### Raw Data Formats
- **Simple array**: `["Option 1", "Option 2", "Option 3"]`
- **Array of arrays**: `[["Display Text", "value"], ["Another Option", "value2"]]`
- **Hash**: `{"Option 1" => "value1", "Option 2" => "value2"}`
- **Grouped options**: `{"Group 1" => [["Option 1", "value1"]], "Group 2" => [["Option 2", "value2"]]}`

### Pre-formatted HTML (from Rails helpers)
- **From `options_for_select`**:
  ```ruby
  options: options_for_select(["A", "B", "C"], selected: "B")
  ```
- **From `grouped_options_for_select`**:
  ```ruby
  options: grouped_options_for_select(groups_hash)
  ```
- **From `options_from_collection_for_select`**:
  ```ruby
  options: options_from_collection_for_select(@users, :id, :name)
  ```

The component automatically detects whether options are raw data or pre-formatted HTML and handles them appropriately.

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