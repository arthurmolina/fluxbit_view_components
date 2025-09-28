---
label: Setup
title: Setup and Configuration
---

This guide covers how to set up and configure the Fluxbit ViewComponents JavaScript package in your Rails application.

## Automatic Setup (Recommended)

The easiest way to set up the JavaScript package is through the gem installer:

```bash
bin/rails fluxbit_view_components:install
```

This installer will:
- Install the NPM package
- Configure Stimulus controllers
- Set up the necessary importmaps or build configurations

## Manual Setup

If you need to set up the package manually or customize the configuration:

### 1. Install the NPM Package

```bash
npm install fluxbit-view-components
# or
yarn add fluxbit-view-components
```

### 2. Import and Register Controllers

#### Option A: Register All Controllers

```javascript
// app/javascript/controllers/application.js
import { Application } from "@hotwired/stimulus"
import { registerFluxbitControllers } from "fluxbit-view-components"

const application = Application.start()

// Register all Fluxbit controllers
registerFluxbitControllers(application)

export { application }
```

#### Option B: Register Individual Controllers

```javascript
// app/javascript/controllers/application.js
import { Application } from "@hotwired/stimulus"
import {
  FxModal,
  FxDrawer,
  FxAutoSubmit,
  FxSpinnerPercent
} from "fluxbit-view-components"

const application = Application.start()

// Register specific controllers
application.register("fx-modal", FxModal)
application.register("fx-drawer", FxDrawer)
application.register("fx-auto-submit", FxAutoSubmit)
application.register("fx-spinner-percent", FxSpinnerPercent)

export { application }
```

### 3. Importmap Configuration

If using importmaps, add the package to your `config/importmap.rb`:

```ruby
# config/importmap.rb
pin "fluxbit-view-components", to: "fluxbit-view-components.js"
pin "@floating-ui/dom", to: "https://cdn.skypack.dev/@floating-ui/dom"
pin "flowbite", to: "https://cdn.skypack.dev/flowbite"
```

### 4. Build Configuration

If using a bundler like Webpack, esbuild, or Rollup, the package should work out of the box with standard ES module imports.

## Configuration Options

### Stimulus Controller Options

Most Fluxbit controllers accept configuration through data attributes:

```erb
<%= fx_modal(
  data: { 
    "fx-modal-backdrop-value": "static",
    "fx-modal-keyboard-value": "false" 
  }
) do %>
  <!-- Modal content -->
<% end %>
```

### Global Configuration

You can configure global defaults for components through the Rails configuration:

```ruby
# config/initializers/fluxbit_view_components.rb
Fluxbit::ViewComponents.configure do |config|
  config.modal_default_backdrop = "dynamic"
  config.drawer_default_position = "left"
end
```

## Troubleshooting

### Controllers Not Loading

If controllers aren't registering properly:

1. Check that Stimulus is properly installed and configured
2. Verify the NPM package is installed: `npm list fluxbit-view-components`
3. Check browser console for import errors
4. Ensure peer dependencies are installed

### Missing Dependencies

If you see errors about missing dependencies:

```bash
npm install @hotwired/stimulus @hotwired/turbo @rails/request.js
```

### Version Conflicts

Check that your peer dependency versions are compatible:

```bash
npm ls @hotwired/stimulus @hotwired/turbo
```

The package requires:
- Stimulus ^3.0.0
- Turbo ^8.0.13
- @rails/request.js >= 0.0.6