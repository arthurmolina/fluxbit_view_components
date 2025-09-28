---
label: FxAssigner
title: FxAssigner Controller
---

**Purpose**: Handles dynamic assignment operations by modifying DOM elements based on parameter configurations, useful for updating UI elements dynamically.

## Features
- Dynamic element attribute modification
- Element reference resolution (from other elements)
- Support for innerHTML, value, textContent, and custom attributes
- Nested parameter handling
- Event prevention options

## Actions
- `assign`: Execute assignment operations

## Usage Examples

### Basic Attribute Assignment
```html
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

### Element Reference Assignment
```html
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

### Complex Form Integration
```html
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