---
label: FxProgress
title: FxProgress Controller
---

The FxProgress controller provides comprehensive progress bar functionality with support for animations, multiple progress bars, and vanilla JavaScript access.

## Basic Usage

### HTML Structure

```erb
<div data-controller="fx-progress"
     data-fx-progress-progress-value="25"
     data-fx-progress-animate-value="true"
     data-fx-progress-speed-value="normal">

  <!-- Progress bar -->
  <div class="w-full bg-gray-200 rounded-full h-2.5"
       data-fx-progress-target="container"
       data-progress-id="main">
    <div class="bg-blue-600 h-2.5 rounded-full"
         data-fx-progress-target="bar"
         style="width: 25%"></div>
  </div>

  <!-- Labels -->
  <div class="flex justify-between mt-2">
    <span data-fx-progress-target="textLabel">Loading</span>
    <span data-fx-progress-target="progressLabel">25%</span>
  </div>

  <!-- Control buttons -->
  <button data-action="click->fx-progress#increment"
          data-fx-progress-amount-param="10">+10%</button>
  <button data-action="click->fx-progress#reset">Reset</button>
  <button data-action="click->fx-progress#complete">Complete</button>
</div>
```

## Targets

| Target | Description |
|--------|-------------|
| `bar` | The progress bar element that displays the visual progress |
| `textLabel` | Optional text label (e.g., "Loading", "Upload") |
| `progressLabel` | Optional progress percentage label (e.g., "25%") |
| `container` | Optional container element for the progress bar |

## Values

| Value | Type | Default | Description |
|-------|------|---------|-------------|
| `progress` | Number | 0 | Current progress percentage (0-100) |
| `animate` | Boolean | true | Whether to animate progress changes |
| `speed` | String | "normal" | Animation speed: "slow", "normal", "fast", "very_fast" |

## Actions

### Basic Progress Control

| Action | Parameters | Description |
|--------|------------|-------------|
| `increment` | `amount` | Increase progress by specified amount |
| `decrement` | `amount` | Decrease progress by specified amount |
| `resetProgress` | - | Reset progress to 0% |
| `completeProgress` | - | Set progress to 100% |

### Animation Control

| Action | Parameters | Description |
|--------|------------|-------------|
| `animateTo` | `target`, `duration` | Animate to target progress over duration |
| `updateSpeed` | `speed` | Change animation speed |

### Demo Actions

| Action | Parameters | Description |
|--------|------------|-------------|
| `simulateLoading` | `duration`, `target` | Simulate loading progress |
| `demoAdvanced` | - | Run sequential demo animation |
| `simulateFileUpload` | - | Simulate file upload progress |
| `updateSystemMetrics` | - | Update all progress bars with random values |

## Multiple Progress Bars

Use `data-progress-id` to target specific progress bars within the same controller scope:

```erb
<div data-controller="fx-progress">
  <!-- First progress bar -->
  <div data-progress-id="upload" class="...">
    <div data-fx-progress-target="bar" style="width: 30%"></div>
  </div>

  <!-- Second progress bar -->
  <div data-progress-id="download" class="...">
    <div style="width: 70%"></div>
  </div>

  <!-- Buttons can target specific progress bars -->
  <button data-action="click->fx-progress#increment"
          data-fx-progress-amount-param="10"
          data-fx-progress-id-param="upload">+10% Upload</button>

  <button data-action="click->fx-progress#increment"
          data-fx-progress-amount-param="20"
          data-fx-progress-id-param="download">+20% Download</button>
</div>
```

## Vanilla JavaScript Access

The FxProgress controller provides static methods for vanilla JavaScript access:

### Static Methods

```javascript
// Basic progress control
FluxbitControllers.FxProgress.updateProgress(selector, progress);
FluxbitControllers.FxProgress.incrementProgress(selector, amount);
FluxbitControllers.FxProgress.resetProgress(selector);
FluxbitControllers.FxProgress.completeProgress(selector);

// Animation
FluxbitControllers.FxProgress.animateProgress(selector, target, duration);

// Target specific progress bars by ID
FluxbitControllers.FxProgress.updateProgressById(selector, progressId, callback);
```

