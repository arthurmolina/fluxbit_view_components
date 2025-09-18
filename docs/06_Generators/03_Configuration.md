# Configuration Options

This guide covers all configuration options available for Fluxbit generators, allowing you to customize the generated code to match your application's needs.

## Generator Options

### Global Configuration

You can set default options for all generators by creating an initializer:

```ruby
# config/initializers/fluxbit_generators.rb
Rails.application.config.generators do |g|
  g.fluxbit_ui = :modal           # Default UI interaction
  g.fluxbit_turbo = true          # Enable Turbo Streams
  g.fluxbit_paginator = :pagy     # Default paginator
  g.fluxbit_pundit = true         # Enable Pundit authorization
end
```

### Per-Command Configuration

Override defaults for specific commands:

```bash
# Use drawer UI with Kaminari pagination
rails generate fluxbit:scaffold Product name:string --ui=drawer --paginator=kaminari

# Disable Turbo and Pundit for simple CRUD
rails generate fluxbit:scaffold Product name:string --no-turbo --no-pundit

# Use traditional page-based forms
rails generate fluxbit:scaffold Product name:string --ui=none
```

## UI Configuration (`--ui`)

Controls how forms and interactions are presented to users.

### Modal (Default)
```bash
rails generate fluxbit:scaffold Product name:string --ui=modal
```

**Features:**
- Forms open in overlay modals
- Non-blocking user experience
- Perfect for quick CRUD operations
- Turbo Stream compatible

**Generated code:**
```erb
<!-- Trigger -->
<%%= fx_button(data: { action: "fx-modal#show", target: "product-modal" }) do %>
  New Product
<%% end %>

<!-- Modal -->
<%%= fx_modal(id: "product-modal") do %>
  <%%= render "form", product: @product %>
<%% end %>
```

### Drawer
```bash
rails generate fluxbit:scaffold Product name:string --ui=drawer
```

**Features:**
- Forms slide in from screen edges
- Great for complex forms with multiple steps
- More screen real estate than modals
- Mobile-friendly

**Generated code:**
```erb
<!-- Trigger -->
<%%= fx_button(data: { action: "fx-drawer#show", target: "product-drawer" }) do %>
  New Product
<%% end %>

<!-- Drawer -->
<%%= fx_drawer(id: "product-drawer", position: :right) do %>
  <%%= render "form", product: @product %>
<%% end %>
```

### None (Traditional Pages)
```bash
rails generate fluxbit:scaffold Product name:string --ui=none
```

**Features:**
- Separate pages for each form
- Traditional Rails approach
- Better for complex workflows
- SEO-friendly URLs

**Generated code:**
```erb
<!-- Navigation -->
<%%= fx_button(as: :a, href: new_product_path) do %>
  New Product
<%% end %>

<!-- Separate pages: new.html.erb, edit.html.erb -->
```

## Turbo Configuration (`--turbo`)

Controls whether Turbo Streams are used for dynamic page updates.

### With Turbo Streams (Default)
```bash
rails generate fluxbit:scaffold Product name:string --turbo
```

**Features:**
- Dynamic page updates without full reload
- Better user experience
- Modern Rails approach
- Requires Turbo to be configured

**Generated files:**
- `create.turbo_stream.erb`
- `update.turbo_stream.erb` 
- `destroy.turbo_stream.erb`
- `update_all.turbo_stream.erb`
- `destroy_all.turbo_stream.erb`

### Without Turbo Streams
```bash
rails generate fluxbit:scaffold Product name:string --no-turbo
```

**Features:**
- Traditional HTTP redirects
- Simpler architecture
- Works without JavaScript
- Full page reloads

**Generated code:**
```ruby
# Controller actions redirect instead of rendering streams
def create
  if @product.save
    redirect_to @product, notice: 'Created successfully'
  else
    render :new
  end
end
```

## Paginator Configuration (`--paginator`)

Choose your preferred pagination library.

### Pagy (Default, Recommended)
```bash
rails generate fluxbit:scaffold Product name:string --paginator=pagy
```

**Why Pagy:**
- Fastest pagination gem
- Smallest memory footprint
- Highly customizable
- I18n support

**Generated code:**
```ruby
# Controller
def index
  Pagy::DEFAULT[:limit] = (params[:per_page].presence || 5).to_i
  @pagy, @products = pagy(policy_scope(Product).all)
end
```

```erb
<!-- View -->
<%%= fx_pagination(@pagy) if @pagy.pages > 1 %>
```

### Kaminari
```bash
rails generate fluxbit:scaffold Product name:string --paginator=kaminari
```

**Features:**
- Popular and well-established
- Rich feature set
- Active Record integration
- Customizable views

**Generated code:**
```ruby
# Controller  
def index
  @products = policy_scope(Product).page(params[:page]).per(10)
end
```

```erb
<!-- View -->
<%%= fx_pagination(@products) %>
```

### WillPaginate
```bash
rails generate fluxbit:scaffold Product name:string --paginator=will_paginate
```

**Features:**
- Classic Rails pagination
- Simple API
- Stable and mature

**Generated code:**
```ruby
# Controller
def index
  @products = policy_scope(Product).paginate(page: params[:page], per_page: 10)
end
```

## Authorization Configuration (`--pundit`)

Controls whether Pundit authorization is included.

### With Pundit (Default)
```bash
rails generate fluxbit:scaffold Product name:string --pundit
```

**Features:**
- Policy-based authorization
- Secure by default
- Fine-grained permissions
- Separation of concerns

**Generated files:**
- `app/policies/product_policy.rb`

