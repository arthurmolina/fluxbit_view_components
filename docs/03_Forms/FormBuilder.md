---
label: Form Builder
title: Fluxbit Form Builder
---

The Fluxbit Form Builder provides a seamless integration with Rails form helpers, allowing you to build beautiful, accessible forms with automatic I18n support, validation states, and consistent styling across your application.

## Overview

Fluxbit form components work seamlessly with Rails' `form_with`, `form_for`, and standalone usage. All form components automatically integrate with your models, ActiveRecord validations, and I18n translations.

## Basic Usage

### With Form Builder

```html
&lt;%= form_with model: @user, url: users_path, builder: Fluxbit::FormBuilder do |form| %&gt;
  &lt;%= form.fx_text_field :email %&gt;
  &lt; form.fx_text_field :password, type: :password %&gt;
  &lt;%= form.fx_select :role, ["Admin", "User", "Guest"] %&gt;
  &lt;%= form.fx_checkbox :terms_accepted %&gt;
  &lt;%= form.fx_submit "Create Account" %&gt;
&lt; end %&gt;
```

### Standalone Usage

```html
&lt; fx_text_field name: "email", label: "Email Address", placeholder: "Enter your email" %&gt;
&lt; fx_select "role", ["Admin", "User", "Guest"], prompt: "Select a role" %&gt;
&lt; fx_checkbox name: "terms", label: "I accept the terms" %&gt;
```

## Available Form Components

| Component   | Helper Method            | Description |
|:------------|:-------------------------|:------------|
| TextField   | `fx_text_field`          | Text input, textarea, email, password, number, etc. |
|             | `fx_color_field`         | |
|             | `fx_number_field`        | |
|             | `fx_email_field`         | |
|             | `fx_password_field`      | |
|             | `fx_search_field`        | |
|             | `fx_tel_field`           | |
|             | `fx_url_field`           | |
|             | `fx_date_field`          | |
|             | `fx_datetime_local_field`| |
|             | `fx_month_field`         | |
|             | `fx_time_field`          | |
|             | `fx_week_field`          | |
|             | `fx_currency_field`      | |
|             | `fx_text_area`           | |
|             | `fx_textarea`            | |
| Select      | `fx_select`              | Dropdown select with single or multiple selection |
| Checkbox    | `fx_checkbox`            | Single checkbox or checkbox group |
| Toggle      | `fx_toggle`              | Toggle switch (styled checkbox) |
| Radio       | `fx_radio`               | Radio button group |
| Range       | `fx_range`               | Range slider input |
| UploadImage | `fx_upload_image`        | File upload with drag and drop |
| Dropzone    | `fx_dropzone`            | File upload with drag and drop |

## Internationalization (I18n)

One of the most powerful features of Fluxbit form components is automatic I18n support. Components automatically look up translations based on your model name and attribute names.

### Translation Structure

The I18n lookup follows this structure:

```yaml
en:
  model_name:           # Pluralized, underscored model name (e.g., "users", "blog_posts")
    fields:             # Field labels
      attribute_name: "Display Label"
    help_text:          # Help text shown below fields
      attribute_name: "Helpful information"
    helper_popover:     # Popover content (info icon next to label)
      attribute_name: "Additional context"
    placeholders:       # Placeholder text for inputs
      attribute_name: "Placeholder text"
    prompts:            # Prompt text for select dropdowns
      attribute_name: "Select an option"
```

### Complete Example

Here's a complete example for a User model:

```yaml
# config/locales/en.yml
en:
  users:
    fields:
      email: "Email Address"
      password: "Password"
      first_name: "First Name"
      last_name: "Last Name"
      role: "User Role"
      country: "Country"
      bio: "Biography"
      terms_accepted: "Terms & Conditions"
      newsletter_subscribed: "Newsletter Subscription"

    help_text:
      email: "We'll never share your email with anyone"
      password: "Must be at least 8 characters with letters and numbers"
      role: "This determines the user's permissions in the system"
      country: "Your country affects shipping rates and tax calculations"
      bio: "Tell us about yourself (max 500 characters)"
      terms_accepted: "You must accept the terms to continue"

    helper_popover:
      password: "Use a mix of uppercase, lowercase, numbers, and special characters for better security"
      role: "Admins have full access, Users have limited access, Guests can only view"
      newsletter_subscribed: "You can unsubscribe at any time from your account settings"

    placeholders:
      email: "you@example.com"
      password: "Enter a secure password"
      first_name: "John"
      last_name: "Doe"
      bio: "Tell us about yourself..."

    prompts:
      role: "Select a role"
      country: "Choose your country"
```

