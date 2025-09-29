---
label: Progress
title: Fluxbit::ProgressComponent or fx_progress
---

The `Fluxbit::ProgressComponent` is a customizable progress bar component that extends `Fluxbit::Component`.
It allows you to create progress indicators with various styles, sizes, colors, and label positioning options
to display completion status or loading progress.

To start using the progress component you can use the default way to call the component:

```html
&lt;%= render Fluxbit::ProgressComponent.new(progress: 45) %&gt;

&lt;!-- or --&gt;

&lt;%= render Fluxbit::ProgressComponent.new do %&gt;
    &lt;!-- Progress bars don't typically have block content --&gt;
&lt;% end %&gt;
```

or you can use the alias (from the helpers):

```html
&lt;%= fx_progress(progress: 45) %&gt;

&lt;!-- With labels --&gt;
&lt;%= fx_progress(progress: 75, text_label: "Loading", label_progress: true, label_text: true) %&gt;

&lt;!-- With custom label styling --&gt;
&lt;%= fx_progress(progress: 60, text_label: "Upload", label_text: true, label_html: { class: "font-bold text-green-600" }) %&gt;
```

The result is:

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="default" panels="params,source"></lookbook-embed>

## Options

| Param                      | Default  | Description
|:---------------------------|:---------|:------------
| progress:                  | 0        | The progress percentage (0-100). Values outside this range are automatically clamped.
| color:                     | :default | Sets the color scheme of the progress bar (default, dark, blue, red, green, yellow, indigo, purple, cyan, gray, lime, pink, teal).
| size:                      | 1        | Specifies the size of the progress bar (0 to 3: sm, md, lg, xl).
| text_label:                | nil      | Label text to display with the progress bar.
| label_progress:            | false    | Whether to show the progress percentage as a label.
| label_text:                | false    | Whether to show the text label.
| progress_label_position:   | :inside  | Position of the progress percentage label (:inside or :outside).
| text_label_position:       | :outside | Position of the text label (:inside or :outside).
| label_html:                | {}       | HTML attributes for label elements. Supports :remove_class to customize label styling.
| stimulus:                  | false    | Whether to add Stimulus controller data attributes for JavaScript interactions.
| remove_class:              | ""       | Classes to be removed from the default class list.
| **props                    |          | Additional HTML attributes.

## Slots

This component does not define any named slots. The progress bar displays the completion percentage based on the `progress` parameter and optional labels.

## Examples

### Default progress bars

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="default" panels="source"></lookbook-embed>

### Progress colors

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="progress_colors" panels="source"></lookbook-embed>

### Progress sizes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="progress_sizes" panels="source"></lookbook-embed>

### Progress with outside labels

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="progress_with_outside_labels" panels="source"></lookbook-embed>

### Progress with inside labels

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="progress_with_inside_labels" panels="source"></lookbook-embed>

### Progress with mixed label positions

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="progress_with_mixed_labels" panels="source"></lookbook-embed>

### Adding/Removing classes

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="adding_removing_classes" panels="source"></lookbook-embed>

### Adding other properties

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="adding_other_properties" panels="source"></lookbook-embed>

### Interactive JavaScript controls

<lookbook-embed app="/lookbook/" preview="Fluxbit::Components::ProgressComponentPreview" scenario="interactive_javascript" panels="source"></lookbook-embed>

## When to use

Use `Progress` whenever you need to display completion status, loading progress, or any metric that can be represented as a percentage. It's ideal for file uploads, form completion, data processing, or any task with measurable progress.

### Text Label Sizing

The component automatically adjusts text size and padding based on the progress bar size:
- **Size 0-1 (Small/Medium)**: Uses `text-xs` with minimal padding for better fit in narrow bars
- **Size 2-3 (Large/XL)**: Uses larger text sizes with more padding for better readability

Labels inside the progress bar use flexbox centering to ensure proper alignment regardless of bar height.

## Accessibility

