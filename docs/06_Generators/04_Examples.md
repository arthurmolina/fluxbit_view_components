# Examples

This guide provides real-world examples of using Fluxbit generators to create different types of applications and features.

## E-commerce Product Management

Create a complete product management system for an online store.

### Basic Product Scaffold

```bash
rails generate fluxbit:scaffold Product \
  name:string \
  description:text \
  price:decimal \
  stock:integer \
  category:string \
  featured:boolean \
  published:boolean \
  --ui=modal \
  --paginator=pagy
```

**Generated Features:**
- Product listing with search and filters
- Modal forms for quick editing
- Bulk operations for managing inventory
- Featured product toggles
- Price and stock filtering

### Advanced Product with Images

```bash
rails generate fluxbit:scaffold Product \
  name:string \
  description:text \
  price:decimal \
  stock:integer \
  category:string \
  brand:string \
  weight:decimal \
  dimensions:string \
  featured:boolean \
  published:boolean \
  created_at:datetime \
  --ui=drawer \
  --paginator=pagy
```

**Customization after generation:**
```ruby
# Add image upload to the form
# app/views/products/_form.html.erb
&lt;%= fx_dropzone(:images, form: f, multiple: true, accept: "image/*") %&gt;

# Add category filtering
# app/controllers/products_controller.rb
def index
  # ... existing code ...
  @category = params[:category]
  @products = @products.where(category: @category) if @category.present?
  
  @categories = policy_scope(Product).distinct.pluck(:category).compact.sort
end
```

## Blog Management System

Create a full-featured blog management interface.

### Blog Posts

```bash
rails generate fluxbit:scaffold Post \
  title:string \
  content:text \
  excerpt:string \
  author:string \
  status:string \
  published_at:datetime \
  featured:boolean \
  tags:text \
  --ui=none \
  --paginator=pagy
```

**Why `--ui=none`:** Blog posts often require rich text editors and complex layouts, making full-page forms more suitable.

### Categories Management

```bash
rails generate fluxbit:scaffold Category \
  name:string \
  description:text \
  color:string \
  posts_count:integer \
  --ui=modal \
  --paginator=pagy
```

### Comments (with Drawer UI)

```bash
rails generate fluxbit:scaffold Comment \
  post:references \
  author_name:string \
  author_email:string \
  content:text \
  status:string \
  created_at:datetime \
  --ui=drawer \
  --paginator=pagy
```

## User Management Dashboard

Create an admin interface for user management.

### User Accounts

```bash
rails generate fluxbit:scaffold User \
  name:string \
  email:string \
  role:string \
  status:string \
  last_login_at:datetime \
  created_at:datetime \
  email_verified:boolean \
  --ui=drawer \
  --paginator=pagy \
  --pundit
```

**Generated Policy (app/policies/user_policy.rb):**
```ruby
class UserPolicy < ApplicationPolicy
  def index?
    user.admin? || user.manager?
  end

  def show?
    user.admin? || user.manager? || record == user
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || (user.manager? && !record.admin?) || record == user
  end

  def destroy?
    user.admin? && record != user
  end
end
```

### User Sessions/Activity

```bash
rails generate fluxbit:scaffold UserSession \
  user:references \
  ip_address:string \
  user_agent:string \
  started_at:datetime \
  ended_at:datetime \
  active:boolean \
  --ui=none \
  --no-pundit
```

## Project Management Tool

Create a project management interface.

### Projects

```bash
rails generate fluxbit:scaffold Project \
  name:string \
  description:text \
  status:string \
  priority:string \
  start_date:date \
  end_date:date \
  budget:decimal \
  progress:integer \
  manager:string \
  --ui=modal \
  --paginator=pagy
```

### Tasks

```bash
rails generate fluxbit:scaffold Task \
  project:references \
  title:string \
  description:text \
  status:string \
  priority:string \
  assigned_to:string \
  due_date:date \
  estimated_hours:decimal \
  completed:boolean \
  --ui=drawer \
  --paginator=pagy
```

**Custom Task Form Enhancement:**
```erb
&lt;!-- app/views/tasks/_form.html.erb --&gt;
&lt;%= form_with model: [@project, task], local: true do |f| %&gt;
  &lt;%= fx_text_field(:title, form: f, required: true) %&gt;
  &lt;%= fx_text_area(:description, form: f, rows: 3) %&gt;
  
  &lt;div class="grid grid-cols-2 gap-4"&gt;
    &lt;%= fx_select(:status, 
        options_for_select([
          ['To Do', 'todo'],
          ['In Progress', 'in_progress'], 
          ['Done', 'done']
        ]), 
        form: f) %&gt;
    &lt;%= fx_select(:priority,
        options_for_select([
          ['Low', 'low'],
          ['Medium', 'medium'],
          ['High', 'high']
        ]),
        form: f) %&gt;
  &lt;/div&gt;
  
  &lt;%= fx_date_field(:due_date, form: f) %&gt;
  &lt;%= fx_number_field(:estimated_hours, form: f, step: 0.5) %&gt;
  &lt;%= fx_toggle(:completed, form: f) %&gt;
&lt;% end %&gt;
```

## Inventory Management

Create a warehouse inventory system.

### Products/Items

```bash
rails generate fluxbit:scaffold InventoryItem \
  sku:string \
  name:string \
  description:text \
  category:string \
  current_stock:integer \
  minimum_stock:integer \
  maximum_stock:integer \
  unit_cost:decimal \
  selling_price:decimal \
  supplier:string \
  location:string \
  --ui=modal \
  --paginator=pagy
```

