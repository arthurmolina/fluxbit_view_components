# Devise Views Generator

The `fluxbit:devise_views` generator creates beautiful authentication views styled with Fluxbit components. It replaces the default Devise views with modern, responsive designs that match your application's aesthetic.

## Overview

This generator creates Devise views using Fluxbit ViewComponents, providing:
- Modern, responsive authentication forms
- Consistent styling with your Fluxbit application
- Custom Devise layout optimized for authentication flows
- Support for all Devise modules
- Multi-language ready views

## Usage

### Generate All Views

```bash
rails generate fluxbit:devise_views
```

This creates views for all Devise modules:
- Sessions (login)
- Registrations (sign up, edit account)
- Passwords (forgot password, reset password)
- Confirmations (email confirmation)
- Unlocks (account unlock)
- Shared partials (links, error messages)
- Mailer templates

### Generate Specific Views

Generate only the views you need:

```bash
# Only login and registration
rails generate fluxbit:devise_views --views sessions registrations

# Only password reset views  
rails generate fluxbit:devise_views --views passwords

# Only email confirmation views
rails generate fluxbit:devise_views --views confirmations
```

### Custom Scope

Generate views for a custom Devise scope:

```bash
# For admin users with custom scope
rails generate fluxbit:devise_views admin --views sessions registrations
```

## Generated Files

### Views Structure

```
app/views/devise/
├── sessions/
│   └── new.html.erb                 # Login form
├── registrations/
│   ├── new.html.erb                 # Sign up form
│   └── edit.html.erb                # Edit account form
├── passwords/
│   ├── new.html.erb                 # Forgot password form
│   └── edit.html.erb                # Reset password form
├── confirmations/
│   └── new.html.erb                 # Resend confirmation form
├── unlocks/
│   └── new.html.erb                 # Unlock account form
├── shared/
│   ├── _links.html.erb              # Authentication links
│   └── _error_messages.html.erb     # Error display
├── mailer/
│   ├── confirmation_instructions.html.erb
│   ├── reset_password_instructions.html.erb
│   ├── unlock_instructions.html.erb
│   ├── email_changed.html.erb
│   └── password_changed.html.erb
└── layouts/
    └── devise.html.erb              # Custom layout for auth
```

## View Examples

### Sign In (sessions/new.html.erb)

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DeviseViewsPreview" scenario="sign_in" panels="params,source"></lookbook-embed>

### Sign up / Registration Form (registrations/new.html.erb)

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DeviseViewsPreview" scenario="sign_up" panels="params,source"></lookbook-embed>

### Remember Password

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::DeviseViewsPreview" scenario="remember_password" panels="params,source"></lookbook-embed>

## Custom Layout

The generator creates a custom layout optimized for authentication:

### Devise Layout (layouts/devise.html.erb)

```erb
&lt;!DOCTYPE html&gt;
&lt;html&gt;
  &lt;head&gt;
    &lt;title&gt;&lt;%= content_for?(:title) ? yield(:title) : "Authentication" %&gt;&lt;/title&gt;
    &lt;meta name="viewport" content="width=device-width,initial-scale=1"&gt;
    &lt;%= csrf_meta_tags %&gt;
    &lt;%= csp_meta_tag %&gt;
    
    &lt;%= stylesheet_link_tag "application", "data-turbo-track": "reload" %&gt;
    &lt;%= javascript_importmap_tags %&gt;
  &lt;/head&gt;

  &lt;body class="bg-gray-50 dark:bg-gray-900"&gt;
    &lt;!-- Flash messages --&gt;
    &lt;% if notice %&gt;
      &lt;div class="fixed top-4 right-4 z-50"&gt;
        &lt;%= fx_alert(color: :success, dismissible: true) do %&gt;
          &lt;%= notice %&gt;
        &lt;% end %&gt;
      &lt;/div&gt;
    &lt;% end %&gt;

    &lt;% if alert %&gt;
      &lt;div class="fixed top-4 right-4 z-50"&gt;
        &lt;%= fx_alert(color: :danger, dismissible: true) do %&gt;
          &lt;%= alert %&gt;
        &lt;% end %&gt;
      &lt;/div&gt;
    &lt;% end %&gt;

    &lt;!-- Main content --&gt;
    &lt;%= yield %&gt;

    &lt;!-- Footer --&gt;
    &lt;footer class="text-center text-gray-600 dark:text-gray-400 py-8"&gt;
      &lt;p&gt;&copy; &lt;%= Date.current.year %&gt; Your Company Name. All rights reserved.&lt;/p&gt;
    &lt;/footer&gt;
  &lt;/body&gt;
&lt;/html&gt;
```

## Configuration

The generator automatically configures Devise to use the custom layout:

```ruby
# Added to config/application.rb
config.to_prepare do
  Devise::SessionsController.layout "devise"
  Devise::RegistrationsController.layout "devise"
  Devise::ConfirmationsController.layout "devise"
  Devise::UnlocksController.layout "devise"
  Devise::PasswordsController.layout "devise"
end
```

## Email Templates

The generator maintain the same original email templates.

## Best Practices

### 1. Customize After Generation
- Generate first, then customize to your needs
- Keep the Fluxbit component structure
- Override styles through CSS classes

### 2. Maintain Consistency
- Use consistent colors and sizing
- Follow your application's design system
- Test all authentication flows

### 3. Security Considerations
- Always use HTTPS in production
- Consider rate limiting for authentication
- Implement proper session management

### 4. Accessibility
- Ensure proper form labels
- Use appropriate ARIA attributes
- Test with screen readers

## Troubleshooting

### Views Not Loading
```ruby
# Check Devise routes
rails routes | grep devise

# Ensure controllers are properly configured
# Check config/application.rb for layout configuration
```

### Styling Issues
```ruby
# Make sure Fluxbit ViewComponents CSS is loaded
# Check application.css includes Fluxbit styles
```

### Custom Scope Issues
```ruby
# For custom scopes, ensure proper routing
devise_for :admins, path: 'admin'

# And generate views with scope
rails generate fluxbit:devise_views admin
```