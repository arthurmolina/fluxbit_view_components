---
label: FxAutoSubmit
title: FxAutoSubmit Controller
---

**Purpose**: Automatically submits forms when input values change, with configurable debouncing to prevent excessive submissions.

## Features
- Configurable debounce delay
- Support for specific form targeting
- Automatic cleanup of timeouts
- Works with any form input events

## Static Values
```javascript
static values = {
  delay: { type: Number, default: 150 } // Debounce delay in milliseconds
}
```

## Actions
- `submit`: Trigger form submission (with debouncing)

## Usage Examples

### Basic Auto-Submit Form
```html
&lt;%= form_with model: @search, local: true, data: { controller: "fx-auto-submit" } do |f| %&gt;
  &lt;%= f.text_field :query,
      placeholder: "Search...",
      data: { action: "input-&gt;fx-auto-submit#submit" } %&gt;
  &lt;%= f.select :category, options_for_select([...]),
      data: { action: "change-&gt;fx-auto-submit#submit" } %&gt;
&lt;% end %&gt;
```

### Custom Delay Configuration
```html
&lt;%= form_with model: @filter, local: true,
    data: {
      controller: "fx-auto-submit",
      "fx-auto-submit-delay-value": 500
    } do |f| %&gt;
  &lt;%= f.text_field :name, data: { action: "input-&gt;fx-auto-submit#submit" } %&gt;
  &lt;%= f.range_field :price, data: { action: "input-&gt;fx-auto-submit#submit" } %&gt;
&lt;% end %&gt;
```

### External Form Targeting
```html
&lt;%= form_with id: "search-form", model: @search, local: true do |f| %&gt;
  &lt;%= f.text_field :query %&gt;
&lt;% end %&gt;

&lt;div data-controller="fx-auto-submit"&gt;
  &lt;input type="text"
         data-action="input-&gt;fx-auto-submit#submit"
         data-fx-auto-submit-form-id-param="search-form"&gt;
&lt;/div&gt;
```