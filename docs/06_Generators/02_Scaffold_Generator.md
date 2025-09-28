---
label: Scaffold Generator
title: Scaffold Generator
---

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
Enable or disable pagination using Pagy.

```bash
# With pagination (default)
rails generate fluxbit:scaffold Product name:string --paginator

# Without pagination
rails generate fluxbit:scaffold Product name:string --no-paginator
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

```ruby
resources :products do
  collection do
    put "update_all"
    patch "update_all"
    delete "destroy_all"
  end
end
```

### Internationalization
**Files**:
- `config/locales/products.en.yml`
- `config/locales/products.pt-BR.yml`

### Shared Partials
**Files**:
- `app/views/shared/_alert.html.erb` - Alert component partial
- `app/views/shared/_flash.html.erb` - Flash message partial

These partials use Fluxbit components and are reusable across your application.

## Advanced Features

### Search and Filtering
The generator creates intelligent search and filtering based on attribute types with auto-submit functionality:

- **String/Text fields**: LIKE queries for partial matching
- **Numeric fields**: Range filtering (greater than or equal)
- **Boolean fields**: Exact matching
- **Date fields**: Date range filtering
- **Auto-submit**: Form automatically submits when fields change (using fx-auto-submit controller)
- **Clear filters**: One-click button to remove all active filters

### Sorting
Click any column header to sort. Supports:
- Ascending/Descending toggle
- Multiple column sorting
- Persistent sort state in URL

### Bulk Actions
Select multiple records using the master checkbox or individual selections and:
- Update all selected records (PATCH/PUT /products/update_all)
- Delete all selected records (DELETE /products/destroy_all)
- Bulk actions are disabled when no records are selected
- Uses fx-select-all controller for selection management
- Custom bulk operations (extensible)

### CSV Export
Built-in CSV export functionality:
- **URL**: GET /products.csv
- **Features**: Exports all products with applied filters
- **Format**: Standard CSV with column headers
- **Usage**: Automatic download when accessed

### Modal/Drawer Forms
Depending on the `--ui` option, forms are displayed differently:

#### Modal Forms (`--ui=modal`)
Forms open in overlay modals using Turbo Frames:
```html
&lt;!-- Turbo frame for modal content --&gt;
&lt;turbo-frame id="modal"&gt;&lt;/turbo-frame&gt;

&lt;!-- New button with turbo_frame target --&gt;
&lt;%= fx_button(
  as: :a,
  href: new_product_path,
  data: { turbo_frame: "modal" }
) do %&gt;
  New Product
&lt;% end %&gt;
```

#### Drawer Forms (`--ui=drawer`)
Forms slide in from the side using Turbo Frames:
```html
&lt;!-- Turbo frame for drawer content --&gt;
&lt;turbo-frame id="drawer"&gt;&lt;/turbo-frame&gt;

&lt;!-- New button with turbo_frame target --&gt;
&lt;%= fx_button(
  as: :a,
  href: new_product_path,
  data: { turbo_frame: "drawer" }
) do %&gt;
  New Product
&lt;% end %&gt;
```

#### Traditional Forms (`--ui=none`)
Forms are displayed on separate pages without overlays.

### JSON API and CSV Export
Each scaffold includes JSON endpoints and CSV export:

```ruby
# GET /products.json
def index
  # Returns paginated JSON with filters applied
end

# GET /products/1.json
def show
  # Returns single product JSON
end

# GET /products.csv
def index
  # Returns CSV export of filtered products
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
bundle add pundit  # for authorization (if using --pundit)
bundle add pagy    # for pagination (if using --paginator)
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