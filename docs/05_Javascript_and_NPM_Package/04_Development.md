# Development Guide

This guide covers how to develop, test, and contribute to the Fluxbit ViewComponents JavaScript package.

## Development Environment Setup

### Prerequisites
- Node.js 16+ and npm/yarn
- Ruby 3.0+ and Bundler
- Basic knowledge of Stimulus and Rails

### Getting Started

1. **Clone and Install Dependencies**
```bash
git clone https://github.com/arthurmolina/fluxbit_view_components.git
cd fluxbit_view_components
bundle install
yarn install
```

2. **Start Development Server**
```bash
bin/dev
```

This starts the demo Rails application at `localhost:3000` with Lookbook component previews.

## Project Structure

### JavaScript Source Files
```
app/assets/javascripts/fluxbit_view_components/
├── index.js                    # Main export file
├── assigner_controller.js      # Dynamic assignment controller
├── auto_submit_controller.js   # Auto-submit functionality
├── drawer_controller.js        # Drawer/sidebar controller
├── method_link_controller.js   # HTTP method link controller
├── modal_controller.js         # Modal dialog controller
├── row_click_controller.js     # Clickable rows controller
└── select_all_controller.js    # Bulk selection controller
```

### Build Configuration
```
rollup.config.js               # Rollup build configuration
package.json                   # NPM package configuration
```

## Development Workflow

### 1. Building JavaScript Assets

The JavaScript package uses Rollup for building and bundling:

```bash
# Build for development
yarn build

# Build and preview changes (shows diff and package contents)
yarn prerelease

# Watch for changes (if configured)
yarn dev
```

### 2. Testing Controllers

#### Manual Testing via Demo App
The demo application includes comprehensive previews for testing controllers:

```bash
bin/dev
# Navigate to localhost:3000
# Test components in the Lookbook interface
```

#### Controller Integration Testing
Create test scenarios in the demo app:

```erb
&lt;!-- demo/app/views/test/controller_test.html.erb --&gt;
&lt;div data-controller="fx-modal fx-auto-submit"&gt;
  &lt;!-- Test multiple controller integration --&gt;
&lt;/div&gt;
```

#### Browser Console Testing
Use browser developer tools to test controller functionality:

```javascript
// Test modal controller
document.dispatchEvent(new CustomEvent("showModal:test-modal"))

// Test select-all functionality
const controller = application.getControllerForElementAndIdentifier(
  document.querySelector('[data-controller="fx-select-all"]'),
  'fx-select-all'
)
controller.refresh()
```

### 3. Creating New Controllers

#### Controller Template
```javascript
// app/assets/javascripts/fluxbit_view_components/my_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element"]
  static values = { 
    option: { type: String, default: "default" }
  }

  connect() {
    // Initialize controller
    console.log("MyController connected")
  }

  disconnect() {
    // Clean up resources
    console.log("MyController disconnected")
  }

  // Action methods
  myAction(event) {
    // Handle action
  }
}
```

#### Export New Controller
Update `index.js` to export the new controller:

```javascript
// app/assets/javascripts/fluxbit_view_components/index.js
import FxMy from './my_controller'

export {
  // ... existing exports
  FxMy
}

export function registerFluxbitControllers(application) {
  // ... existing registrations
  application.register('fx-my', FxMy)
}
```

### 4. Component Integration

#### ViewComponent Integration
Create corresponding ViewComponent if needed:

```ruby
# app/components/fluxbit/my_component.rb
module Fluxbit
  class MyComponent < ViewComponent::Base
    def initialize(**options)
      @options = options
    end

    private

    attr_reader :options

    def controller_data
      {
        controller: "fx-my",
        "fx-my-option-value": options[:option]
      }
    end
  end
end
```

#### Template with Controller
```erb
&lt;!-- app/components/fluxbit/my_component.html.erb --&gt;
&lt;div &lt;%= html_attributes(data: controller_data) %&gt;&gt;
  &lt;%= content %&gt;
&lt;/div&gt;
```

## Testing Strategy

### 1. Unit Testing Controllers

Create test files for individual controllers:

```javascript
// test/javascript/controllers/modal_controller_test.js
import { Application } from "@hotwired/stimulus"
import FxModal from "../../../app/assets/javascripts/fluxbit_view_components/modal_controller"

describe("FxModal Controller", () => {
  let application
  let container

  beforeEach(() => {
    container = document.createElement("div")
    document.body.appendChild(container)
    application = Application.start()
    application.register("fx-modal", FxModal)
  })

  afterEach(() => {
    document.body.removeChild(container)
  })

  test("connects successfully", () => {
    container.innerHTML = `
      <div data-controller="fx-modal" id="test-modal">
        Modal content
      </div>
    `
    
    const controller = application.getControllerForElementAndIdentifier(
      container.querySelector('[data-controller="fx-modal"]'),
      'fx-modal'
    )
    
    expect(controller).toBeDefined()
  })
})
```

