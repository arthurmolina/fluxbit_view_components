---
label: FxModal
title: FxModal Controller
---

**Purpose**: Controls modal dialog behavior including opening, closing, backdrop handling, and event management.

## Features
- Two usage patterns: direct element control or target-based control
- Auto-show functionality
- Configurable backdrop behavior
- Custom event listeners
- Flowbite integration with lazy loading

## Static Values
```javascript
static values = {
  autoShow: false,           // Boolean - Auto show modal on connect
  placement: 'bottom-right', // String - Modal placement
  backdrop: 'dynamic',       // String - Backdrop behavior ('dynamic', 'static', or false)
  backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-30',
  closable: false,          // Boolean - Allow closing via ESC/backdrop
  onHide: Object,           // Object - Callback for hide events
  onShow: Object,           // Object - Callback for show events
  onToggle: Object          // Object - Callback for toggle events
}
```

## Targets
- `modal`: Modal elements to control

## Actions
- `show`: Show the modal
- `hide`: Hide the modal
- `toggle`: Toggle modal visibility

## Usage Examples

### Basic Modal
```html
&lt;%= fx_modal(id: "basic-modal", data: { controller: "fx-modal" }) do %&gt;
  &lt;div class="p-6"&gt;
    &lt;h2 class="text-lg font-semibold"&gt;Modal Title&lt;/h2&gt;
    &lt;p&gt;Modal content goes here...&lt;/p&gt;
  &lt;/div&gt;
&lt;% end %&gt;

&lt;%= fx_button(data: { action: "fx-modal#toggle", "fx-modal-id": "basic-modal" }) do %&gt;
  Open Modal
&lt;% end %&gt;
```

### Auto-Show Modal with Custom Backdrop
```html
&lt;%= fx_modal(
  id: "auto-modal",
  data: {
    controller: "fx-modal",
    "fx-modal-auto-show-value": true,
    "fx-modal-backdrop-value": "static"
  }
) do %&gt;
  &lt;div class="p-6"&gt;
    &lt;h2&gt;Welcome!&lt;/h2&gt;
    &lt;p&gt;This modal opens automatically.&lt;/p&gt;
  &lt;/div&gt;
&lt;% end %&gt;
```

### Multiple Modals with Target Control
```html
&lt;div data-controller="fx-modal"&gt;
  &lt;%= fx_modal(id: "modal-1", data: { "fx-modal-target": "modal" }) do %&gt;
    &lt;p&gt;First modal&lt;/p&gt;
  &lt;% end %&gt;

  &lt;%= fx_modal(id: "modal-2", data: { "fx-modal-target": "modal" }) do %&gt;
    &lt;p&gt;Second modal&lt;/p&gt;
  &lt;% end %&gt;

  &lt;%= fx_button(data: { action: "fx-modal#show", "fx-modal-id": "modal-1" }) do %&gt;
    Show Modal 1
  &lt;% end %&gt;
&lt;/div&gt;
```

## Event System
```javascript
// Listen for custom events
document.addEventListener("showModal:my-modal", () => {
  // Modal will be shown
});

// Dispatch custom events
document.dispatchEvent(new CustomEvent("toggleModal:my-modal"));
```