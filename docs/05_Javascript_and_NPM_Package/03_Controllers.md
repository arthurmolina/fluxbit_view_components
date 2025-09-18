# Stimulus Controllers

This document provides comprehensive documentation for each Stimulus controller included in the Fluxbit ViewComponents JavaScript package.

## Controller Overview

All Fluxbit controllers follow the `fx-*` naming convention and are designed to work seamlessly with their corresponding ViewComponents. They utilize Flowbite's JavaScript components under the hood for enhanced functionality.

---

## FxModal Controller

**Purpose**: Controls modal dialog behavior including opening, closing, backdrop handling, and event management.

### Features
- Two usage patterns: direct element control or target-based control
- Auto-show functionality
- Configurable backdrop behavior
- Custom event listeners
- Flowbite integration with lazy loading

### Static Values
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

### Targets
- `modal`: Modal elements to control

### Actions
- `show`: Show the modal
- `hide`: Hide the modal
- `toggle`: Toggle modal visibility

### Usage Examples

#### Basic Modal
```erb
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

#### Auto-Show Modal with Custom Backdrop
```erb
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

#### Multiple Modals with Target Control
```erb
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

### Event System
```javascript
// Listen for custom events
document.addEventListener("showModal:my-modal", () => {
  // Modal will be shown
});

// Dispatch custom events
document.dispatchEvent(new CustomEvent("toggleModal:my-modal"));
```

---

## FxDrawer Controller

**Purpose**: Manages sliding drawer/sidebar components with position control, backdrop handling, and swipe gestures.

### Features
- Four placement positions (left, right, top, bottom)
- Backdrop and body scrolling control
- Edge positioning with offset
- Auto-show capability
- Proper cleanup on disconnect

### Static Values
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

### Targets
- `drawer`: Drawer elements to control

### Actions
- `show`: Show the drawer
- `hide`: Hide the drawer
- `toggle`: Toggle drawer visibility

### Usage Examples

#### Basic Left Drawer
```erb
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

#### Right Drawer with Custom Settings
```erb
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

#### Bottom Drawer with Edge Positioning
```erb
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

### Event System
```javascript
// Custom events
document.addEventListener("showDrawer:my-drawer", () => {
  // Drawer will be shown
});

document.dispatchEvent(new CustomEvent("hideDrawer:my-drawer"));
```

---

## FxAutoSubmit Controller

**Purpose**: Automatically submits forms when input values change, with configurable debouncing to prevent excessive submissions.

### Features
- Configurable debounce delay
- Support for specific form targeting
- Automatic cleanup of timeouts
- Works with any form input events

### Static Values
```javascript
static values = {
  delay: { type: Number, default: 150 } // Debounce delay in milliseconds
}
```

### Actions
- `submit`: Trigger form submission (with debouncing)

### Usage Examples

#### Basic Auto-Submit Form
```erb
&lt;%= form_with model: @search, local: true, data: { controller: "fx-auto-submit" } do |f| %&gt;
  &lt;%= f.text_field :query, 
      placeholder: "Search...",
      data: { action: "input-&gt;fx-auto-submit#submit" } %&gt;
  &lt;%= f.select :category, options_for_select([...]),
      data: { action: "change-&gt;fx-auto-submit#submit" } %&gt;
&lt;% end %&gt;
```

#### Custom Delay Configuration
```erb
&lt;%= form_with model: @filter, local: true, 
    data: { 
      controller: "fx-auto-submit",
      "fx-auto-submit-delay-value": 500 
    } do |f| %&gt;
  &lt;%= f.text_field :name, data: { action: "input-&gt;fx-auto-submit#submit" } %&gt;
  &lt;%= f.range_field :price, data: { action: "input-&gt;fx-auto-submit#submit" } %&gt;
&lt;% end %&gt;
```

#### External Form Targeting
```erb
&lt;%= form_with id: "search-form", model: @search, local: true do |f| %&gt;
  &lt;%= f.text_field :query %&gt;
&lt;% end %&gt;

&lt;div data-controller="fx-auto-submit"&gt;
  &lt;input type="text" 
         data-action="input-&gt;fx-auto-submit#submit" 
         data-fx-auto-submit-form-id-param="search-form"&gt;
&lt;/div&gt;
```

---

## FxRowClick Controller