### Using I18n in Forms

With the translations in place, your forms become much cleaner:

```html
&lt;%= form_with model: @user do |form| %&gt;
  &lt;%# All labels, help text, placeholders automatically loaded from I18n %&gt;
  &lt;%= form.fx_text_field :email %&gt;
  &lt;%= form.fx_text_field :password, type: :password %&gt;
  &lt;%= form.fx_text_field :first_name %&gt;
  &lt;%= form.fx_text_field :last_name %&gt;
  &lt;%= form.fx_text_field :bio, multiline: true %&gt;
  &lt;%= form.fx_select :role, ["Admin", "User", "Guest"] %&gt;
  &lt;%= form.fx_select :country, countries_collection %&gt;
  &lt;%= form.fx_checkbox :terms_accepted %&gt;
  &lt;%= form.fx_checkbox :newsletter_subscribed %&gt;
  &lt;%= form.fx_submit "Create Account" %&gt;
&lt;% end %&gt;
```

This form will automatically display:
- Labels from the `fields` section
- Help text from the `help_text` section
- Popover information from the `helper_popover` section
- Placeholders from the `placeholders` section
- Select prompts from the `prompts` section

### Override Behavior

You can override I18n translations in three ways:

#### 1. Provide a Custom Value

```html
&lt;%# Override the I18n label with a custom label %&gt;
&lt;%= form.fx_text_field :email, label: "Email (Required)" %&gt;

&lt;%# Override the placeholder %&gt;
&lt;%= form.fx_text_field :email, placeholder: "user@company.com" %&gt;

&lt;%# Override the help text %&gt;
&lt;%= form.fx_text_field :password, help_text: "Custom help text here" %&gt;
```

#### 2. Disable Automatic Lookup

```html
&lt;%# Disable the label (no label will be shown) %&gt;
&lt;%= form.fx_text_field :email, label: false %&gt;

&lt;%# Disable the placeholder %&gt;
&lt;%= form.fx_text_field :email, placeholder: false %&gt;

&lt;%# Disable the help text %&gt;
&lt;%= form.fx_text_field :email, help_text: false %&gt;

&lt;%# Disable the prompt in selects %&gt;
&lt;%= form.fx_select :role, roles, prompt: false %&gt;
```

#### 3. Use Default Behavior

```html
&lt;%# Leave blank to use I18n lookup %&gt;
&lt;%= form.fx_text_field :email %&gt;
```

### Fallback Behavior

When I18n translations are not found, the components use sensible defaults:

| Attribute | Fallback Behavior |
|:---------------|:-------------|
| Label          | Uses `Model.human_attribute_name(:attribute)` or humanized attribute name |
| Help Text      | No help text shown |
| Helper Popover | No popover shown |
| Placeholder    | No placeholder shown |
| Prompt         | No prompt shown (except when explicitly set to `true`, which uses "Please select") |

## Validation States

Fluxbit form components automatically integrate with ActiveRecord validations and display errors.

### Automatic Error Display

When a model has validation errors, components automatically:
- Change color to danger/error state
- Display error messages as help text
- Add appropriate ARIA attributes for accessibility

```html
&lt;%# If @user.errors[:email] contains errors, they will automatically display %&gt;
&lt;%= form.fx_text_field :email %&gt;
```

### Manual Validation States

You can manually set validation states using the `color` parameter:

```html
&lt;%# Success state %&gt;
&lt;%= form.fx_text_field :email, color: :success %&gt;

&lt;%# Error/Danger state %&gt;
&lt;%= form.fx_text_field :email, color: :danger %&gt;

&lt;%# Warning state %&gt;
&lt;%= form.fx_text_field :email, color: :warning %&gt;

&lt;%# Info state %&gt;
&lt;%= form.fx_text_field :email, color: :info %&gt;

&lt;%# Default state %&gt;
&lt;%= form.fx_text_field :email, color: :default %&gt;
```

## Complete Form Example

Here's a complete form demonstrating all features:

