---
label: Telephone
title: Fluxbit::Form::TelephoneComponent
---

The `Fluxbit::Form::TelephoneComponent` is a specialized telephone input component that extends `Fluxbit::Form::TextFieldComponent`.
It provides a telephone number input with an integrated country code selector that displays country flags and international dialing codes. The component includes automatic phone number masking that adapts to the selected country's phone format.

**Attention: This component extends TextFieldComponent and inherits all of its functionality.**

To start using the telephone field you can use the default way to call the component:

```html
<%= render Fluxbit::Form::TelephoneComponent.new(name: "phone", label: "Phone Number") %>

<!-- or -->

<%= render Fluxbit::Form::TelephoneComponent.new(name: "phone", label: "Phone Number") do %>
<% end %>
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TelephoneComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Features

- **Country Selector**: Dropdown with country flags and dial codes (🇧🇷 +55, 🇺🇸 +1, etc.)
- **Automatic Masking**: Phone numbers are automatically formatted based on the selected country
- **15 Countries Supported**: Brazil, USA, Canada, UK, Germany, France, Spain, Italy, Portugal, Argentina, Mexico, Japan, China, India, and Australia
- **Responsive Sizing**: Three size options (Small, Medium, Large) with consistent styling
- **Form Builder Support**: Works seamlessly with Rails form builders
- **Validation States**: Supports all validation colors (success, danger, warning, info)

## Options

| Param              | Default  | Description
|:-------------------|:---------|:------------
| name:              |          | Field name (required unless using a form builder)
| label:             |          | Text label above the field
| value:             |          | Value for the phone number input
| placeholder:       |          | Placeholder text shown when empty
| default_country:   | "BR"     | Default country code (ISO 3166-1 alpha-2: "BR", "US", "GB", etc.)
| country_field_name:|          | Custom name for the country select field (defaults to `{name}_country`)
| color:             | :default | State: `:default`, `:success`, `:danger`, `:warning`, `:info`
| help_text:         |          | Help or error text below the field
| helper_popover:    |          | Content for a popover helper
| sizing:            | 1        | Field size: 0 (Small), 1 (Medium), 2 (Large)
| disabled:          | false    | Disables both the country select and phone input
| readonly:          | false    | Makes the input readonly
| required:          | false    | Marks the field as required
| wrapper_html:      | {}       | Additional HTML attributes for the wrapper div
| **props            |          | Any other HTML attribute for the `<input>`

## Supported Countries

The component supports the following countries with their respective masks:

- 🇧🇷 Brazil (+55): `(##) #####-####`
- 🇺🇸 United States (+1): `(###) ###-####`
- 🇨🇦 Canada (+1): `(###) ###-####`
- 🇬🇧 United Kingdom (+44): `#### ### ####`
- 🇩🇪 Germany (+49): `### #########`
- 🇫🇷 France (+33): `# ## ## ## ##`
- 🇪🇸 Spain (+34): `### ## ## ##`
- 🇮🇹 Italy (+39): `### ### ####`
- 🇵🇹 Portugal (+351): `### ### ###`
- 🇦🇷 Argentina (+54): `## ####-####`
- 🇲🇽 Mexico (+52): `## #### ####`
- 🇯🇵 Japan (+81): `##-####-####`
- 🇨🇳 China (+86): `### #### ####`
- 🇮🇳 India (+91): `##### #####`
- 🇦🇺 Australia (+61): `### ### ###`

## Slots

This component does not define any named slots. The field content is determined by the form data and input value.

## Examples

### Basic telephone field

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TelephoneComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Different countries

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TelephoneComponentPreview" scenario="with_different_countries" panels="source"></lookbook-embed>

### Validation states

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TelephoneComponentPreview" scenario="validation_states" panels="source"></lookbook-embed>

### Different sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TelephoneComponentPreview" scenario="sizes" panels="source"></lookbook-embed>

### Disabled and readonly

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TelephoneComponentPreview" scenario="disabled_readonly" panels="source"></lookbook-embed>

### Required field

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TelephoneComponentPreview" scenario="required_field" panels="source"></lookbook-embed>

### With form builder

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::TelephoneComponentPreview" scenario="with_form_builder" panels="source"></lookbook-embed>

## Usage with Forms

### Standalone (without form builder)

```erb
<%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  label: "Phone Number",
  default_country: "US",
  placeholder: "Enter your phone number",
  help_text: "We'll never share your phone number"
) %>
```

### With Rails form builder

```erb
<%= form_with model: @user do |form| %>
  <%= render Fluxbit::Form::TelephoneComponent.new(
    form: form,
    attribute: :phone,
    label: "Contact Phone",
    default_country: "BR",
    required: true
  ) %>
<% end %>
```

### With validation errors

```erb
<%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  label: "Phone Number",
  value: @user.phone,
  color: @user.errors[:phone].any? ? :danger : :default,
  help_text: @user.errors[:phone].first
) %>
```

## JavaScript Behavior

The component uses the `fx-telephone` Stimulus controller to handle:

- **Automatic masking**: Phone numbers are formatted as you type based on the selected country
- **Dynamic mask updates**: Changing the country automatically updates the mask and reformats the number
- **Smart backspace**: Handles deletion of mask characters intelligently
- **Number-only input**: Only numeric characters are accepted

The mask uses `#` as a placeholder for digits. For example, the Brazilian mask `(##) #####-####` formats `11999998888` as `(11) 99999-8888`.

## Customization

### Custom country field name

```erb
<%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  country_field_name: "phone_country_code",
  label: "Phone Number"
) %>
```

### With specific sizing

```erb
<!-- Small -->
<%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  sizing: 0
) %>

<!-- Medium (default) -->
<%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  sizing: 1
) %>

<!-- Large -->
<%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  sizing: 2
) %>
```

## Notes

- The component automatically forces the input type to `:tel` for better mobile experience
- The default sizing is 1 (Medium) instead of 0 (Small) for better usability
- Country selection and phone input are submitted as separate fields
- The mask is applied client-side using Stimulus; server-side validation should handle raw numbers
- All TextFieldComponent options (except `type`, `icon`, `addon`, `multiline`) are supported