**Purpose**: Makes entire table rows clickable for navigation, while preserving interactive elements within rows.

### Features
- Smart click detection (avoids buttons, links, inputs)
- Turbo Frame support for SPA-like navigation
- Proper event handling and cleanup
- URL and frame value configuration

### Static Values
```javascript
static values = { 
  url: String,  // URL to navigate to
  frame: String // Turbo frame target (optional)
}
```

### Usage Examples

#### Basic Clickable Rows
```erb
&lt;table class="w-full"&gt;
  &lt;thead&gt;
    &lt;tr&gt;
      &lt;th&gt;Name&lt;/th&gt;
      &lt;th&gt;Email&lt;/th&gt;
      &lt;th&gt;Actions&lt;/th&gt;
    &lt;/tr&gt;
  &lt;/thead&gt;
  &lt;tbody&gt;
    &lt;% @users.each do |user| %&gt;
      &lt;tr data-controller="fx-row-click" 
          data-fx-row-click-url-value="&lt;%= user_path(user) %&gt;"
          class="hover:bg-gray-50 cursor-pointer"&gt;
        &lt;td&gt;&lt;%= user.name %&gt;&lt;/td&gt;
        &lt;td&gt;&lt;%= user.email %&gt;&lt;/td&gt;
        &lt;td&gt;
          &lt;%= link_to "Edit", edit_user_path(user), class: "btn btn-sm" %&gt;
          &lt;%= link_to "Delete", user_path(user), method: :delete, class: "btn btn-sm" %&gt;
        &lt;/td&gt;
      &lt;/tr&gt;
    &lt;% end %&gt;
  &lt;/tbody&gt;
&lt;/table&gt;
```

#### With Turbo Frame Navigation
```erb
&lt;turbo-frame id="user-details"&gt;
  &lt;!-- User details will load here --&gt;
&lt;/turbo-frame&gt;

&lt;table&gt;
  &lt;tbody&gt;
    &lt;% @users.each do |user| %&gt;
      &lt;tr data-controller="fx-row-click" 
          data-fx-row-click-url-value="&lt;%= user_path(user) %&gt;"
          data-fx-row-click-frame-value="user-details"&gt;
        &lt;td&gt;&lt;%= user.name %&gt;&lt;/td&gt;
        &lt;td&gt;&lt;%= user.email %&gt;&lt;/td&gt;
      &lt;/tr&gt;
    &lt;% end %&gt;
  &lt;/tbody&gt;
&lt;/table&gt;
```

---

## FxSelectAll Controller

**Purpose**: Provides comprehensive bulk selection functionality with visual feedback and dynamic UI updates based on selection state.

### Features
- Master checkbox with indeterminate state
- Automatic selection count updates
- Dynamic show/hide elements based on selection
- Enable/disable buttons based on selection state
- Event triggering for integration with other controllers

### Static Targets
```javascript
static targets = [
  "selectAll",              // Master checkbox
  "select",                 // Individual checkboxes
  "disableOnEmptySelect",   // Elements to disable when nothing selected
  "enableOnEmptySelect",    // Elements to enable when nothing selected  
  "hideOnEmptySelect",      // Elements to hide when nothing selected
  "showOnEmptySelect",      // Elements to show when nothing selected
  "count"                   // Elements to display count
]
```

### Static Values
```javascript
static values = {
  disableIndeterminate: { type: Boolean, default: false }
}
```

### Usage Examples

#### Basic Bulk Selection
```erb
&lt;div data-controller="fx-select-all"&gt;
  &lt;table class="w-full"&gt;
    &lt;thead&gt;
      &lt;tr&gt;
        &lt;th class="w-12"&gt;
          &lt;input type="checkbox" 
                 data-fx-select-all-target="selectAll"
                 class="rounded"&gt;
        &lt;/th&gt;
        &lt;th&gt;Name&lt;/th&gt;
        &lt;th&gt;Email&lt;/th&gt;
      &lt;/tr&gt;
    &lt;/thead&gt;
    &lt;tbody&gt;
      &lt;% @users.each do |user| %&gt;
        &lt;tr&gt;
          &lt;td&gt;
            &lt;input type="checkbox" 
                   name="selected_ids[]" 
                   value="&lt;%= user.id %&gt;"
                   data-fx-select-all-target="select"
                   class="rounded"&gt;
          &lt;/td&gt;
          &lt;td&gt;&lt;%= user.name %&gt;&lt;/td&gt;
          &lt;td&gt;&lt;%= user.email %&gt;&lt;/td&gt;
        &lt;/tr&gt;
      &lt;% end %&gt;
    &lt;/tbody&gt;
  &lt;/table&gt;
  
  &lt;!-- Action buttons that appear when items are selected --&gt;
  &lt;div class="mt-4 hidden" data-fx-select-all-target="showOnEmptySelect"&gt;
    &lt;span data-fx-select-all-target="count"&gt;0&lt;/span&gt; items selected
    &lt;button class="btn btn-danger" 
            data-fx-select-all-target="disableOnEmptySelect"&gt;
      Delete Selected
    &lt;/button&gt;
  &lt;/div&gt;
&lt;/div&gt;
```