### 2. Integration Testing

Test controllers with ViewComponents:

```ruby
# test/components/fluxbit/modal_component_test.rb
require "test_helper"

class Fluxbit::ModalComponentTest < ViewComponent::TestCase
  test "renders with controller data attributes" do
    render_inline(Fluxbit::ModalComponent.new(id: "test-modal")) { "Content" }
    
    assert_selector '[data-controller="fx-modal"]'
    assert_selector '[id="test-modal"]'
  end

  test "includes auto-show configuration" do
    render_inline(
      Fluxbit::ModalComponent.new(
        id: "auto-modal", 
        auto_show: true
      )
    ) { "Content" }
    
    assert_selector '[data-fx-modal-auto-show-value="true"]'
  end
end
```

### 3. System Testing

Test full user interactions:

```ruby
# test/system/modal_interaction_test.rb
require "application_system_test_case"

class ModalInteractionTest < ApplicationSystemTestCase
  test "opening and closing modal" do
    visit root_path
    
    click_button "Open Modal"
    assert_selector "#test-modal", visible: true
    
    click_button "Close"
    assert_no_selector "#test-modal", visible: true
  end
end
```

## Build and Release Process

### 1. Version Management

Update version in `package.json`:

```json
{
  "name": "fluxbit-view-components",
  "version": "0.2.0",
  "description": "ViewComponents for Fluxbit View Components"
}
```

### 2. Build Process

```bash
# Clean build
rm -rf dist/
yarn build

# Verify build output
ls -la app/assets/javascripts/
```

### 3. Release Checklist

- [ ] Update version in `package.json`
- [ ] Run tests: `yarn test`
- [ ] Build package: `yarn build`
- [ ] Test integration in demo app
- [ ] Preview release: `yarn prerelease`
- [ ] Publish: `yarn release`
- [ ] Update gem version if needed
- [ ] Create GitHub release
- [ ] Update documentation

### 4. NPM Publishing

```bash
# Build and preview
yarn prerelease

# Publish to NPM
yarn release

# Verify publication
npm view fluxbit-view-components
```

## Debugging

### 1. Common Issues

#### Controller Not Loading
- Check Stimulus is properly configured
- Verify controller is registered in `index.js`
- Check browser console for import errors
- Ensure peer dependencies are installed

#### Flowbite Integration Issues
```javascript
// Debug Flowbite loading
console.log('Modal available:', typeof Modal !== 'undefined')
console.log('Drawer available:', typeof Drawer !== 'undefined')

// Force load Flowbite
import('flowbite').then(module => {
  console.log('Flowbite loaded:', module)
})
```

#### Event Handling Problems
```javascript
// Debug event listeners
const controller = application.getControllerForElementAndIdentifier(element, 'fx-modal')
console.log('Controller:', controller)
console.log('Element:', controller.element)
```

### 2. Development Tools

#### Browser DevTools
- Use Stimulus Inspector browser extension
- Monitor network requests for Flowbite imports
- Check console for JavaScript errors
- Use Performance tab for optimization

#### Logging
Add debug logging to controllers:

```javascript
connect() {
  if (this.debugValue) {
    console.log(`${this.identifier} connected:`, this.element)
  }
}
```

#### Testing in Different Browsers
- Test in Chrome, Firefox, Safari
- Check mobile browser compatibility
- Verify touch event handling (for drawers)

## Contributing

### 1. Code Style

Follow existing patterns:
- Use ES6+ syntax
- Follow Stimulus conventions
- Add JSDoc comments for complex methods
- Use consistent error handling

### 2. Pull Request Process

1. Fork the repository
2. Create feature branch: `git checkout -b feature/my-controller`
3. Make changes with tests
4. Run tests: `yarn test && rake test`
5. Build and test: `yarn prerelease`
6. Submit pull request with description

### 3. Documentation

- Update controller documentation
- Add usage examples
- Include integration examples
- Update changelog

## Performance Considerations

### 1. Controller Optimization

- Use `connect()` for initialization only
- Clean up resources in `disconnect()`
- Debounce frequent operations
- Lazy load Flowbite components

### 2. Bundle Size

- Keep controllers focused and small
- Avoid unnecessary dependencies
- Use dynamic imports for large libraries
- Monitor bundle size changes

### 3. Memory Management

```javascript
disconnect() {
  // Clean up event listeners
  if (this.timeout) {
    clearTimeout(this.timeout)
  }
  
  // Remove Flowbite instances
  Object.values(this.modals).forEach(modal => {
    if (modal.destroy) modal.destroy()
  })
  
  // Clear references
  this.modals = {}
}
```