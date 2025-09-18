# Component Code Style Guide - Fluxbit View Components

This document outlines the architectural patterns, coding standards, and best practices for developing components in the Fluxbit View Components gem.

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Component Inheritance Hierarchy](#component-inheritance-hierarchy)
3. [Configuration System](#configuration-system)
4. [Component Development Patterns](#component-development-patterns)
5. [Helper Integration](#helper-integration)
6. [Slot-Based Components](#slot-based-components)
7. [Form Integration](#form-integration)
8. [Icon System](#icon-system)
9. [Styling and CSS Classes](#styling-and-css-classes)
10. [Code Standards](#code-standards)

## Architecture Overview

The Fluxbit View Components gem follows a modular architecture built on ViewComponent with the following key principles:

- **Separation of Concerns**: Logic, styling, and configuration are separated
- **Configuration-Driven**: Components use external configuration modules for styling and defaults
- **Helper Integration**: Components are accessible via `fx_*` helper methods
- **Form Integration**: Seamless Rails form builder integration
- **Slot-Based Design**: Complex components use slots for flexible content areas

## Component Inheritance Hierarchy

### Base Classes

```ruby
# Base component - All components inherit from this
Fluxbit::Component < ViewComponent::Base

# Form-specific base - All form components inherit from this
Fluxbit::Form::Component < Fluxbit::Component

# Field-specific base - Input components inherit from this
Fluxbit::Form::FieldComponent < Fluxbit::Form::Component
```

### Inheritance Pattern

```ruby
# UI Components
class Fluxbit::ButtonComponent < Fluxbit::Component
class Fluxbit::ModalComponent < Fluxbit::Component
class Fluxbit::CardComponent < Fluxbit::Component

# Form Components
class Fluxbit::Form::TextFieldComponent < Fluxbit::Form::FieldComponent
class Fluxbit::Form::LabelComponent < Fluxbit::Form::Component
class Fluxbit::Form::HelpTextComponent < Fluxbit::Form::Component
```

## Configuration System

### Configuration Module Pattern

Each component has a corresponding configuration module that defines:
- Default values using `mattr_accessor`
- Styling systems using nested hashes
- Component variants and states

```ruby
# lib/fluxbit/config/button_component.rb
module Fluxbit::Config::ButtonComponent
  # Default values
  mattr_accessor :color, default: :default
  mattr_accessor :pill, default: false
  mattr_accessor :size, default: 1
  mattr_accessor :as, default: :button

  # Styling system
  mattr_accessor :styles do
    {
      base: "group flex items-center justify-center p-0.5 text-center font-medium relative focus:z-10 focus:outline-hidden",
      colors: {
        default: "text-white bg-blue-700 border border-transparent enabled:hover:bg-blue-800 focus:ring-4 focus:ring-blue-300",
        success: "text-white bg-green-700 border border-transparent enabled:hover:bg-green-800 focus:ring-4 focus:ring-green-300",
        danger: "text-white bg-red-700 border border-transparent enabled:hover:bg-red-800 focus:ring-4 focus:ring-red-300"
      },
      disabled: "cursor-not-allowed opacity-50",
      pill: {
        off: "rounded-lg",
        on: "rounded-full"
      },
      size: [
        "text-xs p-1",
        "text-sm p-1.5", 
        "text-sm p-2",
        "text-base p-2.5",
        "text-base p-3"
      ]
    }
  end
end
```

### Component Integration

```ruby
class Fluxbit::ButtonComponent < Fluxbit::Component
  include Fluxbit::Config::ButtonComponent  # Include configuration module

  def initialize(**props)
    super
    # Access defaults using @@variable
    @color = options(@props.delete(:color), collection: styles[:colors].keys, default: @@color)
    @size = @props.delete(:size) || @@size
    
    # Access styling system
    add(class: styles[:base], to: @props)
    add(class: styles[:colors][@color], to: @props)
  end
end
```

## Component Development Patterns

### 1. Standard Component Structure

```ruby
# frozen_string_literal: true

##
# The `Fluxbit::ExampleComponent` renders a customizable example component.
# It supports various colors, sizes, and styling options.
#
# @example Basic usage
#   = fx_example(color: :primary, size: 2) { "Content" }
#
# @see docs/02_Components/Example.md For detailed documentation.
class Fluxbit::ExampleComponent < Fluxbit::Component
  include Fluxbit::Config::ExampleComponent

  # Slot declarations (if applicable)
  renders_one :header
  renders_many :items, ItemComponent

  ##
  # Initializes the example component with the given properties.
  #
  # @param [Hash] **props The properties to customize the component.
  # @option props [Symbol, String] :color (:default) The color theme.
  # @option props [Integer] :size (1) The size of the component (0-4).
  # @option props [Boolean] :disabled (false) Sets disabled state.
  # @option props [String] :remove_class ('') CSS classes to remove.
  # @option props [Hash] **props Remaining options as HTML attributes.
  #
  # @return [Fluxbit::ExampleComponent]
  def initialize(**props)
    super
    @props = props

    # ALWAYS use options() with config defaults
    @color = options(@props.delete(:color), collection: styles[:colors].keys, default: @@color)
    @size = options(@props.delete(:size), default: @@size)
    @disabled = options(@props.delete(:disabled), default: @@disabled)

    # Apply styling
    declare_classes

    # Handle class removal
    @props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
  end

  def call
    # Render component HTML
    tag.div(**@props) do
      # Component content
    end
  end

  private

  def declare_classes
    add(class: styles[:base], to: @props, first_element: true)
    add(class: styles[:colors][@color], to: @props, first_element: true)
    add(class: styles[:disabled], to: @props) if @disabled
  end
end
```

### 2. Property Handling Patterns

**ALWAYS use the `**props` pattern with `@props.delete()` and config defaults:**

```ruby
##
# Initializes the component with the given properties.
#
# @param [Hash] **props The properties to customize the component.
# @option props [Boolean] :flush (false) When true, removes borders and rounded corners.
# @option props [Symbol, String] :color (:default) The color theme (default, primary, success, etc.).
# @option props [Boolean] :disabled (false) Sets the component to a disabled state.
# @option props [Integer] :size (1) The size of the component (0-4).
# @option props [String] :remove_class ('') CSS classes to remove from the default class list.
# @option props [Hash] **props Remaining options declared as HTML attributes.
#
# @return [Fluxbit::ComponentName]
def initialize(**props)
  super
  @props = props

  # ALWAYS use options() function with config defaults (@@variable)
  @flush = options(@props.delete(:flush), default: @@flush)
  @disabled = options(@props.delete(:disabled), default: @@disabled)

  # Validated options with collections - use config defaults
  @color = options(@props.delete(:color), collection: styles[:colors].keys, default: @@color)
  @size = options(@props.delete(:size), default: @@size)

  # Apply conditional logic after setting properties
  @outline = @color.to_s.end_with?("_outline")
end
```

**Key Requirements:**
- **Use `**props` parameter only** (no individual parameters)
- **Always call `super` without arguments**
- **Use `@props.delete()` pattern** to extract properties
- **Use `options()` function with `default: @@config_variable`** for all properties
- **Add comprehensive parameter documentation** with `@option` tags

**Benefits of This Pattern:**
- **Consistent API:** All components follow the same initialization pattern
- **Config Integration:** Automatically uses configuration defaults defined in config modules
- **Validation:** The `options()` function provides built-in validation and fallbacks
- **Maintainability:** Changes to defaults only need to be made in config files
- **Documentation:** Clear parameter documentation with types and defaults
- **Flexibility:** Remaining props automatically become HTML attributes

### 3. CSS Class Management

```ruby
def declare_classes
  # Always add base classes first
  add(class: styles[:base], to: @props, first_element: true)
  
  # Add conditional classes
  add(class: styles[:pill][@pill ? :on : :off], to: @props, first_element: true)
  add(class: styles[:colors][@color], to: @props, first_element: true)
  
  # Add size-specific classes
  add(class: styles[:sizes][@sizing], to: @props) if @sizing
  
  # Add state classes
  add(class: styles[:disabled], to: @props) if @disabled
end
```

## Helper Integration

### Naming Convention

- **Components**: CamelCase with "Component" suffix (e.g., `ButtonComponent`)
- **Helpers**: snake_case with `fx_` prefix, without "component" (e.g., `fx_button`)

### Helper Generation Pattern

```ruby
# app/helpers/fluxbit/components_helper.rb
module Fluxbit::ComponentsHelper
  # UI Components
  [:avatar, :button, :card, :modal, :pagination].each do |component|
    define_method("fx_#{component}") do |*args, **kwargs, &block|
      fluxbit_method(component.to_s.camelize, *args, **kwargs, &block)
    end
  end

  # Form Components
  [:help_text, :check_box, :label, :toggle].each do |component|
    define_method("fx_#{component}") do |*args, **kwargs, &block|
      fluxbit_method("Form::#{component.to_s.camelize}", *args, **kwargs, &block)
    end
  end

  # Dynamic type-based helpers (for TextFieldComponent)
  Fluxbit::Form::TextFieldComponent::TYPE_OPTIONS.each do |type|
    define_method(type.in?([:text_area, :textarea]) ? "fx_#{type}" : "fx_#{type}_field") do |*args, **kwargs, &block|
      fluxbit_method("Form::TextField", *args, type: type, **kwargs, &block)
    end
  end

  private

  def fluxbit_method(method_name, *args, **kwargs, &c)
    component_klass = "Fluxbit::#{method_name}Component".constantize
    render(component_klass.new(*args, **kwargs), &c)
  end
end
```

### Usage Examples

```erb
&lt;!-- Helper usage --&gt;
&lt;%= fx_button(color: :success, size: 2) { "Save" } %&gt;
&lt;%= fx_text_field(name: "email", placeholder: "Enter email") %&gt;
&lt;%= fx_modal(title: "Confirm") { "Are you sure?" } %&gt;

&lt;!-- Equivalent component usage --&gt;
&lt;%= render Fluxbit::ButtonComponent.new(color: :success, size: 2) { "Save" } %&gt;
&lt;%= render Fluxbit::Form::TextFieldComponent.new(name: "email", placeholder: "Enter email") %&gt;
&lt;%= render Fluxbit::ModalComponent.new(title: "Confirm") { "Are you sure?" } %&gt;
```

## Slot-Based Components

### Slot Types and Usage

#### 1. renders_one - Single Content Areas

```ruby
class Fluxbit::ModalComponent < Fluxbit::Component
  renders_one :title
  renders_one :footer

  def call
    tag.div(**@props) do
      concat(title) if title?
      concat(tag.div(content, class: body_classes))
      concat(footer) if footer?
    end
  end
end
```

**Usage:**
```erb
&lt;%= fx_modal do |modal| %&gt;
  &lt;% modal.with_title { "Confirmation" } %&gt;
  &lt;% modal.with_footer { fx_button { "OK" } } %&gt;
  Main content goes here
&lt;% end %&gt;
```

#### 2. renders_many - Multiple Items

```ruby
class Fluxbit::DropdownComponent < Fluxbit::Component
  renders_many :items, Fluxbit::DropdownItemComponent

  def call
    tag.div(**@props) do
      tag.ul(class: styles[:ul]) do
        safe_join(items)
      end
    end
  end
end
```

**Usage:**
```erb
&lt;%= fx_dropdown do |dropdown| %&gt;
  &lt;% dropdown.with_item(href: "/profile") { "Profile" } %&gt;
  &lt;% dropdown.with_item(href: "/settings") { "Settings" } %&gt;
  &lt;% dropdown.with_item(href: "/logout") { "Logout" } %&gt;
&lt;% end %&gt;
```

#### 3. Nested Component Classes

```ruby
class Fluxbit::BreadcrumbComponent < Fluxbit::Component
  renders_many :items, lambda { |**attrs, &block|
    item = Item.new(**attrs)
    item.with_content(block.call) if block_given?
    item
  }

  # Nested component class
  class Item < Fluxbit::Component
    include Fluxbit::Config::BreadcrumbComponent
    renders_one :dropdown, Fluxbit::DropdownComponent

    def initialize(**props)
      super
      @current_page = @props.delete(:current_page)
      @href = @props.delete(:href)
      @icon = @props.delete(:icon)
    end

    def call
      tag.li(class: styles[:item][:base]) do
        if @current_page || @href.blank?
          tag.span(content, **@props)
        else
          tag.a(content, href: @href, **@props)
        end
      end
    end
  end
end
```

### When to Use Each Pattern

- **renders_one**: Single content areas like headers, footers, titles
- **renders_many**: Collections of similar items like menu items, tabs, list items
- **Nested Classes**: Complex items that need their own logic and configuration
- **Lambda Slots**: When you need custom initialization or content processing

## Form Integration

### Form Integration Pattern

Form components follow a specific inheritance and integration pattern:

```ruby
# Base form component
class Fluxbit::Form::Component < Fluxbit::Component
  # I18n integration for help text and labels
  def define_help_text(help_text, object, attribute)
    return nil if help_text.is_a? FalseClass
    
    if help_text.nil? && !object.nil? && !attribute.nil?
      help_text = I18n.t(
        attribute,
        scope: [:activerecord, :help_text, object.class.name.underscore.to_sym],
        default: nil
      )
    end
    
    (help_text.is_a?(Array) ? help_text : [help_text]) + errors
  end

  # Automatic label generation
  def label_value(label, object, attribute, id)
    return object.class.human_attribute_name(attribute) if label.nil? && !object.nil? && !attribute.nil?
    return attribute.to_s.humanize if label.nil? && object.nil?
    return label unless label.nil?
    nil
  end

  # Error handling integration
  def errors
    return [] unless @object&.errors&.any?
    @object.errors.filter { |f| f.attribute == @attribute }.map(&:full_message)
  end
end

# Field-specific base component
class Fluxbit::Form::FieldComponent < Fluxbit::Form::Component
  def initialize(**props)
    super
    @form = @props.delete(:form)           # Rails form builder
    @attribute = @props.delete(:attribute) # Model attribute
    @name = @props.delete(:name) || (@attribute if @form.present?)
    @value = @props.delete(:value)
    @id = @props.delete(:id)
    
    @object = @form&.object
    @help_text = define_help_text(props.delete(:help_text), @object, @attribute)
    @label = label_value(props.delete(:label), @object, @attribute, @id)
  end
end
```

### Dual-Mode Form Components

Form components support both standalone and Rails form builder usage:

```ruby
class Fluxbit::Form::TextFieldComponent < Fluxbit::Form::FieldComponent
  def input
    input_type = case @type
    when :text
      @multiline ? "text_area" : "text_field"
    when :tel then "telephone_field"
    when :textarea, :text_area then "text_area"
    else
      "#{@type}_field"
    end

    # Rails form builder integration
    if @form.present? && @attribute.present?
      @form.public_send(input_type, @attribute, @props)
    else
      # Standalone usage
      public_send("#{input_type}_tag", @name, @value, @props)
    end
  end
end
```

### Usage Examples

```erb
&lt;!-- Standalone usage --&gt;
&lt;%= fx_text_field(name: "email", label: "Email Address", help_text: "We'll never share your email") %&gt;

&lt;!-- Rails form builder usage --&gt;
&lt;%= form_with model: @user do |form| %&gt;
  &lt;%= fx_text_field(form: form, attribute: :email, help_text: "We'll never share your email") %&gt;
&lt;% end %&gt;

&lt;!-- Automatic label and help text from I18n --&gt;
&lt;!-- Looks up: activerecord.attributes.user.email and activerecord.help_text.user.email --&gt;
&lt;%= fx_text_field(form: form, attribute: :email) %&gt;
```

### I18n Integration

Form components automatically integrate with Rails I18n:

```yaml
# config/locales/en.yml
en:
  activerecord:
    attributes:
      user:
        email: "Email Address"
        password: "Password"
    help_text:
      user:
        email: "We'll never share your email with anyone"
        password: "Must be at least 8 characters"
    helper_popover:
      user:
        password: "Choose a strong password with mixed case, numbers, and symbols"
```

## Icon System

### Icon Usage Guidelines

#### 1. Internal/Fixed Icons - Use SVG Methods

For icons that are always used within components (non-configurable):

```ruby
class Fluxbit::Component < ViewComponent::Base
  # Define as SVG methods for internal use
  def chevron_right(**props)
    add to: props, class: "w-2.5 h-2.5", first_element: true
    remove_class_from_props(props)
    props["aria-hidden"] = "true"
    props[:xmlns] = "http://www.w3.org/2000/svg"
    props[:fill] = "none"
    props[:viewBox] = "0 0 6 10"
    stroke_width = props.delete(:stroke_width) || 2

    tag.svg(**props) do
      tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => stroke_width, d: "m1 9 4-4-4-4")
    end
  end

  def close_icon(**props)
    props["aria-hidden"] = "true"
    props[:xmlns] = "http://www.w3.org/2000/svg"
    props[:fill] = "none"
    props[:viewBox] = "0 0 14 14"

    tag.svg(**props) do
      tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => 2, d: "m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6")
    end
  end
end
```

**Fixed icons include:**
- `chevron_right`, `chevron_left`, `chevron_up`, `chevron_down`
- `chevron_double_left`, `chevron_double_right`
- `close_icon`
- `ellipsis_horizontal`

#### 2. Configurable Icons - Use Anyicon

For icons that developers can choose/configure:

```ruby
def anyicon(icon, **props)
  Anyicon::Icon.render(icon, **props)
end

# Usage in components
def create_icon
  return "" if @icon.blank?
  
  content_tag(:div, anyicon(@icon, class: styles[:icon_classes]), **@icon_html)
end
```

**Configurable icon usage:**
```ruby
# Component initialization
@icon = @props.delete(:icon)          # Left icon
@right_icon = @props.delete(:right_icon)  # Right icon

# Component usage
fx_text_field(icon: "heroicons_solid:mail", right_icon: "heroicons_solid:eye")
fx_breadcrumb_item(icon: "heroicons_solid:home", href: "/")
```

#### 3. Icon Integration Pattern

```ruby
def icon(icon_value, tag: :div, props: nil)
  return "" if icon_value.blank?

  content_tag(
    tag,
    anyicon(icon_value, class: styles[:additional_icons][:class][@color]),
    **props
  )
end

def create_icon
  add class: styles[:additional_icons][:icon], to: @icon_html
  add(class: "pointer-events-none", to: @icon_html) unless events?(@icon_html)
  icon(@icon, props: @icon_html)
end
```

### Icon Replacement Guidelines

To make icon systems easily replaceable:

1. **Encapsulate icon logic** in helper methods
2. **Use consistent method signatures** across components
3. **Provide icon override options** in component props
4. **Separate icon styling** from icon selection

```ruby
# Good - Easy to replace anyicon
def render_icon(icon_name, **props)
  return "" if icon_name.blank?
  anyicon(icon_name, **props)  # Can be easily replaced
end

# Good - Override option
def initialize(**props)
  @icon_renderer = props.delete(:icon_renderer) || method(:anyicon)
end
```

## Styling and CSS Classes

### Tailwind CSS Style Organization

**RULE: All Tailwind CSS classes MUST be defined in the component's configuration module, never inline in the component class.**

```ruby
# ❌ BAD - Inline Tailwind classes in component
class Fluxbit::BannerComponent < Fluxbit::Component
  def banner_content
    # Never hardcode Tailwind classes in component methods
    content_wrapper_class = "flex items-center justify-between w-full p-4"
    tag.div(class: content_wrapper_class) do
      # ...
    end
  end

  def dismiss_button
    # Avoid inline classes in props
    button_props = {
      class: "flex-shrink-0 inline-flex justify-center w-7 h-7 items-center text-gray-400"
    }
    # ...
  end
end
```

```ruby
# ✅ GOOD - All styles in configuration module
module Fluxbit::Config::BannerComponent
  mattr_accessor :styles do
    {
      content_wrapper: {
        full_width: "flex items-center justify-between w-full p-4",
        constrained: "flex items-center justify-between max-w-screen-xl mx-auto p-4"
      },
      dismiss_button: {
        base: "flex-shrink-0 inline-flex justify-center w-7 h-7 items-center text-gray-400 hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 dark:hover:bg-gray-600 dark:hover:text-white",
        with_cta: "ml-3"
      },
      left_content: "flex items-center",
      right_content: "flex items-center"
    }
  end
end

# Component uses configuration styles
class Fluxbit::BannerComponent < Fluxbit::Component
  include Fluxbit::Config::BannerComponent

  def banner_content
    content_wrapper_class = @full_width ? styles[:content_wrapper][:full_width] : styles[:content_wrapper][:constrained]
    tag.div(class: content_wrapper_class) do
      # ...
    end
  end

  def dismiss_button
    button_props = {
      class: styles[:dismiss_button][:base]
    }
    add(to: button_props, class: styles[:dismiss_button][:with_cta]) if cta_button?
    # ...
  end
end
```

**Benefits of Configuration-Based Styling:**
- **Centralized Management**: All styling is in one place for easy maintenance
- **Design System Consistency**: Ensures all components follow the same patterns
- **Easy Customization**: Users can override styles by modifying configuration
- **Better Testing**: Styles can be tested independently from component logic
- **Theme Support**: Easier to implement theme switching and customization
- **Documentation**: Clear separation between logic and presentation

### CSS Class Management Patterns

#### 1. The `add` Helper Method

```ruby
def add(to:, first_element: false, **props)
  unless props[:class].nil?
    to[:class] = (to[:class] || "")
      .split
      .insert((first_element ? 0 : -1), props[:class])
      .join(" ")
  end
  to
end

# Usage
add(class: styles[:base], to: @props, first_element: true)
add(class: styles[:colors][@color], to: @props)
```

#### 2. Class Removal Pattern

```ruby
def remove_class(elements, from)
  return "" if from.blank?
  return from if elements.blank?

  from.split.reject { |c| c.in?((elements || "").split) }.join(" ")
end

# Usage in initialize
@props[:class] = remove_class(@props.delete(:remove_class) || "", @props[:class])
```

#### 3. Styling Organization

```ruby
# Organize styles by component areas
mattr_accessor :styles do
  {
    # Base component styles
    base: "flex items-center justify-center",
    
    # Component parts
    header: {
      base: "flex items-center justify-between p-4",
      title: "text-xl font-semibold",
      close: {
        base: "ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400",
        hover: "hover:bg-gray-100 hover:text-gray-900"
      }
    },
    
    # State variations
    states: {
      disabled: "cursor-not-allowed opacity-50",
      active: "bg-blue-600 text-white"
    },
    
    # Size variations
    sizes: [
      "text-xs p-1",    # size 0
      "text-sm p-1.5",  # size 1
      "text-sm p-2",    # size 2
      "text-base p-2.5" # size 3
    ],
    
    # Color variations
    colors: {
      default: "text-white bg-blue-700 hover:bg-blue-800",
      success: "text-white bg-green-700 hover:bg-green-800",
      danger: "text-white bg-red-700 hover:bg-red-800"
    }
  }
end
```

### Responsive and Dark Mode Support

Include responsive and dark mode classes in configuration:

```ruby
base: "flex items-center justify-center text-sm font-medium px-4 py-2 border border-transparent rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 sm:text-base lg:px-6 lg:py-3 dark:bg-gray-800 dark:text-white dark:border-gray-600"
```

## Code Standards

### 1. File Organization

```
app/
├── components/fluxbit/
│   ├── component.rb                    # Base component class
│   ├── button_component.rb            # UI components
│   ├── modal_component.rb
│   └── form/
│       ├── component.rb               # Form base class
│       ├── field_component.rb         # Field base class
│       └── text_field_component.rb    # Specific form components
├── helpers/fluxbit/
│   ├── components_helper.rb           # fx_* helper methods
│   ├── form_builder.rb               # Rails form builder integration
│   └── view_helper.rb                # General view helpers
lib/fluxbit/config/
├── button_component.rb               # Component configurations
├── modal_component.rb
└── form/
    └── text_field_component.rb
```

### 2. Documentation Standards

```ruby
# frozen_string_literal: true

##
# The `Fluxbit::ButtonComponent` is a customizable button component that extends `Fluxbit::Component`.
# It allows you to create buttons with various styles, sizes, colors, and supports additional
# features like popovers and tooltips.
#
# @example Basic usage
#   = fx_button(color: :success) { "Save" }
#
# @example With icon
#   = fx_button(icon: "heroicons_solid:plus") { "Add Item" }
#
# @see docs/03_Components/Button.md For detailed documentation and examples.
class Fluxbit::ButtonComponent < Fluxbit::Component
  ##
  # Initializes the button component with the given properties.
  #
  # @param [Hash] props The properties to customize the button.
  # @option props [Symbol, String] :color The color style of the button.
  # @option props [Symbol, String] :size The size of the button (0-4).
  # @option props [Boolean] :pill (false) Determines if the button has pill-shaped edges.
  # @option props [Boolean] :disabled (false) Sets the button to a disabled state.
  # @option props [String] :remove_class ('') Classes to remove from the default class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::ButtonComponent]
  def initialize(**props)
    # Implementation
  end
end
```

### 3. Method Naming Conventions

```ruby
# Public interface methods
def call           # Main render method
def initialize     # Component initialization

# CSS class management
def declare_classes      # Apply all CSS classes
def declare_size        # Handle size-specific classes
def declare_disabled    # Handle disabled state

# Content rendering
def render_button       # Render main element
def render_icon        # Render icon elements
def header             # Render header section
def footer             # Render footer section

# Validation and options
def valid_color        # Validate color options
def options           # Handle option validation with defaults
def sizing_with_addon # Calculate sizing with addons
```

### 4. Testing Integration

Ensure components are testable by:

```ruby
# Include configuration in component for test access
class Fluxbit::ButtonComponent < Fluxbit::Component
  include Fluxbit::Config::ButtonComponent  # Makes styles accessible in tests
end

# Use consistent prop patterns for predictable testing
def initialize(**props)
  @color = options(@props.delete(:color), collection: styles[:colors].keys, default: @@color)
  @size = @props.delete(:size) || @@size
end
```

### 5. Error Handling

```ruby
def initialize(**props)
  # Validate required parameters
  raise ArgumentError, "size must be an Integer >= 0" if @size.present? && (@size.to_i < 0 || !@size.is_a?(Integer))
  
  # Provide sensible defaults
  @color = options(@color, collection: styles[:colors].keys, default: @@color)
  
  # Handle edge cases
  @show_texts = true if !@show_icons && !@show_texts  # Force show_texts if nothing else
end
```

This comprehensive guide provides the foundation for developing consistent, maintainable, and well-architected components in the Fluxbit View Components gem. Following these patterns ensures components integrate seamlessly with the existing ecosystem while maintaining flexibility and extensibility.