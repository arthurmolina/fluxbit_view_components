---
label: SpinnerPercent
title: Fluxbit::SpinnerPercentComponent or fx_spinner_percent
---

The `Fluxbit::SpinnerPercentComponent` is a customizable progress indicator component that extends `Fluxbit::Component`. It allows you to create circular progress indicators with percentage display, animated updates via JavaScript, and supports various colors, sizes, and accessibility features.

To start using the spinner percent you can use the default way to call the component:

```html
&lt;%= render Fluxbit::SpinnerPercentComponent.new(percent: 50) %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::SpinnerPercentComponent.new(percent: 75) do %&gt;
    Custom content (rarely used)
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_spinner_percent(percent: 50) %&gt;

&lt;!-- or --&gt;

&lt;%= fx_spinner_percent(percent: 75) do %&gt;
    Custom content (rarely used)
&lt;% end %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param              | Default     | Description
|:-------------------|:------------|:------------
| color:             | :default    | Sets the color scheme of the progress indicator (:default, :info, :success, :failure, :warning, :pink, :purple).
| size:              | 1           | Specifies the size of the progress indicator (-1 to 4). Size -1 is the smallest (48x48px).
| percent:           | 0           | The percentage completion value (0 to 100).
| label:             | "Loading..." | The aria-label for accessibility and screen reader text.
| show_percent:      | true        | Whether to display the percentage text inside the progress circle.
| text:              | nil         | Custom text to display instead of percentage. If provided, overrides show_percent.
| label_html:        | {}          | HTML attributes for the inner text element (class, id, data attributes, etc.). Supports remove_class key.
| animate:           | false       | Whether to apply continuous rotation animation to the entire circle.
| speed:             | :normal     | The speed of rotation animation (:slow, :normal, :fast, :very_fast).
| remove_class:      | ""          | Classes to be removed from the default class list.
| **props            |             | Additional HTML attributes.

## Slots

This component does not define any named slots. Content is primarily controlled through the `percent` parameter and optional percentage text display.

```html
&lt;%= render Fluxbit::SpinnerPercentComponent.new(percent: 75, show_percent: true) %&gt;
```

## Examples

### Default progress indicators

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Different colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="colors" panels="source"></lookbook-embed>

### Different sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="sizes" panels="source"></lookbook-embed>

### Different percentage values

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="percentages" panels="source"></lookbook-embed>

### Percentage text options

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="percentage_text_options" panels="source"></lookbook-embed>

### Custom text content

Display custom text instead of percentage values for different use cases:

```html
<!-- Custom text instead of percentage -->
<%= fx_spinner_percent(percent: 75, text: "Loading...") %>

<!-- Status indicators -->
<%= fx_spinner_percent(percent: 100, text: "✓ Complete", color: :success) %>
<%= fx_spinner_percent(percent: 0, text: "Starting...", color: :info) %>
<%= fx_spinner_percent(percent: 50, text: "Processing", color: :warning) %>

<!-- No text displayed when text is nil and show_percent is false -->
<%= fx_spinner_percent(percent: 25, text: nil, show_percent: false) %>

<!-- Text parameter overrides show_percent -->
<%= fx_spinner_percent(percent: 80, text: "Custom", show_percent: true) %>
```

### Customizing label appearance

Use the `label_html` parameter to customize the styling of the text inside the progress circle:

```html
<!-- Bigger purple font (removes default text-sm) -->
<%= fx_spinner_percent(
  percent: 85,
  text: "85%",
  label_html: {
    class: "text-lg text-purple-600 font-bold",
    remove_class: "text-sm"
  }
) %>

<!-- Custom styling with ID -->
<%= fx_spinner_percent(
  percent: 60,
  label_html: {
    class: "text-xl font-semibold",
    id: "progress-label"
  }
) %>

<!-- Remove multiple default classes and add custom ones -->
<%= fx_spinner_percent(
  percent: 75,
  text: "Loading...",
  label_html: {
    class: "text-green-600 font-medium text-base",
    remove_class: "text-sm font-semibold"
  }
) %>

<!-- Additional data attributes -->
<%= fx_spinner_percent(
  percent: 50,
  label_html: {
    class: "text-blue-600 font-bold",
    "data-testid": "progress-text",
    title: "Upload progress"
  }
) %>

