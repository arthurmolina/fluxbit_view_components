---
label: FxSpinnerPercent
title: FxSpinnerPercent Controller
---

**Purpose**: Manages circular progress spinner components with dynamic percentage updates, smooth animations, and customizable rotation effects.

## Features
- Dynamic percentage updates with visual circle progress
- Smooth animation transitions between percentage values
- Optional continuous rotation animation
- Configurable animation speeds
- ARIA accessibility attributes for screen readers
- Support for custom text display alongside percentage

## Static Values
```javascript
static values = {
  percent: { type: Number, default: 0 },           // Current percentage (0-100)
  animate: { type: Boolean, default: false },      // Enable continuous rotation
  speed: { type: String, default: "normal" },      // Animation speed
  hasCustomText: { type: Boolean, default: false } // Whether custom text is set
}
```

## Static Targets
```javascript
static targets = [
  "progress",  // SVG circle element showing progress
  "text"       // Text element displaying percentage/custom text
]
```

## Public Methods
- `setPercent(percent)`: Instantly update progress to new percentage
- `animateToPercent(targetPercent, duration)`: Smoothly animate to new percentage
- `setAnimate(animate)`: Toggle continuous rotation animation
- `startAnimation()`: Start continuous rotation
- `stopAnimation()`: Stop continuous rotation
- `setSpeed(speed)`: Change rotation animation speed

## Usage Examples

### Basic Progress Spinner
```html
&lt;%= fx_spinner_percent(
  percent: 75,
  color: :info,
  data: { controller: "fx-spinner-percent" }
) %&gt;
```

### With Custom Text and Animation
```html
&lt;%= fx_spinner_percent(
  percent: 50,
  text: "Loading...",
  animate: true,
  speed: :fast,
  color: :success,
  label_html: { class: "text-lg font-bold" }
) %&gt;
```

### JavaScript Control
```html
&lt;%= fx_spinner_percent(
  id: "upload-progress",
  percent: 0,
  text: "Starting...",
  color: :info
) %&gt;

&lt;script&gt;
  // Get controller reference
  const spinner = document.getElementById('upload-progress');
  const controller = application.getControllerForElementAndIdentifier(spinner, 'fx-spinner-percent');

  // Update progress instantly
  controller.setPercent(25);

  // Animate to new percentage over 2 seconds
  controller.animateToPercent(75, 2000);

  // Start rotation animation
  controller.startAnimation();

  // Change animation speed
  controller.setSpeed('fast');

  // Stop animation
  controller.stopAnimation();
&lt;/script&gt;
```

### File Upload Progress
```html
&lt;div class="upload-container"&gt;
  &lt;%= fx_spinner_percent(
    id: "file-upload-progress",
    percent: 0,
    text: "Ready",
    color: :default,
    size: 2
  ) %&gt;

  &lt;input type="file" id="file-input" class="mt-4"&gt;
&lt;/div&gt;

&lt;script&gt;
  document.getElementById('file-input').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (!file) return;

    const spinner = document.getElementById('file-upload-progress');
    const controller = application.getControllerForElementAndIdentifier(spinner, 'fx-spinner-percent');

    // Simulate upload progress
    let progress = 0;
    const interval = setInterval(() =&gt; {
      progress += Math.random() * 10;
      if (progress &gt;= 100) {
        progress = 100;
        clearInterval(interval);

        // Update to show completion
        controller.setPercent(100);
        setTimeout(() =&gt; {
          // Update text content manually
          const textElement = spinner.querySelector('[data-fx-spinner-percent-target="text"]');
          if (textElement) textElement.textContent = 'Complete!';
        }, 100);
      } else {
        controller.animateToPercent(Math.min(progress, 95), 300);
      }
    }, 200);
  });
&lt;/script&gt;
```

