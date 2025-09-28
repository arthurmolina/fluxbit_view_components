---
label: FxSelectAll
title: FxSelectAll Controller
---

**Purpose**: Provides comprehensive bulk selection functionality with visual feedback and dynamic UI updates based on selection state.

## Features
- Master checkbox with indeterminate state
- Automatic selection count updates
- Dynamic show/hide elements based on selection
- Enable/disable buttons based on selection state
- Event triggering for integration with other controllers

## Static Targets
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

## Static Values
```javascript
static values = {
  disableIndeterminate: { type: Boolean, default: false }
}
```

## Usage Examples

### Basic Bulk Selection
```html
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

### Advanced Selection with Form Integration
```html
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

### Disable Indeterminate State
```html
&lt;div data-controller="fx-select-all"
     data-fx-select-all-disable-indeterminate-value="true"&gt;
  &lt;!-- Checkboxes here --&gt;
&lt;/div&gt;
```