---
label: FxDrawer
title: FxDrawer Controller
---

**Purpose**: Manages sliding drawer/sidebar components with position control, backdrop handling, and swipe gestures.

## Features
- Four placement positions (left, right, top, bottom)
- Backdrop and body scrolling control
- Edge positioning with offset
- Auto-show capability
- Proper cleanup on disconnect

## Static Values
```javascript
static values = {
  autoShow: false,          // Boolean - Auto show drawer on connect
  placement: 'left',        // String - Drawer position ('left', 'right', 'top', 'bottom')
  backdrop: true,           // Boolean - Show backdrop
  bodyScrolling: false,     // Boolean - Allow body scrolling when open
  edge: false,              // Boolean - Position at screen edge
  edgeOffset: String,       // String - Offset from edge
  backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-30',
  onHide: Object,           // Object - Hide callback
  onShow: Object,           // Object - Show callback
  onToggle: Object          // Object - Toggle callback
}
```

## Targets
- `drawer`: Drawer elements to control

## Actions
- `show`: Show the drawer
- `hide`: Hide the drawer
- `toggle`: Toggle drawer visibility

## Usage Examples

### Basic Left Drawer
```html
&lt;%= fx_drawer(id: "nav-drawer", data: { controller: "fx-drawer" }) do %&gt;
  &lt;nav class="p-4"&gt;
    &lt;ul&gt;
      &lt;li&gt;&lt;a href="/"&gt;Home&lt;/a&gt;&lt;/li&gt;
      &lt;li&gt;&lt;a href="/about"&gt;About&lt;/a&gt;&lt;/li&gt;
      &lt;li&gt;&lt;a href="/contact"&gt;Contact&lt;/a&gt;&lt;/li&gt;
    &lt;/ul&gt;
  &lt;/nav&gt;
&lt;% end %&gt;

&lt;%= fx_button(data: { action: "fx-drawer#toggle", "fx-drawer-id": "nav-drawer" }) do %&gt;
  Menu
&lt;% end %&gt;
```

### Right Drawer with Custom Settings
```html
&lt;%= fx_drawer(
  id: "settings-drawer",
  data: {
    controller: "fx-drawer",
    "fx-drawer-placement-value": "right",
    "fx-drawer-backdrop-value": false,
    "fx-drawer-body-scrolling-value": true
  }
) do %&gt;
  &lt;div class="p-6"&gt;
    &lt;h3&gt;Settings&lt;/h3&gt;
    &lt;!-- Settings form --&gt;
  &lt;/div&gt;
&lt;% end %&gt;
```

### Bottom Drawer with Edge Positioning
```html
&lt;%= fx_drawer(
  id: "bottom-sheet",
  data: {
    controller: "fx-drawer",
    "fx-drawer-placement-value": "bottom",
    "fx-drawer-edge-value": true,
    "fx-drawer-edge-offset-value": "64px"
  }
) do %&gt;
  &lt;div class="p-4"&gt;
    &lt;h4&gt;Quick Actions&lt;/h4&gt;
    &lt;!-- Action buttons --&gt;
  &lt;/div&gt;
&lt;% end %&gt;
```

## Event System
```javascript
// Custom events
document.addEventListener("showDrawer:my-drawer", () => {
  // Drawer will be shown
});

document.dispatchEvent(new CustomEvent("hideDrawer:my-drawer"));
```