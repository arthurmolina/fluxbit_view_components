---
label: TextField
title: Fluxbit::Form::TextFieldComponent or fx_text_field
---

The `Fluxbit::Form::TextFieldComponent` is a flexible form field component that extends `Fluxbit::Form::FieldComponent`.
It provides text input for forms with support for labels, helper text, icons, addons, validation states, and all HTML input types including password, email, number, URL, color, and more. Supports icons, add-ons, multiline (textarea), sizing, and validation colors.

**Attention: This component isn't used alone. It is used with the other form components.**

To start using the text field you can use the default way to call the component:

```html
&lt;%= render Fluxbit::Form::TextFieldComponent.new(name: "username", label: "Username") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::TextFieldComponent.new(name: "username", label: "Username") do %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_text_field(name: "username", label: "Username") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_text_field(name: "username", label: "Username") do %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| name:              |          | Field name (required unless using a form builder)
| label:             |          | Text label above the field
| value:             |          | Value for the input
| placeholder:       |          | Placeholder text shown when empty (supports I18n, pass `false` to disable)
| type:              | :text    | Input type (`:text`, `:email`, `:password`, `:textarea`, `:number`, `:url`, `:tel`, `:search`, `:color`, `:date`, `:datetime_local`, `:month`, `:time`, `:week`, `:currency`)
| multiline:         | false    | Renders a `<textarea>` if true (or type is `:textarea`)
| icon:              |          | Left icon (Anyicon name or symbol)
| right_icon:        |          | Right icon (Anyicon name or symbol)
| addon:             |          | Addon (text or icon) before the field
| addon_html:        | {}       | Additional HTML attributes for the addon element
| icon_html:         | {}       | Additional HTML attributes for the left icon element
| right_icon_html:   | {}       | Additional HTML attributes for the right icon element
| div_html:          | {}       | Additional HTML attributes for the container div
| color:             | :default | State: `:default`, `:success`, `:danger`, `:warning`, `:info`
| help_text:         |          | Help or error text below the field
| helper_popover:    |          | Content for a popover helper
| helper_popover_placement: | "right" | Placement of the popover (`:top`, `:right`, `:bottom`, `:left`)
| sizing:            | 0        | Field size (0 to &lt;%= Fluxbit::Config::Form::TextFieldComponent.styles[:sizes].count - 1 %&gt;)
| shadow:            | false    | Adds a drop shadow if true
| disabled:          | false    | Disables the input
| readonly:          | false    | Makes the input readonly
| required:          | false    | Marks the field as required
| remove_class:      | ""       | Classes to be removed from the default class list
| wrapper_html:      | {}       | Additional HTML attributes for the wrapper div
| **props            |          | Any other HTML attribute for `<input>`/`<textarea>`

## Slots

This component does not define any named slots. The field content is determined by the form data and input value.

## Examples

### Basic text field

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="basic" panels="source"></lookbook-embed>

### Different input types

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="input_types" panels="source"></lookbook-embed>

### Password field with icon

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="password_with_icon" panels="source"></lookbook-embed>

### With prefix addon

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="with_addon" panels="source"></lookbook-embed>

### With icons

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="with_icons" panels="source"></lookbook-embed>

### Multi-line (textarea)

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="multiline" panels="source"></lookbook-embed>

### Validation states

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="validation_states" panels="source"></lookbook-embed>

### Different sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="sizes" panels="source"></lookbook-embed>

### With helper popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="with_helper_popover" panels="source"></lookbook-embed>

### Disabled and readonly fields

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="disabled_readonly" panels="source"></lookbook-embed>

### With shadow effects

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="with_shadow" panels="source"></lookbook-embed>

### With form builder

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="with_form_builder" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TextFieldComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `TextField` whenever you need to collect short or multi-line text from a user. Supports text, email, password, number, and other standard input types.
It's suitable for login forms, profile fields, contact forms, and anywhere you'd use a text box or textarea.

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
    placeholders:
      attribute_name: "Custom placeholder text"
```

### Usage Examples

```ruby
# Translation file (config/locales/en.yml)
en:
  user:
    fields:
      email: "Email Address"
      password: "Password"
    help_text:
      email: "We'll never share your email with anyone"
      password: "Must be at least 8 characters"
    helper_popover:
      password: "Use a combination of letters, numbers, and symbols"
    placeholders:
      email: "Enter your email address"
      password: "Enter a strong password"

# In your form
&lt;%= fx_text_field(form: form, attribute: :email) %&gt;
# Automatically uses "Email Address" as label, help text, and placeholder from translations

# Override with custom values
&lt;%= fx_text_field(form: form, attribute: :email, label: "Custom Label", placeholder: "Custom placeholder") %&gt;

# Disable automatic labels/help text/placeholders
&lt;%= fx_text_field(form: form, attribute: :email, label: false, help_text: false, placeholder: false) %&gt;
```

### Override Behavior

- **Custom value**: Pass a string to override the translation
- **Disable**: Pass `false` to disable automatic translation lookup
- **Default**: Leave blank to use automatic translation lookup

## Supported Types

`text`, `textarea`, `color`, `number`, `email`, `password`, `search`, `tel`, `url`, `date`, `datetime_local`, `month`, `time`, `week`, `currency`

## Accessibility

* Labels use `<label for="...">` if provided.
* Pass `disabled: true` or `readonly: true` for ARIA compliance.
* Supports all standard ARIA attributes via props.

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_text_field_component_defaults.rb

Fluxbit::Config::Form::TextFieldComponent.color = :info # the default is :default
Fluxbit::Config::Form::TextFieldComponent.sizing = 2 # the default is 1
Fluxbit::Config::Form::TextFieldComponent.shadow = true # the default is false
Fluxbit::Config::Form::TextFieldComponent.styles[:default] = 'block w-full px-3 py-2 border border-gray-300 rounded-md' # modify base styles
```

## Dependencies

- [**Anyicon**](https://github.com/arthurmolina/anyicon): Used for rendering icons.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::Form::TextFieldComponent.styles)) %>
```

## References

[Flowbite Form Elements](https://flowbite.com/docs/forms/input-field/)