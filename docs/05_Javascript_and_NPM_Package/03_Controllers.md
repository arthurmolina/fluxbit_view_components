---
label: Stimulus Controllers
title: Stimulus Controllers
---

This document provides comprehensive documentation for each Stimulus controller included in the Fluxbit ViewComponents JavaScript package.

## Controller Overview

All Fluxbit controllers follow the `fx-*` naming convention and are designed to work seamlessly with their corresponding ViewComponents. They utilize Flowbite's JavaScript components under the hood for enhanced functionality.

## Available Controllers

### UI Components
- **[FxModal](Controllers/FxModal.md)**: Modal dialog management with backdrop and event handling
- **[FxDrawer](Controllers/FxDrawer.md)**: Sliding drawer/sidebar components with position control
- **[FxProgress](Controllers/FxProgress.md)**: Progress bars with animations and multi-bar support
- **[FxSpinnerPercent](Controllers/FxSpinnerPercent.md)**: Circular progress indicators with animations

### Form Enhancement
- **[FxAutoSubmit](Controllers/FxAutoSubmit.md)**: Automatic form submission with debouncing
- **[FxSelectAll](Controllers/FxSelectAll.md)**: Bulk selection functionality with visual feedback

### Navigation & Interaction
- **[FxRowClick](Controllers/FxRowClick.md)**: Clickable table rows with navigation support
- **[FxMethodLink](Controllers/FxMethodLink.md)**: HTTP method support for links and buttons

### Utilities
- **[FxAssigner](Controllers/FxAssigner.md)**: Dynamic DOM element attribute modification

---

## Controller Events and Integration

### Global Events
Many controllers dispatch custom events that you can listen to for integration:

```javascript
// Modal events
document.addEventListener('fx-modal:opened', (event) => {
  console.log('Modal opened:', event.detail.modal)
})

// Selection events
document.addEventListener('fx-select-all:changed', (event) => {
  console.log('Selection changed:', event.detail.count)
})

// Custom event dispatching
document.dispatchEvent(new CustomEvent("toggleModal:my-modal"))
document.dispatchEvent(new CustomEvent("showDrawer:sidebar"))
```

### Controller Integration
Controllers can work together for complex interactions:

```html
&lt;!-- Auto-submit form with selection tracking --&gt;
&lt;div data-controller="fx-select-all fx-auto-submit"&gt;
  &lt;%= form_with model: @filter do |f| %&gt;
    &lt;input type="checkbox" data-fx-select-all-target="selectAll"&gt;

    &lt;% @items.each do |item| %&gt;
      &lt;input type="checkbox"
             name="selected_ids[]"
             value="&lt;%= item.id %&gt;"
             data-fx-select-all-target="select"
             data-action="change-&gt;fx-auto-submit#submit"&gt;
    &lt;% end %&gt;
  &lt;% end %&gt;
&lt;/div&gt;
```

## Vanilla JavaScript Access

All Fluxbit controllers are accessible from vanilla JavaScript through the global `FluxbitControllers` object:

### Global Controller Access

```javascript
// Available after page load
window.FluxbitControllers = {
  FxProgress,
  FxModal,
  FxDrawer,
  FxAssigner,
  FxAutoSubmit,
  FxMethodLink,
  FxRowClick,
  FxSelectAll,
  FxSpinnerPercent
}
```

### Static Helper Methods

Many controllers provide static methods for common operations:

```javascript
// Progress control
FluxbitControllers.FxProgress.updateProgress('[data-controller="fx-progress"]', 50);
FluxbitControllers.FxProgress.animateProgress('[data-controller="fx-progress"]', 100, 2000);

// Target specific elements by ID
FluxbitControllers.FxProgress.updateProgressById('[data-controller="fx-progress"]', 'upload', (controller) => {
  controller.incrementProgress(25);
});
```

### Direct Controller Instance Access

```javascript
// Get controller instance
const controller = FluxbitControllers.FxProgress.getController('[data-controller="fx-progress"]');

// Call instance methods
controller.setProgress(75);
controller.animateToProgress(100, 1500);
```

### Traditional Stimulus Access

```javascript
// Standard Stimulus approach
const element = document.querySelector('[data-controller="fx-progress"]');
const controller = application.getControllerForElementAndIdentifier(element, 'fx-progress');
controller.setProgress(50);
```

## Best Practices

1. **Performance**: Use appropriate debounce delays for auto-submit
2. **Accessibility**: Ensure clickable rows have proper focus indicators
3. **Error Handling**: Always check for element existence before manipulation
4. **Event Cleanup**: Controllers properly clean up event listeners on disconnect
5. **Integration**: Use custom events for loose coupling between controllers
6. **Vanilla JS**: Use static methods for simple operations, direct access for complex interactions

## Quick Reference

| Controller | Purpose | Key Features |
|------------|---------|--------------|
| [FxModal](Controllers/FxModal.md) | Modal dialogs | Auto-show, backdrop control, events |
| [FxDrawer](Controllers/FxDrawer.md) | Sliding drawers | 4 positions, edge positioning, scrolling |
| [FxAutoSubmit](Controllers/FxAutoSubmit.md) | Form automation | Debounced submission, input monitoring |
| [FxRowClick](Controllers/FxRowClick.md) | Clickable rows | Turbo frame support, smart click detection |
| [FxSelectAll](Controllers/FxSelectAll.md) | Bulk selection | Master checkbox, count display, UI updates |
| [FxMethodLink](Controllers/FxMethodLink.md) | HTTP methods | Form data collection, parameter handling |
| [FxAssigner](Controllers/FxAssigner.md) | DOM manipulation | Dynamic attributes, element references |
| [FxProgress](Controllers/FxProgress.md) | Progress bars | Multi-bar support, animations, vanilla JS API |
| [FxSpinnerPercent](Controllers/FxSpinnerPercent.md) | Progress indicators | Animations, custom text, accessibility |