### Examples

```javascript
// Set main progress to 50%
FluxbitControllers.FxProgress.updateProgress('[data-controller="fx-progress"]', 50);

// Animate to 100% over 2 seconds
FluxbitControllers.FxProgress.animateProgress('[data-controller="fx-progress"]', 100, 2000);

// Target specific progress bar
FluxbitControllers.FxProgress.updateProgressById('[data-controller="fx-progress"]', 'upload', (controller) => {
  controller.incrementProgress(25);
  controller.setSpeed('fast');
});

// Get controller instance directly
const controller = FluxbitControllers.FxProgress.getController('[data-controller="fx-progress"]');
controller.setProgress(75);
controller.animateToProgress(100, 1500);
```

### Real-time Updates

```javascript
// Example: Real-time progress updates
function updateProgress() {
  let progress = 0;
  const interval = setInterval(() => {
    progress += Math.random() * 10;

    if (progress >= 100) {
      FluxbitControllers.FxProgress.completeProgress('[data-controller="fx-progress"]');
      clearInterval(interval);
    } else {
      FluxbitControllers.FxProgress.updateProgress('[data-controller="fx-progress"]', progress);
    }
  }, 200);
}
```

## Direct Controller Access

For advanced use cases, you can access the controller instance directly:

```javascript
// Traditional Stimulus approach
const element = document.querySelector('[data-controller="fx-progress"]');
const controller = application.getControllerForElementAndIdentifier(element, 'fx-progress');

// Call controller methods
controller.setProgress(60);
controller.incrementProgress(20);
controller.animateToProgress(90, 1500);
controller.setSpeed('fast');
controller.reset();
controller.complete();
```

## Instance Methods

When you have a controller instance, these methods are available:

| Method | Parameters | Description |
|--------|------------|-------------|
| `setProgress(progress)` | `progress` (0-100) | Set progress to specific value |
| `incrementProgress(amount)` | `amount` (default: 1) | Increase progress |
| `decrementProgress(amount)` | `amount` (default: 1) | Decrease progress |
| `reset()` | - | Reset to 0% |
| `complete()` | - | Set to 100% |
| `animateToProgress(target, duration)` | `target`, `duration` (ms) | Animate to target |
| `setSpeed(speed)` | `speed` | Set animation speed |
| `setAnimate(animate)` | `animate` (boolean) | Enable/disable animations |

## Events and Callbacks

The controller automatically updates:
- Progress bar width via CSS `style.width`
- ARIA attributes for accessibility
- Progress labels if targets are present

## CSS Classes and Styling

The controller works with any CSS framework. Common patterns:

```css
/* Tailwind CSS example */
.progress-container {
  @apply w-full bg-gray-200 rounded-full h-2.5;
}

.progress-bar {
  @apply bg-blue-600 h-2.5 rounded-full transition-all duration-300 ease-out;
}

/* Bootstrap example */
.progress {
  height: 1rem;
}

.progress-bar {
  transition: width 0.6s ease-out;
}
```

## Accessibility

The controller automatically maintains ARIA attributes:

- `aria-valuenow`: Current progress value
- `aria-valuemin`: Always set to 0
- `aria-valuemax`: Always set to 100

## Best Practices

1. **Use data-progress-id** for multiple progress bars in the same scope
2. **Provide text labels** for better user experience
3. **Set appropriate animation speeds** based on context
4. **Use static methods** for vanilla JavaScript integration
5. **Test with screen readers** to ensure accessibility
6. **Provide fallback styling** for when JavaScript is disabled

## Common Use Cases

- File upload progress
- Form submission progress
- System resource monitoring
- Loading indicators
- Multi-step processes
- Real-time data visualization

## Troubleshooting

**Progress not updating**: Ensure the `bar` target exists and has proper styling
**Animations not working**: Check the `animate` value and CSS transitions
**Multiple bars conflicting**: Use unique `data-progress-id` values
**Vanilla JS not working**: Verify `FluxbitControllers` is available after page load