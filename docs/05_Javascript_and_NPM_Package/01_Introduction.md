---
label: Stimulus Controllers 
title: Stimulus Controllers (JS) and NPM Package
---

Fluxbit ViewComponents provides a comprehensive JavaScript package that includes Stimulus controllers and utilities to enhance your Rails application with interactive components.

## Overview

The JavaScript package (`fluxbit-view-components`) is distributed via NPM and provides:

- **Stimulus Controllers**: Pre-built controllers for interactive components
- **Vanilla JavaScript API**: Global access methods for controller integration
- **Flowbite Integration**: Leverages Flowbite components for enhanced UI
- **Rails Integration**: Seamless integration with Rails applications using Turbo and Stimulus

## NPM Package

The package is published as `fluxbit-view-components` on NPM:

```json
{
  "name": "fluxbit-view-components",
  "version": "0.1.0",
  "description": "ViewComponents for Fluxbit View Components"
}
```

## Available Controllers

The package includes the following Stimulus controllers:

- **FxAssigner**: Handles dynamic assignment functionality
- **FxAutoSubmit**: Automatic form submission on input changes
- **FxDrawer**: Sliding drawer/sidebar component behavior
- **FxMethodLink**: Enhanced link handling with HTTP method support
- **FxModal**: Modal dialog component behavior
- **FxProgress**: Progress bars with animations and multi-bar support
- **FxRowClick**: Clickable table rows functionality
- **FxSelectAll**: Bulk selection functionality
- **FxSpinnerPercent**: Circular progress indicators with animations

## Dependencies

The package has the following peer dependencies:

- `@hotwired/stimulus`: ^3.0.0
- `@hotwired/turbo`: ^8.0.13
- `@rails/request.js`: >= 0.0.6

And includes these runtime dependencies:

- `flowbite`: ^3.1.2
- `@floating-ui/dom`: ^1.5.3

## Installation

The JavaScript package is automatically included when you install the gem and run the installer. For manual installation, see the [Installation Guide](../01_Getting_Started/02_Install.md).

## Usage

Controllers are automatically registered when using the gem's installer. For manual registration or custom setups, see the [Setup Guide](./Setup.md).