---
label: Toggle
title: Fluxbit::Form::ToggleComponent or fx_toggle
---

The `Fluxbit::Form::ToggleComponent` is a styled switch/toggle form field component that extends `Fluxbit::Form::FieldComponent`.
It provides on/off input controls with support for custom colors, sizing options, label placement, helper text, and integrates seamlessly with Rails form builders.

To start using the toggle you can use the default way to call the component:

```html
&lt;%= render Fluxbit::Form::ToggleComponent.new(name: "enabled", label: "Enable notifications") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::ToggleComponent.new(name: "enabled", label: "Enable notifications") do %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_toggle(name: "enabled", label: "Enable notifications") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_toggle(name: "enabled", label: "Enable notifications") do %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param                    | Default    | Description
|:-------------------------|:-----------|:------------
| name:                    |            | Field name (required unless using a form builder)
| label:                   |            | Text label for the toggle
| help_text:               |            | Help or error text below the field
| helper_popover:          |            | Content for a popover helper
| helper_popover_placement:| "right"    | Placement of the popover (`:top`, `:right`, `:bottom`, `:left`)
| color:                   | :default   | Checked toggle color (`:default`, `:success`, `:danger`, `:warning`, `:info`, `:dark`, `:light`, `:teal`, `:purple`, `:cyan`, `:lime`, `:indigo`, `:pink`)
| unchecked_color:         | :default   | Unchecked toggle color (same options as color plus light variants)
| button_color:            | :default   | Color for the toggle button (`:default`, `:success`, `:danger`, `:info`)
| sizing:                  | 1          | Toggle size (0 to &lt;%= Fluxbit::Config::Form::ToggleComponent.styles[:toggle][:sizes].count - 1 %&gt;)
| invert_label:            | false      | If true, places toggle on the left and label on the right
| disabled:                | false      | Disables the toggle if true
| checked:                 | false      | Sets initial checked state
| value:                   | "1"        | Value when toggle is checked
| required:                | false      | Marks the field as required (adds "required" class to wrapper)
| remove_class:            | ""         | Classes to be removed from the default class list
| wrapper_html:            | {}         | Additional HTML attributes for the wrapper div
| **props                  |            | Any other HTML attribute for `<input type="checkbox">`

## Slots

The component supports the following slots:

- `with_other_label`: Add an additional label with custom markup and positioning.

## Examples

### Basic toggle

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="basic_toggle" panels="source"></lookbook-embed>

### Toggle colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="toggle_colors" panels="source"></lookbook-embed>

### Toggle sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="toggle_sizes" panels="source"></lookbook-embed>

### Unchecked colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="unchecked_colors" panels="source"></lookbook-embed>

### Button colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="button_colors" panels="source"></lookbook-embed>

### Inverted label position

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="inverted_label" panels="source"></lookbook-embed>

### Toggle states

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="toggle_states" panels="source"></lookbook-embed>

### Disabled toggle

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="disabled" panels="source"></lookbook-embed>

### Required vs optional fields

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="required_field" panels="source"></lookbook-embed>

### With helper text

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="with_helper_text" panels="source"></lookbook-embed>

### With helper popover

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="with_helper_popover" panels="source"></lookbook-embed>

### With additional label slot

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="with_additional_label" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::ToggleComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

## When to use

Use `Toggle` when you need a binary on/off control that's more visually prominent than a checkbox. It's ideal for settings pages, feature flags, preferences, status controls, and any scenario where the user needs to enable or disable functionality.

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
      notifications_enabled: "Enable Notifications"
      dark_mode: "Dark Mode"
      auto_save: "Auto-save"
    help_text:
      notifications_enabled: "Receive email notifications about account activity"
      dark_mode: "Switch to dark theme for better viewing in low light"
      auto_save: "Automatically save your work every few minutes"
    helper_popover:
      notifications_enabled: "You can change this setting at any time in your preferences"

# In your form
&lt;%= fx_toggle(form: form, attribute: :notifications_enabled) %&gt;
# Automatically uses labels and help text from translations

# Override with custom values
&lt;%= fx_toggle(form: form, attribute: :notifications_enabled, label: "Custom Label") %&gt;

# Disable automatic labels/help text
&lt;%= fx_toggle(form: form, attribute: :notifications_enabled, label: false, help_text: false) %&gt;
```

### Override Behavior

- **Custom value**: Pass a string to override the translation
- **Disable**: Pass `false` to disable automatic translation lookup
- **Default**: Leave blank to use automatic translation lookup

## Toggle vs Checkbox

- **Toggle**: Better for immediate actions and settings (like "Enable notifications")
- **Checkbox**: Better for selections and form submissions (like "I agree to terms")

## Accessibility

* Labels use `<label for="...">` if provided.
* Pass `disabled: true` for ARIA compliance.
* Supports all standard ARIA attributes via props.
* Toggle state is communicated to screen readers via checkbox semantics.

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_toggle_component_defaults.rb

Fluxbit::Config::Form::ToggleComponent.color = :success # the default is :default
Fluxbit::Config::Form::ToggleComponent.unchecked_color = :light_success # the default is :default
Fluxbit::Config::Form::ToggleComponent.button_color = :success # the default is :default
Fluxbit::Config::Form::ToggleComponent.sizing = 2 # the default is 1
Fluxbit::Config::Form::ToggleComponent.invert_label = true # the default is false
Fluxbit::Config::Form::ToggleComponent.styles[:toggle][:base] = 'custom-toggle-base' # modify base styles
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::Form::ToggleComponent.styles)) %>
```

## References

[Flowbite Toggle](https://flowbite.com/docs/forms/toggle/)