#### Advanced Selection with Form Integration
```erb
&lt;%= form_with url: bulk_actions_path, local: true, data: { controller: "fx-select-all" } do |f| %&gt;
  &lt;div class="flex justify-between items-center mb-4"&gt;
    &lt;label class="flex items-center"&gt;
      &lt;input type="checkbox" 
             data-fx-select-all-target="selectAll"
             class="mr-2"&gt;
      Select All
    &lt;/label&gt;
    
    &lt;div class="hidden" data-fx-select-all-target="showOnEmptySelect"&gt;
      &lt;span class="mr-2"&gt;
        &lt;strong data-fx-select-all-target="count"&gt;0&lt;/strong&gt; selected
      &lt;/span&gt;
      &lt;%= f.select :action, [['Delete', 'delete'], ['Archive', 'archive']], 
          { prompt: 'Choose action' },
          { data: { fx_select_all_target: "disableOnEmptySelect" } } %&gt;
      &lt;%= f.submit "Execute", 
          class: "btn btn-primary",
          data: { fx_select_all_target: "disableOnEmptySelect" } %&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  
  &lt;div class="grid gap-4"&gt;
    &lt;% @items.each do |item| %&gt;
      &lt;div class="border p-4 rounded"&gt;
        &lt;label class="flex items-start"&gt;
          &lt;input type="checkbox"
                 name="selected_ids[]"
                 value="&lt;%= item.id %&gt;"
                 data-fx-select-all-target="select"
                 class="mt-1 mr-3"&gt;
          &lt;div&gt;
            &lt;h4&gt;&lt;%= item.title %&gt;&lt;/h4&gt;
            &lt;p class="text-gray-600"&gt;&lt;%= item.description %&gt;&lt;/p&gt;
          &lt;/div&gt;
        &lt;/label&gt;
      &lt;/div&gt;
    &lt;% end %&gt;
  &lt;/div&gt;
&lt;% end %&gt;
```

#### Disable Indeterminate State
```erb
&lt;div data-controller="fx-select-all" 
     data-fx-select-all-disable-indeterminate-value="true"&gt;
  &lt;!-- Checkboxes here --&gt;
&lt;/div&gt;
```

---

## FxMethodLink Controller

**Purpose**: Enhances links and buttons with HTTP method support (PUT, PATCH, DELETE), form data collection, and parameter handling using Rails UJS patterns.

### Features
- Support for all HTTP methods
- Form data collection from existing forms
- Nested parameter handling
- Element reference resolution
- CSRF token automatic inclusion
- Turbo Stream response handling

### Static Values
```javascript
static values = { 
  method: "get",           // HTTP method
  url: String,             // Request URL (falls back to element href)
  params: Object,          // Additional parameters
  formDataId: String,      // ID of form to collect data from
  debug: false,            // Debug mode for logging
  eventType: "click"       // Event type to listen for
}
```

### Usage Examples

#### Basic DELETE Link
```erb
&lt;%= link_to "Delete User", user_path(@user),
    data: { 
      controller: "fx-method-link",
      "fx-method-link-method-value": "DELETE",
      action: "fx-method-link#click"
    },
    class: "btn btn-danger" %&gt;
```

