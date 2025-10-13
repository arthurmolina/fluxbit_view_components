---
label: FxThemeButton
title: FxThemeButton Controller
---

**Purpose**: Controls theme switching functionality with support for light, dark, and system modes, including persistence and automatic icon updates.

## Features
- Three theme modes: light, dark, and system
- Automatic persistence to localStorage
- System preference detection via `prefers-color-scheme`
- Automatic icon updates based on current theme
- Custom event dispatching for theme changes
- Seamless integration with Tailwind CSS dark mode

## Static Values
```javascript
static values = {
  theme: {
    type: String,
    default: "system"  // Initial theme mode
  }
}
```

## Targets
- `lightIcon`: Icon element displayed in light mode
- `darkIcon`: Icon element displayed in dark mode
- `systemIcon`: Icon element displayed in system mode

## Actions
- `toggle`: Cycles through light → dark → system → light

## Usage Examples

### Basic Theme Button
```html
&lt;%= fx_theme_button %&gt;
```

### With Tooltip
```html
&lt;%= fx_theme_button(
  tooltip_text: "Toggle theme",
  tooltip_placement: :bottom
) %&gt;
```

### Custom Styling
```html
&lt;%= fx_theme_button(
  color: :info,
  size: 3,
  class: "fixed top-4 right-4"
) %&gt;
```

### Manual HTML Structure
```html
&lt;button data-controller="fx-theme-button"
        data-action="click-&gt;fx-theme-button#toggle"
        class="rounded-full p-2"&gt;
  &lt;span class="hidden" data-fx-theme-button-target="lightIcon"&gt;
    &lt;!-- Sun icon --&gt;
  &lt;/span&gt;
  &lt;span class="hidden" data-fx-theme-button-target="darkIcon"&gt;
    &lt;!-- Moon icon --&gt;
  &lt;/span&gt;
  &lt;span class="hidden" data-fx-theme-button-target="systemIcon"&gt;
    &lt;!-- Computer icon --&gt;
  &lt;/span&gt;
&lt;/button&gt;
```

## Theme Modes

### Light Mode
- Sets `localStorage.theme = "light"`
- Removes `dark` class from `<html>` element
- Shows sun icon

### Dark Mode
- Sets `localStorage.theme = "dark"`
- Adds `dark` class to `<html>` element
- Shows moon icon

### System Mode
- Removes `localStorage.theme` key
- Applies theme based on `prefers-color-scheme` media query
- Shows computer icon
- Automatically updates when system preference changes

## Event System

### Listening to Theme Changes
```javascript
// Listen for theme change events
document.addEventListener('fx-theme-button:changed', (event) => {
  console.log('Theme changed to:', event.detail.theme);
  // event.detail.theme can be: 'light', 'dark', or 'system'
});
```

### Event Details
```javascript
{
  detail: {
    theme: "light" | "dark" | "system"
  }
}
```

## Tailwind Dark Mode Setup

### Required Configuration
```javascript
// tailwind.config.js
module.exports = {
  darkMode: 'class', // REQUIRED: Use class strategy
  // ... other config
}
```

### HTML Class Strategy
The controller applies the `dark` class to the `<html>` element:
```html
&lt;!-- Light mode --&gt;
&lt;html&gt;

&lt;!-- Dark mode --&gt;
&lt;html class="dark"&gt;
```

## Persistence Behavior

### localStorage Keys
- `theme: "light"` - Light mode selected
- `theme: "dark"` - Dark mode selected
- `theme` key removed - System mode selected

### Loading Saved Theme
On page load, the controller:
1. Checks for saved theme in localStorage
2. Falls back to checking for `dark` class on `<html>`
3. Defaults to "system" if nothing found
4. Applies the theme and updates icons

## Icon Management

### Icon Targets
Each icon is wrapped in a `<span>` with the appropriate target:
```html
&lt;span data-fx-theme-button-target="lightIcon" class="hidden"&gt;
  &lt;!-- Sun icon (shown in light mode) --&gt;
&lt;/span&gt;
&lt;span data-fx-theme-button-target="darkIcon" class="hidden"&gt;
  &lt;!-- Moon icon (shown in dark mode) --&gt;
&lt;/span&gt;
&lt;span data-fx-theme-button-target="systemIcon" class="hidden"&gt;
  &lt;!-- Computer icon (shown in system mode) --&gt;
&lt;/span&gt;
```