<!-- Smaller size with custom styling -->
<%= fx_spinner_percent(
  size: -1,
  percent: 90,
  text: "Done!",
  label_html: {
    class: "text-xs text-green-500 font-bold",
    remove_class: "text-sm"
  }
) %>
```

### Progress indicators in cards

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="in_cards" panels="source"></lookbook-embed>

### Custom labels and accessibility

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="custom_labels" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

### JavaScript control

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="javascript_control" panels="source"></lookbook-embed>

### Animation examples

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::SpinnerPercentComponentPreview" scenario="animation_examples" panels="source"></lookbook-embed>

## JavaScript API

The SpinnerPercent component includes a Stimulus controller that enables dynamic updates via JavaScript:

### Methods

- `setPercent(percent)` - Instantly update the progress percentage
- `animateToPercent(targetPercent, duration)` - Smoothly animate to a new percentage over time
- `setAnimate(animate)` - Toggle rotation animation on/off
- `startAnimation()` - Start continuous rotation animation
- `stopAnimation()` - Stop continuous rotation animation
- `setSpeed(speed)` - Change the rotation animation speed (slow, normal, fast, very_fast)

### Usage Examples

```javascript
// Get controller reference
const spinner = document.getElementById('my-spinner');
const controller = application.getControllerForElementAndIdentifier(spinner, 'fx-spinner-percent');

// Update progress instantly
controller.setPercent(75);

// Animate to new percentage (2 second animation)
controller.animateToPercent(90, 2000);

// Control rotation animation
controller.startAnimation();  // Start spinning
controller.stopAnimation();   // Stop spinning
controller.setAnimate(true);  // Toggle animation on

// Control animation speed
controller.setSpeed('fast');   // Change to fast rotation
controller.setSpeed('slow');   // Change to slow rotation

// You can also use data attributes to set initial values
spinner.dataset.fxSpinnerPercentPercentValue = '50';
spinner.dataset.fxSpinnerPercentAnimateValue = 'true';
spinner.dataset.fxSpinnerPercentSpeedValue = 'fast';
```

### Event Handling

The component automatically updates its visual state when the `percent` value changes, including:
- SVG stroke-dashoffset for progress visualization
- Percentage text display
- ARIA attributes for accessibility

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_spinner_percent_component_defaults.rb

Fluxbit::Config::SpinnerPercentComponent.color = :info # the default is :default
Fluxbit::Config::SpinnerPercentComponent.size = 2 # the default is 1 (range: -1 to 4)
Fluxbit::Config::SpinnerPercentComponent.percent = 25 # the default is 0
Fluxbit::Config::SpinnerPercentComponent.show_percent = false # the default is true
Fluxbit::Config::SpinnerPercentComponent.text = "Loading..." # the default is nil
Fluxbit::Config::SpinnerPercentComponent.label = "Progress..." # the default is "Loading..."
Fluxbit::Config::SpinnerPercentComponent.styles[:sizes] = ["w-12 h-12", "w-16 h-16", "w-20 h-20", "w-24 h-24", "w-32 h-32"] # custom sizes
```

## Dependencies

- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Stimulus**](https://stimulus.hotwired.dev/): Used for JavaScript interactivity and progress updates.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::SpinnerPercentComponent.styles)) %>
```

## Accessibility

The SpinnerPercent component follows accessibility best practices:

- Uses `role="progressbar"` for proper screen reader identification
- Includes `aria-valuenow`, `aria-valuemin`, and `aria-valuemax` attributes
- Provides customizable `aria-label` through the `label` parameter
- Includes screen reader text with the `sr-only` class
- Maintains focus and keyboard navigation compatibility

## When to use

Use `SpinnerPercent` when you need to:
- Show progress for file uploads, downloads, or data processing
- Display completion status with visual percentage feedback
- Create interactive progress indicators that update via JavaScript
- Provide accessible progress information for screen readers
- Build progress dashboards or status monitoring interfaces

## References

- [WAI-ARIA Progressbar Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/meter/)
- [SVG Circle Progress Indicators](https://css-tricks.com/building-progress-ring-quickly/)
- [Stimulus Controller Guide](https://stimulus.hotwired.dev/handbook/building-something-real)