```html
&lt;%= form_with model: @user, url: users_path, local: true do |form| %&gt;
  &lt;div class="space-y-6"&gt;
    &lt;%# Basic Information Section %&gt;
    &lt;div class="bg-white p-6 rounded-lg shadow"&gt;
      &lt;h2&gt; class="text-xl font-semibold mb-4"&gt;Basic Information&lt;/h2&gt;

      &lt;div class="grid grid-cols-1 md:grid-cols-2 gap-4"&gt;
        &lt;%= form.fx_text_field :first_name, required: true %&gt;
        &lt;%= form.fx_text_field :last_name, required: true %&gt;
      &lt;/div&gt;

      &lt;%= form.fx_text_field :email, type: :email, required: true, icon: :mail %&gt;
      &lt;%= form.fx_text_field :password, type: :password, required: true, icon: :lock %&gt;

      &lt;%= form.fx_text_field :bio, multiline: true, sizing: 2 %&gt;
    &lt;/div&gt;

    &lt;%# Account Settings Section %&gt;
    &lt;div class="bg-white p-6 rounded-lg shadow"&gt;
      &lt;h2&gt; class="text-xl font-semibold mb-4"&gt;Account Settings&lt;/h2&gt;

      &lt;%= form.fx_select :role,
          ["Admin", "User", "Guest"],
          { include_blank: false } %&gt;

      &lt;%= form.fx_select :country,
          options_from_collection_for_select(@countries, :code, :name),
          {} %&gt;

      &lt;%= form.fx_select :timezone,
          time_zone: true %&gt;
    &lt;/div&gt;

    &lt;%# Preferences Section %&gt;
    &lt;div class="bg-white p-6 rounded-lg shadow"&gt;
      &lt;h2&gt; class="text-xl font-semibold mb-4"&gt;Preferences&lt;/h2&gt;

      &lt;%= form.fx_checkbox :terms_accepted, required: true %&gt;
      &lt;%= form.fx_toggle :newsletter_subscribed %&gt;
      &lt;%= form.fx_toggle :email_notifications %&gt;
    &lt;/div&gt;

    &lt;%# Submit Button %&gt;
    &lt;div class="flex justify-end gap-3"&gt;
      &lt;%= link_to "Cancel", users_path, class: "px-4 py-2 border rounded" %&gt;
      &lt;%= form.fx_submit "Create Account", color: :primary %&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;% end %&gt;
```

## Multi-Language Support

Fluxbit form components make it easy to support multiple languages:

```yaml
# config/locales/en.yml
en:
  users:
    fields:
      email: "Email Address"
      password: "Password"
    placeholders:
      email: "you@example.com"
    prompts:
      role: "Select a role"

# config/locales/pt-BR.yml
pt-BR:
  users:
    fields:
      email: "Endereço de Email"
      password: "Senha"
    placeholders:
      email: "voce@exemplo.com.br"
    prompts:
      role: "Selecione uma função"

# config/locales/es.yml
es:
  users:
    fields:
      email: "Dirección de Correo"
      password: "Contraseña"
    placeholders:
      email: "tu@ejemplo.com"
    prompts:
      role: "Seleccionar un rol"
```

The same form code works for all languages - just change `I18n.locale`:

```ruby
# application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
```

## Form Builder Methods

All standard Rails form builder methods are available with the `fx_` prefix:

### Text Inputs
- `fx_text_field` - Standard text input
- `fx_email_field` - Email input (alias: `fx_text_field(type: :email)`)
- `fx_password_field` - Password input (alias: `fx_text_field(type: :password)`)
- `fx_number_field` - Number input (alias: `fx_text_field(type: :number)`)
- `fx_url_field` - URL input (alias: `fx_text_field(type: :url)`)
- `fx_telephone_field` - Phone input (alias: `fx_text_field(type: :tel)`)
- `fx_text_area` - Multi-line text (alias: `fx_text_field(multiline: true)`)

### Select Inputs
- `fx_select` - Dropdown select
- `fx_time_zone_select` - Time zone select (alias: `fx_select(time_zone: true)`)

### Checkboxes and Radios
- `fx_checkbox` - Single checkbox or checkbox group
- `fx_toggle` - Toggle switch
- `fx_radio` - Radio button group

### Other Inputs
- `fx_range` - Range slider
- `fx_dropzone` - File upload with drag and drop

### Buttons
- `fx_submit` - Submit button
- `fx_button` - Generic button

## Best Practices

### 1. Use I18n for All User-Facing Text

```html
&lt;%# Good: Uses I18n %&gt;
&lt;%= form.fx_text_field :email %&gt;

&lt;%# Avoid: Hardcoded text %&gt;
&lt;%= form.fx_text_field :email, label: "Email", placeholder: "Enter email" %&gt;
```

### 2. Organize Translations by Model

Keep your translation files organized by model for easier maintenance:

