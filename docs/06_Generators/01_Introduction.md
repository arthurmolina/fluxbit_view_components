---
label: Introduction
title: Introduction to Fluxbit Generators
---

Fluxbit ViewComponents includes powerful Rails generators that help you quickly scaffold complete CRUD applications using Fluxbit components. These generators create production-ready code with modern Rails patterns including Turbo Streams, Hotwire, and authorization.

## Available Generators

### 1. Scaffold Generator
The main generator that creates a complete CRUD interface with:
- Controllers with full CRUD operations and bulk actions
- Views using Fluxbit components (tables, forms, modals, etc.)
- Pundit policies for authorization
- Turbo Stream responses for dynamic updates
- Multi-language support (i18n)
- JSON API responses (Jbuilder)

### 2. Devise Views Generator
Generates Devise authentication views styled with Fluxbit components:
- Login and registration forms
- Password reset views
- Account confirmation views
- Custom Devise layout


## Key Features

### Modern Rails Patterns
- **Turbo Streams**: Dynamic page updates without full page reloads
- **Hotwire**: Enhanced interactivity with minimal JavaScript
- **ViewComponents**: Reusable, testable UI components
- **Pundit**: Authorization with policies

### Fluxbit Integration
- **Complete UI**: Tables, forms, buttons, badges, modals, and more
- **Responsive Design**: Mobile-first approach with Tailwind CSS
- **Dark Mode**: Support for light and dark themes
- **Accessibility**: ARIA-compliant components

### Developer Experience
- **Flexible Options**: Customizable generator options
- **Bulk Operations**: Built-in support for batch actions
- **Search & Filter**: Pre-built filtering and search functionality
- **Pagination**: Pagy pagination support
- **Multi-language**: i18n support for English and Portuguese
- **CSV Export**: Built-in CSV export functionality

## Quick Start

Generate a complete CRUD interface:

```bash
rails generate fluxbit:scaffold Product name:string price:decimal category:string
```

This single command creates:
- Product model and migration
- ProductsController with CRUD and bulk actions
- Complete set of views with Fluxbit components
- Pundit policy for authorization
- Turbo Stream templates for dynamic updates
- i18n files for multi-language support
- JSON API endpoints
- CSV export functionality

## Installation

The generators are included with the Fluxbit ViewComponents gem. After installing the gem, you can immediately use any of the available generators:

```bash
# Install the gem
bundle add fluxbit_view_components

# Run the installer
rails generate fluxbit_view_components:install

# Start generating scaffolds
rails generate fluxbit:scaffold ModelName attribute:type
```

## File Structure

The generators create files following Rails conventions:

```
app/
├── controllers/
│   └── products_controller.rb          # Full CRUD controller
├── models/
│   └── product.rb                      # Active Record model
├── policies/
│   └── product_policy.rb               # Pundit authorization
├── views/
│   ├── products/
│   │   ├── index.html.erb              # List view with table
│   │   ├── show.html.erb               # Detail view
│   │   ├── new.html.erb                # Create form
│   │   ├── edit.html.erb               # Edit form
│   │   ├── _form.html.erb              # Shared form partial
│   │   ├── _products.html.erb          # Table row partial
│   │   ├── _metadata.html.erb          # Metadata partial
│   │   ├── create.turbo_stream.erb     # Create response
│   │   ├── update.turbo_stream.erb     # Update response
│   │   ├── destroy.turbo_stream.erb    # Delete response
│   │   ├── update_all.turbo_stream.erb # Bulk update response
│   │   ├── destroy_all.turbo_stream.erb# Bulk delete response
│   │   ├── index.json.jbuilder         # JSON API list
│   │   └── show.json.jbuilder          # JSON API detail
│   └── shared/
│       ├── _alert.html.erb             # Alert component
│       └── _flash.html.erb             # Flash messages
├── config/
│   ├── routes.rb                       # RESTful routes + bulk actions
│   └── locales/
│       ├── products.en.yml             # English translations
│       └── products.pt-BR.yml          # Portuguese translations
└── db/
    └── migrate/
        └── create_products.rb          # Database migration
```

## Next Steps

- [Scaffold Generator](./02_Scaffold_Generator.md) - Complete reference for the main generator
- [Configuration Options](./03_Configuration.md) - Customize generator behavior
- [Examples](./04_Examples.md) - Real-world usage examples
- [Devise Views Generator](./05_Devise_Views.md) - Authentication views