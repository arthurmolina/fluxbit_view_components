---
label: Password
title: Fluxbit::Form::PasswordComponent or fx_password
---

The `Fluxbit::Form::PasswordComponent` is a password input field component that extends `Fluxbit::Form::TextFieldComponent`.
It provides a password field with a toggleable visibility icon (eye/eye-slash) and optional password strength indicators with customizable requirements.

**Attention: This component isn't used alone. It is used with the other form components.**

To start using the password field you can use the default way to call the component:

```erb
&lt;%= render Fluxbit::Form::PasswordComponent.new(name: "password", label: "Password") %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::Form::PasswordComponent.new(name: "password", label: "Password") do %&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```erb
&lt;%= fx_password(name: "password", label: "Password") %&gt;

&lt;!-- or --&gt;

&lt;%= fx_password(name: "password", label: "Password") do %&gt;
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::PasswordComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param                 | Default  | Description
|:----------------------|:---------|:------------
| name:                 |          | Field name (required unless using a form builder)
| label:                |          | Text label above the field
| placeholder:          |          | Placeholder text shown when empty (supports I18n, pass `false` to disable)
| show_strength:        | false    | Whether to display password strength indicators
| min_length:           | 8        | Minimum password length requirement
| require_uppercase:    | true     | Require at least one uppercase letter
| require_lowercase:    | true     | Require at least one lowercase letter
| require_numbers:      | true     | Require at least one number
| require_special:      | false    | Require at least one special character
| strength_labels:      | {}       | Custom labels for strength checks (keys: `:length`, `:uppercase`, `:lowercase`, `:numbers`, `:special`, `:strength`)
| color:                | :default | State: `:default`, `:success`, `:danger`, `:warning`, `:info`
| help_text:            |          | Help or error text below the field
| helper_popover:       |          | Content for a popover helper
| helper_popover_placement: | "right" | Placement of the popover (`:top`, `:right`, `:bottom`, `:left`)
| sizing:               | 0        | Field size (0 to 2)
| shadow:               | false    | Adds a drop shadow if true
| disabled:             | false    | Disables the input
| readonly:             | false    | Makes the input readonly
| required:             | false    | Marks the field as required
| remove_class:         | ""       | Classes to be removed from the default class list
| wrapper_html:         | {}       | Additional HTML attributes for the wrapper div
| **props               |          | Any other HTML attribute for `&lt;input&gt;`

**Note:** The password component automatically sets `type: :password` and adds an eye icon for visibility toggling. You cannot override the type or right_icon options.

## Slots

This component does not define any named slots. The field content is determined by the form data and input value.

## Examples

### Basic password field

A simple password field without strength indicators.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::PasswordComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Password field with strength indicator

Shows a password strength bar and validation checks for common password requirements.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::PasswordComponentPreview" scenario="with_strength" panels="source"></lookbook-embed>

### Custom requirements

Customize which password requirements are enforced and displayed.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::PasswordComponentPreview" scenario="custom_requirements" panels="source"></lookbook-embed>

### Strict requirements

Enable all password requirements including special characters.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::PasswordComponentPreview" scenario="strict_requirements" panels="source"></lookbook-embed>

### Different sizes

Password fields in different sizes.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::PasswordComponentPreview" scenario="sizes" panels="source"></lookbook-embed>

### Validation states

Password fields with different validation states (default, success, error).

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::PasswordComponentPreview" scenario="validation_states" panels="source"></lookbook-embed>

### With form builder

Using the password component with Rails form builder.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::PasswordComponentPreview" scenario="with_form_builder" panels="source"></lookbook-embed>

### Disabled

A disabled password field.

<lookbook-embed app="/lookbook/" preview="Fluxbit::Form::PasswordComponentPreview" scenario="disabled" panels="source"></lookbook-embed>

## Customization

### Custom strength labels

You can customize the labels for password strength checks:

```erb
&lt;%= render Fluxbit::Form::PasswordComponent.new(
  name: "password",
  show_strength: true,
  strength_labels: {
    length: "Must be at least 12 characters",
    uppercase: "Include uppercase letters (A-Z)",
    lowercase: "Include lowercase letters (a-z)",
    numbers: "Include numbers (0-9)",
    special: "Include special characters (!@#$%)",
    strength: "Password security level"
  }
) %&gt;
```

### Custom requirements

Configure which password requirements are enforced:

```erb
&lt;%= render Fluxbit::Form::PasswordComponent.new(
  name: "password",
  show_strength: true,
  min_length: 12,
  require_uppercase: true,
  require_lowercase: true,
  require_numbers: true,
  require_special: true
) %&gt;
```

### Styling

The password component inherits all styling capabilities from the TextField component and adds additional styles for the strength indicator. You can customize the component's appearance through the configuration:

```ruby
Fluxbit::Config::Form::PasswordComponent.styles[:strength_wrapper] = "mt-3 space-y-3"
Fluxbit::Config::Form::PasswordComponent.styles[:strength_bar] = "h-3 rounded-full transition-all duration-500"
# ... and more
```

## Features

### Password Visibility Toggle

Click the eye icon to toggle between showing and hiding the password. The icon automatically changes from eye to eye-slash when the password is visible.

### Real-time Validation

When `show_strength: true`, the component validates the password in real-time as you type, showing:
- A color-coded strength bar (red < 50%, yellow < 100%, green = 100%)
- Individual check marks for each requirement
- Visual feedback with icons changing from X (red) to checkmark (green)

### Internationalization

The component supports I18n for all labels. Default translations are provided for English and Portuguese (Brazilian):

```yaml
# config/locales/en.yml
en:
  fluxbit:
    form:
      password:
        checks:
          length: At least %{count} characters
          uppercase: Contains uppercase letter
          lowercase: Contains lowercase letter
          numbers: Contains number
          special: Contains special character
        strength: Password strength
```

## Form Builder Integration

Use with Rails form builders:

```erb
&lt;%= form_with(model: @user, builder: Fluxbit::FormBuilder) do |form| %&gt;
  &lt;%= form.fx_password :password,
    label: "Password",
    show_strength: true,
    help_text: "Create a secure password" %&gt;

  &lt;%= form.fx_password :password_confirmation,
    label: "Confirm Password" %&gt;
&lt;% end %&gt;
```

## Accessibility

The password component includes proper ARIA attributes and semantic HTML for accessibility:
- Labels are properly associated with inputs
- Help text is linked via `aria-describedby`
- Icons have appropriate roles and titles
- Validation states are communicated via color and text

## Browser Support

The password component uses standard HTML5 and CSS3 features and is supported in all modern browsers. The Stimulus controller requires JavaScript to be enabled for the visibility toggle and strength indicator features.
