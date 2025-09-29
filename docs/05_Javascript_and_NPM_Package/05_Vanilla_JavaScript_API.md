---
label: Vanilla JavaScript API
title: Vanilla JavaScript API
---

# Vanilla JavaScript API

Fluxbit ViewComponents provides a comprehensive vanilla JavaScript API that allows you to interact with Stimulus controllers without requiring Stimulus knowledge or setup.

## Global Access

All controllers are accessible through the global `FluxbitControllers` object after page load:

```javascript
// Global object available after initialization
window.FluxbitControllers = {
  FxProgress,
  FxModal,
  FxDrawer,
  FxAssigner,
  FxAutoSubmit,
  FxMethodLink,
  FxRowClick,
  FxSelectAll,
  FxSpinnerPercent
}
```

## Usage Patterns

### 1. Static Helper Methods (Recommended)

Most controllers provide static methods for common operations:

```javascript
// Progress control - simple and direct
FluxbitControllers.FxProgress.updateProgress('[data-controller="fx-progress"]', 75);
FluxbitControllers.FxProgress.animateProgress('[data-controller="fx-progress"]', 100, 2000);
FluxbitControllers.FxProgress.resetProgress('[data-controller="fx-progress"]');

// Modal control
FluxbitControllers.FxModal.show('[data-controller="fx-modal"]');
FluxbitControllers.FxModal.hide('[data-controller="fx-modal"]');
```

### 2. Controller Instance Access

For complex operations, get the controller instance directly:

```javascript
// Get controller instance
const controller = FluxbitControllers.FxProgress.getController('[data-controller="fx-progress"]');

// Call instance methods
if (controller) {
  controller.setProgress(50);
  controller.setSpeed('fast');
  controller.animateToProgress(100, 1500);
}
```

### 3. Traditional Stimulus Access

You can still use the traditional Stimulus approach:

```javascript
// Standard Stimulus method
const element = document.querySelector('[data-controller="fx-progress"]');
const controller = application.getControllerForElementAndIdentifier(element, 'fx-progress');

if (controller) {
  controller.setProgress(75);
}
```

## Controller-Specific APIs

### FxProgress

Complete progress bar control with multi-bar support:

```javascript
// Basic operations
FluxbitControllers.FxProgress.updateProgress(selector, progress);
FluxbitControllers.FxProgress.incrementProgress(selector, amount);
FluxbitControllers.FxProgress.resetProgress(selector);
FluxbitControllers.FxProgress.completeProgress(selector);

// Animation
FluxbitControllers.FxProgress.animateProgress(selector, target, duration);

// Multi-bar targeting
FluxbitControllers.FxProgress.updateProgressById(selector, 'upload', (controller) => {
  controller.incrementProgress(25);
  controller.setSpeed('fast');
});

// Real-time updates
function updateUploadProgress(percentage) {
  FluxbitControllers.FxProgress.updateProgressById('[data-controller="fx-progress"]', 'upload', (controller) => {
    controller.setProgress(percentage);
    if (percentage >= 100) {
      controller.complete();
    }
  });
}
```

### FxModal

Modal dialog control:

```javascript
// Basic modal operations
FluxbitControllers.FxModal.show('[data-controller="fx-modal"]');
FluxbitControllers.FxModal.hide('[data-controller="fx-modal"]');
FluxbitControllers.FxModal.toggle('[data-controller="fx-modal"]');

// Instance access for advanced control
const modal = FluxbitControllers.FxModal.getController('#my-modal');
if (modal) {
  modal.show();
  modal.updateOptions({ backdrop: false });
}
```

## Real-World Examples

### File Upload with Progress

```javascript
function uploadFile(file) {
  const formData = new FormData();
  formData.append('file', file);

  // Reset progress
  FluxbitControllers.FxProgress.resetProgress('[data-controller="fx-progress"]');

  // Create XMLHttpRequest with progress tracking
  const xhr = new XMLHttpRequest();

  xhr.upload.addEventListener('progress', (event) => {
    if (event.lengthComputable) {
      const percentage = Math.round((event.loaded / event.total) * 100);
      FluxbitControllers.FxProgress.updateProgress('[data-controller="fx-progress"]', percentage);
    }
  });

  xhr.onload = function() {
    if (xhr.status === 200) {
      FluxbitControllers.FxProgress.completeProgress('[data-controller="fx-progress"]');
      // Show success modal
      FluxbitControllers.FxModal.show('#success-modal');
    }
  };

  xhr.open('POST', '/upload');
  xhr.send(formData);
}
```

### Multi-Step Form Progress

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

  previousStep() {
    if (this.currentStep > 1) {
      this.currentStep--;
      this.updateProgress();
    }
  }

  updateProgress() {
    const percentage = (this.currentStep / this.totalSteps) * 100;
    FluxbitControllers.FxProgress.animateProgress('[data-controller="fx-progress"]', percentage, 500);
  }

  complete() {
    FluxbitControllers.FxProgress.completeProgress('[data-controller="fx-progress"]');
    FluxbitControllers.FxModal.show('#completion-modal');
  }
}