### Stock Movements

```bash
rails generate fluxbit:scaffold StockMovement \
  inventory_item:references \
  movement_type:string \
  quantity:integer \
  reason:string \
  notes:text \
  user:string \
  created_at:datetime \
  --ui=drawer \
  --no-turbo
```

**Why `--no-turbo`:** Stock movements might require page refreshes to ensure data consistency.

## Customer Support System

Create a support ticket system.

### Support Tickets

```bash
rails generate fluxbit:scaffold SupportTicket \
  customer_name:string \
  customer_email:string \
  subject:string \
  description:text \
  priority:string \
  status:string \
  assigned_to:string \
  created_at:datetime \
  resolved_at:datetime \
  --ui=none \
  --paginator=pagy
```

### Knowledge Base Articles

```bash
rails generate fluxbit:scaffold KnowledgeArticle \
  title:string \
  content:text \
  category:string \
  tags:string \
  published:boolean \
  views_count:integer \
  helpful_count:integer \
  author:string \
  --ui=drawer \
  --paginator=pagy
```

## Event Management

Create an event planning and management system.

### Events

```bash
rails generate fluxbit:scaffold Event \
  name:string \
  description:text \
  start_datetime:datetime \
  end_datetime:datetime \
  location:string \
  max_capacity:integer \
  current_registrations:integer \
  price:decimal \
  status:string \
  featured:boolean \
  --ui=modal \
  --paginator=pagy
```

### Event Registrations

```bash
rails generate fluxbit:scaffold EventRegistration \
  event:references \
  attendee_name:string \
  attendee_email:string \
  phone:string \
  special_requirements:text \
  status:string \
  payment_status:string \
  registered_at:datetime \
  --ui=drawer \
  --paginator=pagy
```

## Multi-tenant Application

Create a multi-tenant SaaS application structure.

### Organizations (Tenants)

```bash
rails generate fluxbit:scaffold Organization \
  name:string \
  subdomain:string \
  plan:string \
  status:string \
  users_count:integer \
  created_at:datetime \
  subscription_ends_at:datetime \
  --ui=modal \
  --paginator=pagy \
  --pundit
```

### Organization Users

```bash
rails generate fluxbit:scaffold OrganizationUser \
  organization:references \
  user:references \
  role:string \
  status:string \
  invited_at:datetime \
  joined_at:datetime \
  --ui=drawer \
  --paginator=pagy
```

## Advanced Customizations

### Custom Bulk Actions

Add custom bulk operations to generated controllers:

```ruby
# app/controllers/products_controller.rb
def bulk_feature
  @products = policy_scope(Product).where(id: params[:selected_ids])
  authorize Product, :bulk_feature?
  
  @products.update_all(featured: true)
  
  respond_to do |format|
    format.turbo_stream do
      flash[:notice] = "#{@products.count} products featured successfully"
      render 'bulk_feature'
    end
    format.html { redirect_to products_path, notice: "Products featured successfully" }
  end
end
```

### Custom Search Implementation

Enhance search beyond basic LIKE queries:

```ruby
# app/controllers/products_controller.rb
def index
  # ... existing code ...
  
  if @q.present?
    @products = @products.where(
      "name ILIKE :q OR description ILIKE :q OR category ILIKE :q",
      q: "%#{@q}%"
    )
  end
  
  # Full-text search (if using PostgreSQL)
  if Rails.env.production? && @q.present?
    @products = @products.where(
      "to_tsvector('english', name || ' ' || description) @@ plainto_tsquery(?)",
      @q
    )
  end
end
```

### Custom Form Validations

Add client-side validations to generated forms:

```erb
&lt;!-- app/views/products/_form.html.erb --&gt;
&lt;%= fx_text_field(:name, 
    form: f, 
    required: true,
    data: { 
      "validation-required": true,
      "validation-message": "Product name is required"
    }) %&gt;

&lt;%= fx_number_field(:price, 
    form: f,
    step: 0.01,
    min: 0,
    data: {
      "validation-min": 0,
      "validation-message": "Price must be greater than 0"
    }) %&gt;
```

### Custom Turbo Stream Actions

Create custom Turbo Stream responses:

```erb
&lt;!-- app/views/products/feature.turbo_stream.erb --&gt;
&lt;%= turbo_stream.replace "product_#{@product.id}" do %&gt;
  &lt;%= render 'products', product: @product %&gt;
&lt;% end %&gt;

&lt;%= turbo_stream.update "flash" do %&gt;
  &lt;%= render 'shared/flash' %&gt;
&lt;% end %&gt;

&lt;%= turbo_stream.update "featured_count" do %&gt;
  &lt;%= Product.where(featured: true).count %&gt; featured products
&lt;% end %&gt;
```

## Best Practices from Examples

1. **Choose UI Based on Complexity**
   - Simple forms → Modal
   - Complex forms → Drawer  
   - Multi-step workflows → None (separate pages)

2. **Use Appropriate Pagination**
   - Small datasets → Pagy (fastest)
   - Need advanced features → Kaminari
   - Legacy projects → WillPaginate

3. **Security First**
   - Always use Pundit in production
   - Implement proper authorization policies
   - Validate generated permissions

4. **Customize Incrementally**
   - Start with generated code
   - Add features one at a time
   - Test after each modification

5. **Follow Rails Conventions**
   - Use proper associations
   - Follow RESTful routes
   - Implement proper error handling