* The progress bar automatically includes proper width styling based on the progress value.
* Add ARIA attributes like `role="progressbar"`, `aria-valuenow`, `aria-valuemin`, and `aria-valuemax` for screen reader compatibility.
* Labels provide context for the progress being displayed.
* The component supports keyboard navigation when interactive elements are added.

## JavaScript Integration

The Progress component includes a comprehensive Stimulus controller for dynamic updates, animations, and multi-progress bar support. Enable it by setting `stimulus: true`:

```html
&lt;%= fx_progress(progress: 50, stimulus: true, id: "my-progress") %&gt;
```

### Controller Architecture

The Fluxbit Progress component uses a separate Stimulus controller file located at:
- **Controller File**: `app/assets/javascripts/fluxbit_view_components/progress_controller.js`
- **Registration**: Automatically registered via `index.js` as `fx-progress`
- **Import Pattern**: Uses ES6 modules with separate controller files (not inline controllers)

### Vanilla JavaScript API (Recommended)

The easiest way to control progress bars is through the global `FluxbitControllers` API:

```javascript
// Simple static methods - most convenient
FluxbitControllers.FxProgress.updateProgress('[data-controller="fx-progress"]', 75);
FluxbitControllers.FxProgress.animateProgress('[data-controller="fx-progress"]', 100, 2000);
FluxbitControllers.FxProgress.resetProgress('[data-controller="fx-progress"]');
FluxbitControllers.FxProgress.completeProgress('[data-controller="fx-progress"]');

// Real-time updates example
function updateUploadProgress(percentage) {
  FluxbitControllers.FxProgress.updateProgress('#upload-progress', percentage);
  if (percentage >= 100) {
    FluxbitControllers.FxProgress.completeProgress('#upload-progress');
  }
}
```

### Multiple Progress Bars

Control multiple progress bars within the same scope using `data-progress-id`:

```html
&lt;div data-controller="fx-progress"&gt;
  &lt;!-- First progress bar --&gt;
  &lt;%= fx_progress(progress: 30, text_label: "Upload", stimulus: true,
                  data: { progress_id: "upload" }) %&gt;

  &lt;!-- Second progress bar --&gt;
  &lt;%= fx_progress(progress: 70, text_label: "Download", stimulus: true,
                  data: { progress_id: "download" }) %&gt;

  &lt;!-- Control specific progress bars --&gt;
  &lt;button data-action="click-&gt;fx-progress#increment"
          data-fx-progress-amount-param="10"
          data-fx-progress-id-param="upload"&gt;+10% Upload&lt;/button&gt;

  &lt;button data-action="click-&gt;fx-progress#increment"
          data-fx-progress-amount-param="20"
          data-fx-progress-id-param="download"&gt;+20% Download&lt;/button&gt;
&lt;/div&gt;
```

### Direct Controller Access

For advanced scenarios, access the controller instance directly:

```javascript
// Get controller instance
const controller = FluxbitControllers.FxProgress.getController('[data-controller="fx-progress"]');

// Call instance methods
controller.setProgress(75);
controller.incrementProgress(10);
controller.decrementProgress(5);
controller.reset();
controller.complete();

// Animated transitions
controller.animateToProgress(80, 1500);  // Animate to 80% over 1.5 seconds

// Animation control
controller.setAnimate(false);        // Disable animations
controller.setSpeed('fast');         // Set animation speed (slow, normal, fast, very_fast)

// Target specific progress bars by ID
FluxbitControllers.FxProgress.updateProgressById('[data-controller="fx-progress"]', 'upload', (progressController) => {
  progressController.incrementProgress(25);
  progressController.setSpeed('fast');
});
```

### Stimulus Data Attributes

When `stimulus: true` is enabled, the component automatically adds:

- `data-controller="fx-progress"` - Registers the Stimulus controller
- `data-fx-progress-progress-value="X"` - Initial progress value
- `data-fx-progress-animate-value="true"` - Enables animations
- `data-fx-progress-target="bar"` - Progress bar element target
- `data-fx-progress-target="progressLabel"` - Progress percentage label target
- `data-fx-progress-target="textLabel"` - Text label target