**Controller integration:**
```ruby
class ProductsController < ApplicationController
  include Pundit::Authorization
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @products = policy_scope(Product).all
  end

  def show
    authorize @product
  end
end
```

### Without Pundit
```bash
rails generate fluxbit:scaffold Product name:string --no-pundit
```

**Features:**
- Simpler controllers
- No authorization checks
- Suitable for internal tools
- Faster development

**Generated code:**
```ruby
class ProductsController < ApplicationController
  def index
    @products = Product.all  # No policy scope
  end

  def show
    # No authorize call
  end
end
```

## Attribute Type Handling

The generator intelligently handles different attribute types:

### String and Text Fields
```bash
rails generate fluxbit:scaffold Product name:string description:text
```

**Generated form:**
```erb
<%%= fx_text_field(:name, form: f, required: true) %>
<%%= fx_text_area(:description, form: f, rows: 3) %>
```

**Search functionality:**
```ruby
# LIKE queries for partial matching
@products = @products.where("name LIKE ?", "%#{@q}%") if @q.present?
```

### Numeric Fields
```bash
rails generate fluxbit:scaffold Product price:decimal stock:integer
```

**Generated form:**
```erb
<%%= fx_number_field(:price, form: f, step: 0.01) %>
<%%= fx_number_field(:stock, form: f) %>
```

**Range filtering:**
```ruby
# Greater than or equal filtering
@products = @products.where("price >= ?", @price) if @price.present?
```

### Boolean Fields
```bash
rails generate fluxbit:scaffold Product featured:boolean active:boolean
```

**Generated form:**
```erb
<%%= fx_checkbox(:featured, form: f) %>
<%%= fx_toggle(:active, form: f) %>
```

### Date and DateTime Fields
```bash
rails generate fluxbit:scaffold Event start_date:date created_at:datetime
```

**Generated form:**
```erb
<%%= fx_date_field(:start_date, form: f) %>
<%%= fx_datetime_local_field(:created_at, form: f) %>
```

## Advanced Configuration

### Custom Form Components

Create custom mappings for specific field types:

```ruby
# config/initializers/fluxbit_generators.rb
Fluxbit::Generators::FormBuilder.field_mappings.merge!({
  email: :fx_email_field,
  url: :fx_url_field,
  phone: :fx_tel_field,
  currency: :fx_currency_field
})
```

### Controller Customization

Override controller templates by copying them to your application:

```bash
# Copy templates to customize
mkdir -p lib/templates/fluxbit/scaffold
cp $(bundle show fluxbit_view_components)/lib/generators/fluxbit/templates/controller.rb.tt \
   lib/templates/fluxbit/scaffold/controller.rb.tt

# Customize the template
# The generator will now use your custom template
```

### View Customization

Similarly, customize view templates:

```bash
# Copy view templates
mkdir -p lib/templates/fluxbit/scaffold
cp -r $(bundle show fluxbit_view_components)/lib/generators/fluxbit/templates/*.html.erb.tt \
      lib/templates/fluxbit/scaffold/

# Customize as needed
```

### I18n Customization

Customize translation templates:

```bash
# Copy i18n templates
cp $(bundle show fluxbit_view_components)/lib/generators/fluxbit/templates/i18n.en.yml.tt \
   lib/templates/fluxbit/scaffold/i18n.en.yml.tt

# Add your custom translations
```

## Environment-Specific Configuration

### Development Configuration
```ruby
# config/environments/development.rb
config.generators do |g|
  g.fluxbit_ui = :modal
  g.fluxbit_turbo = true
  g.fluxbit_paginator = :pagy
  g.fluxbit_pundit = false  # Disable for faster development
end
```

### Production Configuration
```ruby
# config/environments/production.rb
config.generators do |g|
  g.fluxbit_ui = :modal
  g.fluxbit_turbo = true
  g.fluxbit_paginator = :pagy
  g.fluxbit_pundit = true   # Always enable in production
end
```

## Configuration Validation

Add validation to ensure proper configuration:

```ruby
# config/initializers/fluxbit_generators.rb
Rails.application.config.after_initialize do
  # Validate Turbo configuration
  if Rails.application.config.generators.options[:fluxbit]&.fetch(:turbo, true)
    unless defined?(Turbo)
      Rails.logger.warn "Fluxbit generators configured for Turbo but Turbo is not available"
    end
  end
  
  # Validate Pundit configuration
  if Rails.application.config.generators.options[:fluxbit]&.fetch(:pundit, true)
    unless defined?(Pundit)
      Rails.logger.warn "Fluxbit generators configured for Pundit but Pundit is not available"
    end
  end
end
```

## Best Practices

### 1. Start with Defaults
Begin with default options and customize as needed:
```bash
rails generate fluxbit:scaffold Product name:string
```

### 2. Consistent Configuration
Use initializers to maintain consistent options across your team:
```ruby
# config/initializers/fluxbit_generators.rb
Rails.application.config.generators do |g|
  g.fluxbit_ui = :modal
  g.fluxbit_turbo = true
  g.fluxbit_paginator = :pagy
  g.fluxbit_pundit = true
end
```

### 3. Environment-Appropriate Settings
- **Development**: May disable Pundit for faster iteration
- **Production**: Always enable security features

### 4. Document Your Choices
Document generator configuration in your README:
```markdown
## Generator Configuration

This project uses:
- Modal UI for forms
- Turbo Streams for dynamic updates  
- Pagy for pagination
- Pundit for authorization
```

### 5. Test Generated Code
Always test the generated scaffolds to ensure they work with your application's specific needs and configurations.