# Component Testing Style Guide - Fluxbit View Components

This document outlines the testing best practices and patterns used in the Fluxbit View Components gem, based on analysis of the existing test suite.

## Test Framework & Structure

### Framework
- **Minitest**: Primary testing framework used throughout the project
- **ViewComponent::TestCase**: Base class for all component tests
- **ActionDispatch::SystemTestCase**: For system/integration tests
- **ActionView::TestCase**: For helper tests

### Directory Structure
```
test/
├── test_helper.rb                    # Main test configuration
├── application_system_test_case.rb   # System test base class
├── components/fluxbit/               # Component unit tests
│   ├── form/                         # Form component tests
│   └── *_component_test.rb           # Individual component tests
├── helpers/fluxbit/                  # Helper method tests
├── test_helpers/                     # Reusable test utilities
└── fixtures/                         # Test fixtures
```

## Component Testing Patterns

### 1. Base Test Structure

Every component test follows this pattern:

```ruby
# frozen_string_literal: true

require "test_helper"

class Fluxbit::ButtonComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::ButtonComponent  # Include component config

  def test_renders_with_default_behavior
    render_inline(Fluxbit::ButtonComponent.new) { "Content" }
    
    assert_selector "button", text: "Content"
    assert_selector styled(:base)
  end
end
```

### 2. Styling Assertions with `styled` Helper

The gem uses a custom `styled` helper for asserting CSS classes:

```ruby
# In test_helper.rb
def styled(*elements, variable: "styles")
  "." + send(variable).dig(*elements).strip.gsub(":", "\\:").gsub(".", "\\.").gsub("/", "\\/").gsub(" ", ".")
end

# Usage in tests
assert_selector styled(:base)                    # Single style key
assert_selector styled(:colors, :default)        # Nested style keys
assert_selector styled(:outline, :on)            # State-based styles
```

### 3. Component Configuration Testing

Tests include component configurations to access styling constants:

```ruby
class Fluxbit::ButtonComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::ButtonComponent  # Provides access to `styles` hash
  
  def test_applies_correct_size_class
    render_inline(Fluxbit::ButtonComponent.new(size: 4)) { "Click me" }
    assert_selector ".text-base"  # Direct class assertion
  end
end
```

### 4. State and Variant Testing

Tests cover different component states and variants:

```ruby
def test_disables_button_when_disabled_is_true
  render_inline(Fluxbit::ButtonComponent.new(disabled: true)) { "Click me" }
  assert_selector styled(:disabled)
end

def test_applies_pill_class_when_pill_is_true
  render_inline(Fluxbit::ButtonComponent.new(pill: true)) { "Click me" }
  assert_selector styled(:pill, :on)
end
```

### 5. Form Component Testing

Form components include additional validation patterns:

```ruby
def test_colors
  %i[default success danger warning info].each do |color|
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "c#{color}", color: color))
    assert_selector ".border"
  end
end

def test_sizing
  (0..2).each do |size|
    render_inline(Fluxbit::Form::TextFieldComponent.new(name: "s#{size}", sizing: size))
    size_classes = Fluxbit::Config::Form::TextFieldComponent.styles[:sizes][size]
    escaped_classes = size_classes.gsub(":", "\\:").gsub(".", "\\.").gsub(" ", ".")
    assert_selector "input[name=\"s#{size}\"].#{escaped_classes}"
  end
end
```

### 6. Complex Component Testing with Slots

For components with slots (like modals with footers):

```ruby
def test_renders_modal_with_custom_footer
  render_inline(Fluxbit::ModalComponent.new) do |modal|
    modal.with_footer { "Custom Footer Content" }
  end

  assert_selector styled(:footer, :base), text: "Custom Footer Content"
end
```

### 7. Mock Object Testing

For components that depend on external objects (like pagination):

```ruby
PagyStub = Struct.new(:count, :last, :next, :page, :prev, :vars, keyword_init: true)

def build_pagy_stub(page:, last:, next_page:, prev_page:, vars: {})
  PagyStub.new(
    count: last * 10,
    last: last,
    # ... other attributes
  )
end

def test_pagination_behavior
  pagy = build_pagy_stub(page: 1, last: 5, next_page: 2, prev_page: nil)
  render_inline(Fluxbit::PaginationComponent.new(pagy))
  
  assert_selector "a#{styled(:page_link)}"
end
```

## System Testing

### System Test Configuration

System tests use Selenium with Firefox driver:

```ruby
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DRIVER = (ENV["HEADLESS"] == "false") ? :firefox : :headless_firefox
  DESKTOP_SCREEN_SIZE = [1400, 1400].freeze
  MOBILE_SCREEN_SIZE = [375, 667].freeze

  driven_by :selenium, using: DRIVER, screen_size: DESKTOP_SCREEN_SIZE
  
  def with_preview(path)
    visit "/rails/view_components/#{path}"
    wait_for_javascript
  end
end
```

### JavaScript Testing Utilities

```ruby
def wait_for_javascript
  assert_selector "html.js"
end

def resize_screen_to(screen)
  screen_size = (screen == :desktop) ? DESKTOP_SCREEN_SIZE : MOBILE_SCREEN_SIZE
  Capybara.current_session.current_window.resize_to(*screen_size)
end
```

## Test Helpers and Utilities

### Component Test Helper

```ruby
module Fluxbit
  module ComponentTestHelpers
    include ActionView::Helpers::TagHelper
    include ViewComponent::TestHelpers
    include Fluxbit::ViewHelper
    include Fluxbit::ComponentsHelper
  end
end
```

### Helper Method Testing

```ruby
class Fluxbit::ViewHelperTest < ActionView::TestCase
  include Fluxbit::ViewHelper

  def test_fx_body_class
    expected_class = "h-full bg-slate-100 dark:bg-slate-900 dark:text-white"
    assert_equal expected_class, fx_body_class
  end
end
```

## Test Organization Best Practices

### 1. File Naming
- Component tests: `*_component_test.rb`
- Helper tests: `*_helper_test.rb`
- Follow the same structure as the source code

### 2. Test Method Naming
- Use descriptive test names: `test_renders_button_with_default_styles`
- Include the expected behavior: `test_disables_button_when_disabled_is_true`
- Use snake_case for test method names

### 3. Assertion Patterns
- Use `assert_selector` for DOM assertions
- Use `assert_text` for text content assertions
- Use `refute_selector` for negative assertions
- Use `assert_no_selector` when element should not exist

### 4. Test Data
- Use meaningful test data that reflects real usage
- Create stub objects for complex dependencies
- Use fixtures sparingly, prefer inline test data

## Running Tests

### Command Structure
```bash
# Run all tests
rake test

# Run specific test file
bundle exec rails test test/components/fluxbit/button_component_test.rb

# Run specific test method
bundle exec rails test test/components/fluxbit/button_component_test.rb -n test_renders_button_with_default_styles

# Run with different test tasks
rake test:all      # Include demo app tests
rake test:system   # Run system tests only
```

### Test Tasks (Rakefile)
```ruby
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end

task default: :test
```

## Common Patterns Summary

1. **Always include component config** for accessing styling constants
2. **Use `styled` helper** for CSS class assertions
3. **Test default behavior first** then variations
4. **Use meaningful content** in component blocks
5. **Test both positive and negative cases**
6. **Create stub objects** for complex dependencies
7. **Group related assertions** logically
8. **Use descriptive test names** that explain the behavior being tested

This testing approach ensures comprehensive coverage of component behavior, styling, and integration while maintaining readable and maintainable tests.