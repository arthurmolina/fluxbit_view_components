---
label: Telephone
title: Fluxbit::Form::TelephoneComponent
---

The `Fluxbit::Form::TelephoneComponent` is a specialized telephone input component that extends `Fluxbit::Form::TextFieldComponent`.
It provides a telephone number input with an integrated country code selector that displays country flags and international dialing codes. The component includes automatic phone number masking that adapts to the selected country's phone format.

**Attention: This component extends TextFieldComponent and inherits all of its functionality.**

To start using the telephone field you can use the default way to call the component:

```erb
&lt;%= render Fluxbit::Form::TelephoneComponent.new(name: "phone", label: "Phone Number") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::TelephoneComponent.new(name: "phone", label: "Phone Number") do %&gt;
&lt;% end %&gt;
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
| country:           |          | Attribute name for the country field when using form builder (e.g., `:phone_country`)
| country_field_name:|          | Custom name for the country select field (standalone mode, defaults to `{name}_country`)
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

The component supports **31 countries** by default, with their respective masks:

**Latin America (19 countries):**
- 🇧🇷 Brazil (+55): `(##) #####-####`
- 🇦🇷 Argentina (+54): `## ####-####`
- 🇲🇽 Mexico (+52): `## #### ####`
- 🇨🇴 Colombia (+57): `### ### ####`
- 🇨🇱 Chile (+56): `# #### ####`
- 🇵🇪 Peru (+51): `### ### ###`
- 🇻🇪 Venezuela (+58): `###-###-####`
- 🇪🇨 Ecuador (+593): `## ### ####`
- 🇧🇴 Bolivia (+591): `# ### ####`
- 🇵🇾 Paraguay (+595): `### ### ###`
- 🇺🇾 Uruguay (+598): `# ### ## ##`
- 🇨🇷 Costa Rica (+506): `#### ####`
- 🇵🇦 Panama (+507): `####-####`
- 🇨🇺 Cuba (+53): `# ### ####`
- 🇩🇴 Dominican Republic (+1): `(###) ###-####`
- 🇬🇹 Guatemala (+502): `#### ####`
- 🇭🇳 Honduras (+504): `####-####`
- 🇸🇻 El Salvador (+503): `####-####`
- 🇳🇮 Nicaragua (+505): `#### ####`

**Other Regions (12 countries):**
- 🇺🇸 United States (+1): `(###) ###-####`
- 🇨🇦 Canada (+1): `(###) ###-####`
- 🇪🇸 Spain (+34): `### ## ## ##`
- 🇵🇹 Portugal (+351): `### ### ###`
- 🇬🇧 United Kingdom (+44): `#### ### ####`
- 🇩🇪 Germany (+49): `### #########`
- 🇫🇷 France (+33): `# ## ## ## ##`
- 🇮🇹 Italy (+39): `### ### ####`
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
&lt;%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  label: "Phone Number",
  default_country: "US",
  placeholder: "Enter your phone number",
  help_text: "We'll never share your phone number"
) %&gt;
```

### With Rails form builder

```erb
&lt;%= form_with model: @user do |form| %&gt;
  &lt;%= render Fluxbit::Form::TelephoneComponent.new(
    form: form,
    attribute: :phone,
    label: "Contact Phone",
    default_country: "BR",
    required: true
  ) %&gt;
&lt;% end %&gt;
```

### With form builder and separate country attribute

When you want the country code stored in a separate database column:

```erb
&lt;%= form_with model: @user do |form| %&gt;
  &lt;%= form.fx_telephone :phone,
      country: :phone_country,
      label: "Contact Phone",
      required: true %&gt;
&lt;% end %&gt;
```

This will create two fields:
- `user[phone]` - The phone number
- `user[phone_country]` - The country code (e.g., "BR", "US")

### With validation errors

```erb
&lt;%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  label: "Phone Number",
  value: @user.phone,
  color: @user.errors[:phone].any? ? :danger : :default,
  help_text: @user.errors[:phone].first
) %&gt;
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
&lt;%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  country_field_name: "phone_country_code",
  label: "Phone Number"
) %&gt;
```

### With specific sizing

```erb
&lt;!-- Small --&gt;
&lt;%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  sizing: 0
) %&gt;

&lt;!-- Medium (default) --&gt;
&lt;%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  sizing: 1
) %&gt;

&lt;!-- Large --&gt;
&lt;%= render Fluxbit::Form::TelephoneComponent.new(
  name: "phone",
  sizing: 2
) %&gt;
```

## Configuration

The component can be configured globally through an initializer. All settings have sensible defaults but can be customized to fit your needs.

### Available Configuration Options

Create or edit `config/initializers/fluxbit.rb`:

```ruby
# Configure TelephoneComponent defaults
Fluxbit::Config::Form::TelephoneComponent.default_country = "US"
Fluxbit::Config::Form::TelephoneComponent.default_sizing = 1

# Add custom countries
Fluxbit::Config::Form::TelephoneComponent.countries &lt;&lt; {
  code: "NZ",
  name: "New Zealand",
  dial_code: "+64",
  flag: "🇳🇿",
  mask: "## ### ####"
}

# Replace all countries with your own list
Fluxbit::Config::Form::TelephoneComponent.countries = [
  { code: "BR", name: "Brasil", dial_code: "+55", flag: "🇧🇷", mask: "(##) #####-####" },
  { code: "US", name: "USA", dial_code: "+1", flag: "🇺🇸", mask: "(###) ###-####" }
  # ... your countries
]

# Customize styles
Fluxbit::Config::Form::TelephoneComponent.styles[:country_select][:width] = "w-32"
```

### Configuration Reference

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `default_country` | String | `"BR"` | Default country code (ISO 3166-1 alpha-2) |
| `default_sizing` | Integer | `1` | Default size: 0 (Small), 1 (Medium), 2 (Large) |
| `countries` | Array | 31 countries | List of supported countries with masks |
| `styles` | Hash | Tailwind classes | Styling configuration for select and input |

### Country Object Structure

Each country in the `countries` array should have:

```ruby
{
  code: "BR",              # ISO 3166-1 alpha-2 country code
  name: "Brasil",          # Country name
  dial_code: "+55",        # International dial code
  flag: "🇧🇷",             # Country flag emoji
  mask: "(##) #####-####"  # Phone number mask (# = digit)
}
```

### Customizing Styles

You can customize the appearance by modifying the styles configuration:

```ruby
# Change select width
Fluxbit::Config::Form::TelephoneComponent.styles[:country_select][:width] = "w-32"

# Customize colors
Fluxbit::Config::Form::TelephoneComponent.styles[:country_select][:colors][:default] =
  "text-blue-900 bg-blue-50 border-blue-300"

# Adjust sizes
Fluxbit::Config::Form::TelephoneComponent.styles[:country_select][:sizes][1] = {
  padding: "p-3",
  text: "text-base"
}
```

## Notes

- The component automatically forces the input type to `:tel` for better mobile experience
- The default sizing is 1 (Medium) instead of 0 (Small) for better usability
- Country selection and phone input are submitted as separate fields
- The mask is applied client-side using Stimulus; server-side validation should handle raw numbers
- All TextFieldComponent options (except `type`, `icon`, `addon`, `multiline`) are supported
- All configuration is optional - the component works with sensible defaults out of the box