### Multi-Step Process Indicator
```html
&lt;div class="process-steps"&gt;
  &lt;% %w[Upload Validate Process Complete].each_with_index do |step, index| %&gt;
    &lt;div class="step flex items-center mb-4"&gt;
      &lt;%= fx_spinner_percent(
        id: "step-#{index}",
        percent: 0,
        text: step,
        color: :default,
        size: 1,
        label_html: { class: "text-sm" }
      ) %&gt;
      &lt;span class="ml-3"&gt;&lt;%= step %&gt;&lt;/span&gt;
    &lt;/div&gt;
  &lt;% end %&gt;
&lt;/div&gt;

&lt;script&gt;
  function updateStep(stepIndex, percentage, color = 'default') {
    const spinner = document.getElementById(`step-${stepIndex}`);
    const controller = application.getControllerForElementAndIdentifier(spinner, 'fx-spinner-percent');

    if (percentage === 100) {
      controller.animateToPercent(100, 500);
      // Update color classes manually for completion
      const progressCircle = spinner.querySelector('[data-fx-spinner-percent-target="progress"]');
      if (progressCircle) {
        progressCircle.classList.remove('stroke-blue-600', 'stroke-gray-200');
        progressCircle.classList.add('stroke-green-500');
      }
    } else {
      controller.animateToPercent(percentage, 300);
    }
  }

  // Example usage
  updateStep(0, 100); // Complete upload
  updateStep(1, 75);  // Validation in progress
  updateStep(2, 30);  // Processing started
&lt;/script&gt;
```

### Dashboard Metrics
```html
&lt;div class="metrics-grid grid grid-cols-3 gap-6"&gt;
  &lt;div class="metric-card"&gt;
    &lt;h3 class="text-lg font-semibold mb-4"&gt;Server Load&lt;/h3&gt;
    &lt;%= fx_spinner_percent(
      id: "server-load",
      percent: 45,
      color: :warning,
      size: 2,
      animate: true,
      speed: :slow
    ) %&gt;
  &lt;/div&gt;

  &lt;div class="metric-card"&gt;
    &lt;h3 class="text-lg font-semibold mb-4"&gt;Memory Usage&lt;/h3&gt;
    &lt;%= fx_spinner_percent(
      id: "memory-usage",
      percent: 78,
      color: :failure,
      size: 2
    ) %&gt;
  &lt;/div&gt;

  &lt;div class="metric-card"&gt;
    &lt;h3 class="text-lg font-semibold mb-4"&gt;Disk Space&lt;/h3&gt;
    &lt;%= fx_spinner_percent(
      id: "disk-space",
      percent: 34,
      color: :success,
      size: 2
    ) %&gt;
  &lt;/div&gt;
&lt;/div&gt;

&lt;script&gt;
  // Update metrics every 5 seconds
  setInterval(() =&gt; {
    // Simulate real-time metric updates
    const serverLoad = document.getElementById('server-load');
    const memoryUsage = document.getElementById('memory-usage');
    const diskSpace = document.getElementById('disk-space');

    const serverController = application.getControllerForElementAndIdentifier(serverLoad, 'fx-spinner-percent');
    const memoryController = application.getControllerForElementAndIdentifier(memoryUsage, 'fx-spinner-percent');
    const diskController = application.getControllerForElementAndIdentifier(diskSpace, 'fx-spinner-percent');

    // Random metric updates
    serverController.animateToPercent(Math.floor(Math.random() * 100), 1000);
    memoryController.animateToPercent(Math.floor(Math.random() * 100), 1000);
    diskController.animateToPercent(Math.floor(Math.random() * 100), 1000);
  }, 5000);
&lt;/script&gt;
```

## Animation Speeds
- `slow`: 3 seconds per rotation
- `normal`: 1 second per rotation (default)
- `fast`: 0.5 seconds per rotation
- `very_fast`: 0.3 seconds per rotation

## Accessibility Features
- Automatic ARIA attributes (`role="progressbar"`, `aria-valuenow`, etc.)
- Screen reader compatible with customizable labels
- Progress updates announce changes to assistive technology
- Proper semantic markup for accessibility compliance