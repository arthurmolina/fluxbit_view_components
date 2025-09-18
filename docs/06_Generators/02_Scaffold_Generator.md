# Scaffold Generator

The `fluxbit:scaffold` generator is the main generator in Fluxbit ViewComponents. It creates a complete CRUD application with modern Rails patterns, Fluxbit UI components, and production-ready features.

## Basic Usage

```bash
rails generate fluxbit:scaffold ModelName attribute:type attribute:type
```

### Example

```bash
rails generate fluxbit:scaffold Product name:string price:decimal category:string stock:integer description:text
```

This creates a complete Product CRUD interface with:
- Full controller with CRUD operations
- Responsive table view with sorting and filtering
- Modal-based forms (configurable)
- Bulk actions (update/delete multiple records)
- Authorization with Pundit
- Turbo Stream responses
- Multi-language support

## Command Options

### UI Interaction (`--ui`)
Controls how forms are presented to users.

```bash
# Modal forms (default)
rails generate fluxbit:scaffold Product name:string --ui=modal

# Drawer (sidebar) forms  
rails generate fluxbit:scaffold Product name:string --ui=drawer

# Traditional page-based forms
rails generate fluxbit:scaffold Product name:string --ui=none
```

**Modal (default)**: Forms open in overlay modals, perfect for quick operations
**Drawer**: Forms slide in from the side, great for complex forms
**None**: Traditional separate pages for forms

### Turbo Streams (`--turbo`)
Enable or disable Turbo Stream responses for dynamic updates.

```bash
# With Turbo Streams (default)
rails generate fluxbit:scaffold Product name:string --turbo

# Without Turbo Streams (traditional page redirects)
rails generate fluxbit:scaffold Product name:string --no-turbo
```

### Pagination (`--paginator`)
Choose your pagination library.

```bash
# Pagy (default, fastest)
rails generate fluxbit:scaffold Product name:string --paginator=pagy

# Kaminari (popular alternative)
rails generate fluxbit:scaffold Product name:string --paginator=kaminari

# WillPaginate (classic choice)
rails generate fluxbit:scaffold Product name:string --paginator=will_paginate
```

### Authorization (`--pundit`)
Include or exclude Pundit authorization.

```bash
# With Pundit (default)
rails generate fluxbit:scaffold Product name:string --pundit

# Without Pundit
rails generate fluxbit:scaffold Product name:string --no-pundit
```

## Generated Files

### Controller
**File**: `app/controllers/products_controller.rb`

Features:
- Full CRUD operations (index, show, new, create, edit, update, destroy)
- Bulk operations (update_all, destroy_all)
- Search and filtering
- Sorting with multiple column support
- Pagination
- Pundit authorization
- Turbo Stream responses
- JSON API endpoints

### Views

### Turbo Stream Templates


### Policy (Pundit)
**File**: `app/policies/product_policy.rb`

### Routes
**Added to**: `config/routes.rb`

### Internationalization
**Files**: 
- `config/locales/products.en.yml`
- `config/locales/products.pt-BR.yml`


## Advanced Features

### Search and Filtering
The generator creates intelligent search and filtering based on attribute types:

- **String/Text fields**: LIKE queries for partial matching
- **Numeric fields**: Range filtering (greater than or equal)
- **Boolean fields**: Exact matching
- **Date fields**: Date range filtering

### Sorting
Click any column header to sort. Supports:
- Ascending/Descending toggle
- Multiple column sorting
- Persistent sort state in URL

### Bulk Actions
Select multiple records and:
- Update all selected records
- Delete all selected records
- Custom bulk operations (extensible)

### Modal/Drawer Forms
Depending on the `--ui` option:

#### Modal Forms
```erb
<!-- Trigger button -->
<%%= fx_button(
  data: { 
    action: "fx-modal#show",
    "fx-modal-target": "product-modal"
  }
) do %>
  New Product
<%% end %>

<!-- Modal -->
<%%= fx_modal(id: "product-modal") do %>
  <%%= render "form", product: @product %>
<%% end %>
```

#### Drawer Forms
```erb
<!-- Trigger button -->
<%%= fx_button(
  data: {
    action: "fx-drawer#show", 
    "fx-drawer-target": "product-drawer"
  }
) do %>
  New Product
<%% end %>

<!-- Drawer -->
<%%= fx_drawer(id: "product-drawer", position: :right) do %>
  <%%= render "form", product: @product %>
<%% end %>
```

### JSON API
Each scaffold includes JSON endpoints:

```ruby
# GET /products.json
def index
  # Returns paginated JSON
end

# GET /products/1.json  
def show
  # Returns single product JSON
end
```

With Jbuilder templates:
```ruby
# app/views/products/index.json.jbuilder
json.products @products do |product|
  json.id product.id
  json.name product.name
  json.price product.price
  json.url product_url(product, format: :json)
end

json.pagination do
  json.page @pagy.page
  json.pages @pagy.pages
  json.count @pagy.count
end
```

## Customization

### Override Templates
Copy generator templates to your app:

```bash
rails generate fluxbit:scaffold --help
# Shows template locations for customization
```

### Extend Controllers
The generated controllers include extension points:

```ruby
class ProductsController < ApplicationController
  private

  def product_params
    params.require(:product).permit(:name, :price, :category, :description)
  end

  # Add custom filtering logic
  def apply_custom_filters(scope)
    scope = scope.where(featured: true) if params[:featured]
    scope
  end
end
```

### Custom Pundit Policies
Extend the generated policy:

```ruby
class ProductPolicy < ApplicationPolicy
  def featured?
    user.present? && user.premium?
  end

  def export?
    user.present? && user.admin?
  end
end
```

## Best Practices

1. **Start Simple**: Use default options first, then customize
2. **Review Generated Code**: Understand what's created before customizing
3. **Test Authorization**: Verify Pundit policies match your requirements
4. **Customize Incrementally**: Make small changes and test
5. **Use Version Control**: Commit after generation to track changes

## Troubleshooting

### Common Issues

**Generator not found**
```bash
# Make sure the gem is installed
bundle install
bundle exec rails generate fluxbit:scaffold --help
```

**Missing dependencies**
```bash
# Install required gems
bundle add pundit  # for authorization
bundle add pagy    # for pagination (if using)
```

**Turbo conflicts**
```bash
# Ensure Turbo is properly configured
# Check app/javascript/application.js includes Turbo
```

**Authorization errors**
```ruby
# In ApplicationController, ensure Pundit is included
include Pundit::Authorization
```