```
config/locales/
  en/
    users.yml
    products.yml
    orders.yml
  pt-BR/
    users.yml
    products.yml
    orders.yml
```

### 3. Use Validation States Appropriately

```html
&lt;%# Let errors display automatically %&gt;
&lt;%= form.fx_text_field :email %&gt;

&lt;%# Only override when you have a specific reason %&gt;
&lt;%= form.fx_text_field :email, color: :success if @user.email_verified? %&gt;
```

### 4. Group Related Fields

Use HTML structure to group related fields:

```html
&lt;div class="form-section"&gt;
  &lt;h3&gt;Contact Information&lt;/h3&gt;
  &lt;%= form.fx_text_field :email %&gt;
  &lt;%= form.fx_text_field :phone %&gt;
&lt;/div&gt;

&lt;div class="form-section"&gt;
  &lt;h3&gt;Address&lt;/h3&gt;
  &lt;%= form.fx_text_field :street %&gt;
  &lt;%= form.fx_text_field :city %&gt;
&lt;/div&gt;
```

### 5. Provide Helpful Context

Use helper popovers for complex fields:

```yaml
en:
  users:
    helper_popover:
      api_key: "Your API key is used to authenticate requests. Keep it secret and never share it publicly."
      webhook_url: "Enter the URL where you want to receive webhook notifications. Must be HTTPS."
```

## Accessibility

All Fluxbit form components are built with accessibility in mind:

- Proper `&lt;label&gt;` elements with `for` attributes
- ARIA attributes for validation states
- Keyboard navigation support
- Screen reader friendly error messages
- Required field indicators

```html
&lt;%# Automatically accessible %&gt;
&lt;%= form.fx_text_field :email, required: true %&gt;

&lt;%# Renders with proper ARIA attributes:
  - aria-required="true"
  - aria-invalid="true" (if errors)
  - aria-describedby="email_help" (if help text)
%&gt;
```

## Common Patterns

### Conditional Fields

```html
&lt;%= form.fx_select :account_type, ["Personal", "Business"] %&gt;

&lt;%= form.fx_text_field :company_name if @user.account_type == "Business" %&gt;
```

### Dynamic Options

```html
&lt;%= form.fx_select :country,
    options_from_collection_for_select(@countries, :id, :name, @user.country_id) %&gt;

&lt;%= form.fx_select :state,
    options_from_collection_for_select(@states, :id, :name, @user.state_id),
    { prompt: true },
    { data: { dependent_on: "user_country" } } %&gt;
```

### File Uploads

```html
&lt;%= form.fx_dropzone :avatar,
    accept: "image/*",
    max_size: 5.megabytes,
    help_text: "Upload a profile photo (max 5MB)" %&gt;
```

### Array Fields

```html
&lt;%= form.fx_text_field :tags,
    value: @user.tags.join(", "),
    placeholder: "ruby, rails, javascript",
    help_text: "Separate tags with commas" %&gt;
```

## Troubleshooting

### Translations Not Loading

1. Check your I18n file structure:
   ```yaml
   en:
     users:  # Must be pluralized model name
       fields:
         email: "Email"
   ```

2. Verify your locale is set:
   ```ruby
   I18n.locale  # => :en
   ```

3. Check if translations exist:
   ```ruby
   I18n.exists?(:email, scope: [:users, :fields])  # => true/false
   ```

### Errors Not Displaying

1. Ensure your model has errors:
   ```ruby
   @user.errors.any?  # => true
   ```

2. Check the attribute has errors:
   ```ruby
   @user.errors[:email]  # => ["can't be blank"]
   ```

3. Verify you're using a form builder:
   ```html
   &lt;%= form_with model: @user do |form| %&gt;
     &lt;%= form.fx_text_field :email %&gt;  &lt;%# Will show errors %&gt;
   &lt;% end %&gt;
   ```

### Custom Styling Not Applied

1. Check if classes are being removed:
   ```html
   &lt;%= form.fx_text_field :email, remove_class: "unwanted-class" %&gt;
   ```

2. Ensure custom classes are added after component initialization:
   ```html
   &lt;%= form.fx_text_field :email, class: "custom-class" %&gt;
   ```

## See Also

- [TextField Component](TextField.md) - Detailed text field documentation
- [Select Component](Select.md) - Detailed select documentation
- [Checkbox Component](Checkbox.md) - Checkbox and toggle documentation
- [Rails I18n Guide](https://guides.rubyonrails.org/i18n.html) - Rails internationalization guide
