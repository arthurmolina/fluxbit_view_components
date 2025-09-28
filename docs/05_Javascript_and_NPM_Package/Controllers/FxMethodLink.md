---
label: FxMethodLink
title: FxMethodLink Controller
---

**Purpose**: Enhances links and buttons with HTTP method support (PUT, PATCH, DELETE), form data collection, and parameter handling using Rails UJS patterns.

## Features
- Support for all HTTP methods
- Form data collection from existing forms
- Nested parameter handling
- Element reference resolution
- CSRF token automatic inclusion
- Turbo Stream response handling

## Static Values
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

## Usage Examples

### Basic DELETE Link
```html
&lt;%= link_to "Delete User", user_path(@user),
    data: {
      controller: "fx-method-link",
      "fx-method-link-method-value": "DELETE",
      action: "fx-method-link#click"
    },
    class: "btn btn-danger" %&gt;
```

### With Form Data Collection
```html
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

### Advanced Parameter Passing with Element References
```html
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

### Custom Event Type
```html
&lt;%= select_tag :category, options_for_select([...]),
    data: {
      controller: "fx-method-link",
      "fx-method-link-event-type-value": "change",
      "fx-method-link-url-value": update_category_path,
      "fx-method-link-method-value": "PATCH"
    } %&gt;
```