// Usage
const form = new MultiStepForm();
document.getElementById('next-btn').onclick = () => form.nextStep();
document.getElementById('prev-btn').onclick = () => form.previousStep();
```

### System Resource Monitor

```javascript
class SystemMonitor {
  constructor() {
    this.startMonitoring();
  }

  startMonitoring() {
    setInterval(() => {
      this.fetchSystemStats();
    }, 1000);
  }

  async fetchSystemStats() {
    try {
      const response = await fetch('/api/system-stats');
      const stats = await response.json();

      // Update multiple progress bars
      FluxbitControllers.FxProgress.updateProgressById('[data-controller="fx-progress"]', 'cpu', (controller) => {
        controller.animateToProgress(stats.cpu, 500);
      });

      FluxbitControllers.FxProgress.updateProgressById('[data-controller="fx-progress"]', 'memory', (controller) => {
        controller.animateToProgress(stats.memory, 500);
      });

      FluxbitControllers.FxProgress.updateProgressById('[data-controller="fx-progress"]', 'disk', (controller) => {
        controller.animateToProgress(stats.disk, 500);
      });

    } catch (error) {
      console.error('Failed to fetch system stats:', error);
    }
  }
}

// Start monitoring when page loads
document.addEventListener('DOMContentLoaded', () => {
  new SystemMonitor();
});
```

## Error Handling

Always check for controller availability:

```javascript
// Safe controller access
function safeProgressUpdate(selector, progress) {
  if (typeof FluxbitControllers === 'undefined') {
    console.warn('FluxbitControllers not available');
    return;
  }

  const controller = FluxbitControllers.FxProgress.getController(selector);
  if (!controller) {
    console.warn('Progress controller not found for selector:', selector);
    return;
  }

  controller.setProgress(progress);
}

// Use with error handling
try {
  FluxbitControllers.FxProgress.updateProgress('[data-controller="fx-progress"]', 50);
} catch (error) {
  console.error('Failed to update progress:', error);
}
```

## Best Practices

1. **Check Availability**: Always verify `FluxbitControllers` exists before use
2. **Use Static Methods**: Prefer static methods for simple operations
3. **Instance Access**: Use direct instance access for complex scenarios
4. **Error Handling**: Wrap calls in try-catch blocks for production code
5. **Selector Strategy**: Use consistent CSS selectors or data attributes
6. **Performance**: Cache controller instances for repeated operations

## Integration with Popular Libraries

### jQuery Integration

```javascript
// jQuery plugin for progress control
$.fn.fluxProgress = function(action, ...args) {
  return this.each(function() {
    const selector = `#${this.id}`;
    switch(action) {
      case 'set':
        FluxbitControllers.FxProgress.updateProgress(selector, args[0]);
        break;
      case 'animate':
        FluxbitControllers.FxProgress.animateProgress(selector, args[0], args[1]);
        break;
      case 'reset':
        FluxbitControllers.FxProgress.resetProgress(selector);
        break;
    }
  });
};

// Usage
$('#my-progress').fluxProgress('set', 75);
$('#my-progress').fluxProgress('animate', 100, 2000);
```

### Axios Integration

```javascript
// Axios interceptor for upload progress
axios.interceptors.request.use((config) => {
  if (config.onUploadProgress) {
    const originalOnUploadProgress = config.onUploadProgress;
    config.onUploadProgress = (progressEvent) => {
      // Update Fluxbit progress bar
      const percentage = Math.round((progressEvent.loaded / progressEvent.total) * 100);
      FluxbitControllers.FxProgress.updateProgress('[data-controller="fx-progress"]', percentage);

      // Call original handler
      if (originalOnUploadProgress) {
        originalOnUploadProgress(progressEvent);
      }
    };
  }
  return config;
});
```

## Debugging

Use browser console to inspect and control components:

```javascript
// Debug helpers (available in console)
window.debugFluxbit = {
  // List all progress controllers
  listProgressControllers() {
    document.querySelectorAll('[data-controller*="fx-progress"]').forEach((el, i) => {
      console.log(`Progress ${i}:`, el);
    });
  },

  // Test progress bar
  testProgress(selector = '[data-controller="fx-progress"]') {
    FluxbitControllers.FxProgress.resetProgress(selector);
    setTimeout(() => FluxbitControllers.FxProgress.animateProgress(selector, 100, 2000), 500);
  },

  // Get all controllers
  getControllers() {
    return FluxbitControllers;
  }
};
```

The vanilla JavaScript API provides powerful, flexible access to all Fluxbit functionality without requiring deep Stimulus knowledge, making integration with existing codebases seamless and straightforward.