### Real-World Examples

#### File Upload Progress

```javascript
function uploadFile(file) {
  const formData = new FormData();
  formData.append('file', file);

  // Reset progress
  FluxbitControllers.FxProgress.resetProgress('#upload-progress');

  const xhr = new XMLHttpRequest();
  xhr.upload.addEventListener('progress', (event) => {
    if (event.lengthComputable) {
      const percentage = Math.round((event.loaded / event.total) * 100);
      FluxbitControllers.FxProgress.updateProgress('#upload-progress', percentage);
    }
  });

  xhr.onload = function() {
    FluxbitControllers.FxProgress.completeProgress('#upload-progress');
  };

  xhr.open('POST', '/upload');
  xhr.send(formData);
}
```

#### Multi-Step Form Progress

```javascript
class MultiStepForm {
  constructor() {
    this.currentStep = 1;
    this.totalSteps = 4;
    this.updateProgress();
  }

  nextStep() {
    if (this.currentStep < this.totalSteps) {
      this.currentStep++;
      this.updateProgress();
    }
  }

  updateProgress() {
    const percentage = (this.currentStep / this.totalSteps) * 100;
    FluxbitControllers.FxProgress.animateProgress('#form-progress', percentage, 500);
  }
}
```

#### System Resource Monitor

```javascript
// Update multiple progress bars with system stats
async function updateSystemStats() {
  const response = await fetch('/api/system-stats');
  const stats = await response.json();

  // Update each resource metric
  FluxbitControllers.FxProgress.updateProgressById('#system-monitor', 'cpu', (controller) => {
    controller.animateToProgress(stats.cpu, 500);
  });

  FluxbitControllers.FxProgress.updateProgressById('#system-monitor', 'memory', (controller) => {
    controller.animateToProgress(stats.memory, 500);
  });

  FluxbitControllers.FxProgress.updateProgressById('#system-monitor', 'disk', (controller) => {
    controller.animateToProgress(stats.disk, 500);
  });
}
```

### Creating Custom Controllers

When creating new Fluxbit Stimulus controllers, follow this pattern:

1. **Create separate controller file**: `app/assets/javascripts/fluxbit_view_components/your_controller.js`
2. **Use ES6 export default**: `export default class extends Controller { ... }`
3. **Add import to index.js**: `import FxYourController from './your_controller'`
4. **Add to exports**: Include in the export object and registerFluxbitControllers function
5. **Never use inline controllers**: Controllers must be in separate files, not embedded in the main JS file

## Customization

You can customize the appearance and behavior of this component by passing different initialization parameters and adding custom styles.
To do this you can create a initializer file like the:

```ruby
# /config/initializers/change_progress_component_defaults.rb

Fluxbit::Config::ProgressComponent.color = :blue # the default is :default
Fluxbit::Config::ProgressComponent.size = 2 # the default is 1
Fluxbit::Config::ProgressComponent.label_progress = true # the default is false
Fluxbit::Config::ProgressComponent.progress_label_position = :outside # the default is :inside
Fluxbit::Config::ProgressComponent.label_html = { class: "font-semibold" } # the default is {}
Fluxbit::Config::ProgressComponent.styles[:base] = 'w-full bg-gray-100 rounded-lg dark:bg-gray-800' # custom base styling
```

## Dependencies

- [**Stimulus**](https://stimulus.hotwired.dev/): Used for JavaScript interactions when `stimulus: true` is enabled.
- [**Tailwind CSS**](https://tailwindcss.com/): Used for styling the component.
- [**Flowbite**](https://flowbite.com/): Used for styling.

## Styles

```ruby
<%= html_escape(JSON.pretty_generate(Fluxbit::Config::ProgressComponent.styles)) %>
```

## References

- [Flowbite Progress](https://flowbite.com/docs/components/progress)
- [Flowbite React Progress](https://flowbite-react.com/docs/components/progress)