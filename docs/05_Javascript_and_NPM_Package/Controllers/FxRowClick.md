---
label: FxRowClick
title: FxRowClick Controller
---

**Purpose**: Makes entire table rows clickable for navigation, while preserving interactive elements within rows.

## Features
- Smart click detection (avoids buttons, links, inputs)
- Turbo Frame support for SPA-like navigation
- Proper event handling and cleanup
- URL and frame value configuration

## Static Values
```javascript
static values = {
  url: String,  // URL to navigate to
  frame: String // Turbo frame target (optional)
}
```

## Usage Examples

### Basic Clickable Rows
```html
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

### With Turbo Frame Navigation
```html
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