#### With Form Data Collection
```erb
&lt;%= form_with id: "user-filters", local: true do |f| %&gt;
  &lt;%= f.text_field :search %&gt;
  &lt;%= f.select :role, ['admin', 'user'] %&gt;
&lt;% end %&gt;

&lt;%= link_to "Export Filtered Users", export_users_path,
    data: { 
      controller: "fx-method-link",
      "fx-method-link-method-value": "POST",
      "fx-method-link-form-data-id-value": "user-filters"
    } %&gt;
```

#### Advanced Parameter Passing with Element References
```erb
&lt;div id="selected-count"&gt;5&lt;/div&gt;
&lt;input id="search-query" value="active users"&gt;

&lt;%= button_tag "Process Selected",
    data: { 
      controller: "fx-method-link",
      "fx-method-link-method-value": "PATCH",
      "fx-method-link-url-value": process_users_path,
      "fx-method-link-params-value": {
        batch_size: 10,
        query: {
          element: "#search-query",
          attribute: "value"
        },
        count: {
          element: "#selected-count", 
          attribute: "textContent"
        }
      }.to_json
    } %&gt;
```

#### Custom Event Type
```erb
&lt;%= select_tag :category, options_for_select([...]),
    data: { 
      controller: "fx-method-link",
      "fx-method-link-event-type-value": "change",
      "fx-method-link-url-value": update_category_path,
      "fx-method-link-method-value": "PATCH"
    } %&gt;
```

---

## FxAssigner Controller

**Purpose**: Handles dynamic assignment operations by modifying DOM elements based on parameter configurations, useful for updating UI elements dynamically.

### Features
- Dynamic element attribute modification
- Element reference resolution (from other elements)
- Support for innerHTML, value, textContent, and custom attributes
- Nested parameter handling
- Event prevention options

### Actions
- `assign`: Execute assignment operations

### Usage Examples

#### Basic Attribute Assignment
```erb
&lt;div id="status-display"&gt;Pending&lt;/div&gt;
&lt;div id="color-indicator" class="bg-gray-200"&gt;&lt;/div&gt;

&lt;%= select_tag :status, 
    options_for_select([
      ['Pending', 'pending'],
      ['Approved', 'approved'], 
      ['Rejected', 'rejected']
    ]),
    data: { 
      controller: "fx-assigner",
      action: "change-&gt;fx-assigner#assign",
      "fx-assigner-change-param": {
        "#status-display": {
          textContent: "Processing..."
        },
        "#color-indicator": {
          class: "bg-yellow-200"
        }
      }.to_json
    } %&gt;
```

#### Element Reference Assignment
```erb
&lt;div id="source-text"&gt;Hello World&lt;/div&gt;
&lt;input id="target-input" type="text"&gt;
&lt;div id="display-area"&gt;Empty&lt;/div&gt;

&lt;%= button_tag "Copy Content",
    data: { 
      controller: "fx-assigner",
      action: "click-&gt;fx-assigner#assign",
      "fx-assigner-change-param": {
        "#target-input": {
          value: {
            element: "#source-text",
            attribute: "textContent"
          }
        },
        "#display-area": {
          innerHTML: {
            element: "#source-text", 
            attribute: "innerHTML"
          }
        }
      }.to_json
    } %&gt;
```

#### Complex Form Integration
```erb
&lt;%= form_with model: @product do |f| %&gt;
  &lt;%= f.select :category_id, options_from_collection_for_select(@categories, :id, :name),
      data: { 
        controller: "fx-assigner",
        action: "change-&gt;fx-assigner#assign",
        "fx-assigner-prevent-default-param": "true",
        "fx-assigner-change-param": {
          "#category-description": {
            textContent: {
              element: "option:checked",
              attribute: "data-description"
            }
          },
          "#category-settings": {
            class: "block"
          }
        }.to_json
      } %&gt;
      
  &lt;div id="category-description" class="text-sm text-gray-600 mt-2"&gt;&lt;/div&gt;
  &lt;div id="category-settings" class="hidden mt-4"&gt;
    &lt;!-- Category-specific settings --&gt;
  &lt;/div&gt;
&lt;% end %&gt;
```

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

```erb
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

## Best Practices

1. **Performance**: Use appropriate debounce delays for auto-submit
2. **Accessibility**: Ensure clickable rows have proper focus indicators
3. **Error Handling**: Always check for element existence before manipulation
4. **Event Cleanup**: Controllers properly clean up event listeners on disconnect
5. **Integration**: Use custom events for loose coupling between controllers