### Automatic Updates
The controller automatically:
- Hides all icons
- Shows only the icon for the current theme
- Updates on theme changes

## Methods

### Public Methods
```javascript
// Toggle theme (cycles through modes)
controller.toggle()

// Apply specific theme
controller.applyTheme("light" | "dark" | "system")

// Get saved theme from localStorage
controller.getSavedTheme()

// Save theme to localStorage
controller.saveTheme("light" | "dark" | "system")

// Update icon visibility
controller.updateIcon()
```

## Integration Examples

### With Navigation Bar
```html
&lt;nav class="flex items-center justify-between p-4 bg-white dark:bg-gray-800"&gt;
  &lt;div class="logo"&gt;My App&lt;/div&gt;

  &lt;div class="flex items-center gap-4"&gt;
    &lt;%= fx_theme_button %&gt;
    &lt;%= fx_button(href: "/profile") { "Profile" } %&gt;
  &lt;/div&gt;
&lt;/nav&gt;
```

### With User Preferences
```javascript
// Listen for theme changes and save to user preferences
document.addEventListener('fx-theme-button:changed', (event) => {
  fetch('/api/user/preferences', {
    method: 'PATCH',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ theme: event.detail.theme })
  });
});
```

### Programmatic Theme Control
```javascript
// Get the controller instance
const element = document.querySelector('[data-controller="fx-theme-button"]');
const app = Stimulus.Application.start();
const controller = app.getControllerForElementAndIdentifier(element, 'fx-theme-button');

// Set theme programmatically
controller.applyTheme('dark');
controller.saveTheme('dark');
controller.updateIcon();
```

## System Preference Detection

### Media Query
The controller uses the `prefers-color-scheme` media query in system mode:
```javascript
if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
  html.classList.add("dark");
} else {
  html.classList.remove("dark");
}
```

### Automatic Updates
In system mode, the theme automatically updates when:
- Page loads with system mode selected
- User manually selects system mode
- (Note: Real-time OS theme changes require additional listeners)

## Accessibility

### ARIA Labels (Optional Enhancement)
```html
&lt;button data-controller="fx-theme-button"
        data-action="click-&gt;fx-theme-button#toggle"
        aria-label="Toggle theme"&gt;
  &lt;!-- Icons --&gt;
&lt;/button&gt;
```

### Keyboard Support
- Works with standard button keyboard navigation
- Activates with Enter or Space key
- Focusable with Tab key

## Best Practices

1. **Place in persistent layouts** (navbar, header) for consistent access
2. **Provide tooltips** for better UX
3. **Test with system dark mode** to ensure proper detection
4. **Use semantic colors** that work in both light and dark modes
5. **Consider user preference** persistence across sessions
6. **Test icon visibility** in all three modes

## Common Use Cases

- Application-wide theme switching
- User preference settings
- Dark mode toggle in navigation
- Theme selector in settings panels
- Reading mode toggles
- Accessibility improvements

## Troubleshooting

**Dark mode not applying**: Ensure `tailwind.config.js` has `darkMode: 'class'`
**Icons not updating**: Check that all three icon targets exist
**Theme not persisting**: Verify localStorage is available and not blocked
**System mode not working**: Test `prefers-color-scheme` media query support
**Multiple buttons conflicting**: Each button operates independently on the same global theme

## Browser Support

- **localStorage**: All modern browsers
- **prefers-color-scheme**: Chrome 76+, Firefox 67+, Safari 12.1+
- **Stimulus**: Works with Stimulus 3.x
- **Tailwind Dark Mode**: Tailwind CSS 2.0+

## Related Components

- [ThemeButton Component](../../02_Components/ThemeButton.md) - The Ruby component that uses this controller
- [Button Component](../../02_Components/Button.md) - Base button component
