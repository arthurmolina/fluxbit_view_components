import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bar", "textLabel", "progressLabel"];
  static values = {
    progress: {
      type: Number,
      default: 0
    },
    animate: {
      type: Boolean,
      default: true
    },
    speed: {
      type: String,
      default: "normal"
    }
  };

  connect() {
    this.updateProgress();
    this.updateBarTransition();
  }

  progressValueChanged() {
    this.updateProgress();
  }

  animateValueChanged() {
    this.updateBarTransition();
  }

  speedValueChanged() {
    this.updateBarTransition();
  }

  updateProgress() {
    const clampedProgress = Math.max(0, Math.min(100, this.progressValue));

    if (this.hasBarTarget) {
      this.barTarget.style.width = `${clampedProgress}%`;
      this.barTarget.setAttribute('aria-valuenow', clampedProgress);
    }

    if (this.hasProgressLabelTarget) {
      this.progressLabelTarget.textContent = `${clampedProgress}%`;
    }

    this.element.setAttribute('aria-valuenow', clampedProgress);
  }

  updateBarTransition() {
    if (!this.hasBarTarget) return;

    if (this.animateValue) {
      let duration;
      switch (this.speedValue) {
        case 'slow':
          duration = '2s';
          break;
        case 'fast':
          duration = '0.3s';
          break;
        case 'very_fast':
          duration = '0.1s';
          break;
        case 'normal':
        default:
          duration = '0.6s';
          break;
      }

      this.barTarget.style.transition = `width ${duration} ease-out`;
    } else {
      this.barTarget.style.transition = 'none';
    }
  }

  // Core progress methods
  setProgress(progress) {
    this.progressValue = progress;
  }

  incrementProgress(amount = 1) {
    this.progressValue = Math.min(100, this.progressValue + amount);
  }

  decrementProgress(amount = 1) {
    this.progressValue = Math.max(0, this.progressValue - amount);
  }

  reset() {
    this.progressValue = 0;
  }

  complete() {
    this.progressValue = 100;
  }

  setSpeed(speed) {
    this.speedValue = speed;
  }

  setAnimate(animate) {
    this.animateValue = animate;
  }

  // Animation method
  animateToProgress(targetProgress, duration = 1000) {
    const startProgress = this.progressValue;
    const difference = targetProgress - startProgress;
    const startTime = performance.now();

    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
    }

    const animate = (currentTime) => {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);
      const easeOut = 1 - Math.pow(1 - progress, 3);
      const currentProgress = startProgress + (difference * easeOut);

      this.updateProgressDirect(Math.round(currentProgress));

      if (progress < 1) {
        this.animationId = requestAnimationFrame(animate);
      } else {
        this.progressValue = targetProgress;
        this.animationId = null;
      }
    };

    this.animationId = requestAnimationFrame(animate);
  }

  updateProgressDirect(progress) {
    const clampedProgress = Math.max(0, Math.min(100, progress));

    if (this.hasBarTarget) {
      this.barTarget.style.width = `${clampedProgress}%`;
      this.barTarget.setAttribute('aria-valuenow', clampedProgress);
    }

    if (this.hasProgressLabelTarget) {
      this.progressLabelTarget.textContent = `${clampedProgress}%`;
    }

    this.element.setAttribute('aria-valuenow', clampedProgress);
  }

  // Action methods (for Stimulus data-action bindings)
  increment(event) {
    const amount = parseInt(event.params?.amount) || 1;
    const progressId = event.params?.id;

    if (progressId) {
      this.updateProgressById(progressId, (controller) => controller.incrementProgress(amount));
    } else {
      this.incrementProgress(amount);
    }
  }

  decrement(event) {
    const amount = parseInt(event.params?.amount) || 1;
    const progressId = event.params?.id;

    if (progressId) {
      this.updateProgressById(progressId, (controller) => controller.decrementProgress(amount));
    } else {
      this.decrementProgress(amount);
    }
  }

  resetProgress(event) {
    const progressId = event.params?.id;

    if (progressId) {
      this.updateProgressById(progressId, (controller) => controller.reset());
    } else {
      this.reset();
    }
  }

  completeProgress(event) {
    const progressId = event.params?.id;

    if (progressId) {
      this.updateProgressById(progressId, (controller) => controller.complete());
    } else {
      this.complete();
    }
  }

  animateTo(event) {
    const target = parseInt(event.params?.target) || 100;
    const duration = parseInt(event.params?.duration) || 1000;
    const progressId = event.params?.id;

    if (progressId) {
      this.updateProgressById(progressId, (controller) => controller.animateToProgress(target, duration));
    } else {
      this.animateToProgress(target, duration);
    }
  }

  updateSpeed(event) {
    const speed = event.params?.speed || 'normal';
    const progressId = event.params?.id;

    if (progressId) {
      this.updateProgressById(progressId, (controller) => controller.setSpeed(speed));
    } else {
      this.setSpeed(speed);
    }
  }

  // Helper method to target specific progress bars by ID
  updateProgressById(progressId, callback) {
    const progressContainer = this.element.querySelector(`[data-progress-id="${progressId}"]`);
    if (!progressContainer) return;

    // Get the progress bar and labels within the specific progress container
    const progressBar = progressContainer.querySelector('div[style*="width"]');
    const textLabel = progressContainer.parentElement.querySelector('span:first-child');
    const progressLabel = progressContainer.parentElement.querySelector('span:last-child');

    if (!progressBar) return;

    // Create a temporary controller-like object to operate on this specific progress bar
    const tempController = {
      barElement: progressBar,
      textLabelElement: textLabel,
      progressLabelElement: progressLabel,
      containerElement: progressContainer,

      setProgress: (progress) => {
        const clampedProgress = Math.max(0, Math.min(100, progress));
        this.updateSpecificProgress(progressBar, progressLabel, clampedProgress);
      },

      incrementProgress: (amount = 1) => {
        const currentProgress = this.getCurrentProgress(progressBar);
        const newProgress = Math.min(100, currentProgress + amount);
        this.updateSpecificProgress(progressBar, progressLabel, newProgress);
      },

      decrementProgress: (amount = 1) => {
        const currentProgress = this.getCurrentProgress(progressBar);
        const newProgress = Math.max(0, currentProgress - amount);
        this.updateSpecificProgress(progressBar, progressLabel, newProgress);
      },

      reset: () => {
        this.updateSpecificProgress(progressBar, progressLabel, 0);
      },

      complete: () => {
        this.updateSpecificProgress(progressBar, progressLabel, 100);
      },

      animateToProgress: (targetProgress, duration = 1000) => {
        const currentProgress = this.getCurrentProgress(progressBar);
        this.animateSpecificProgress(progressBar, progressLabel, currentProgress, targetProgress, duration);
      },

      setSpeed: (speed) => {
        // Update transition speed for this specific progress bar
        let duration;
        switch (speed) {
          case 'slow': duration = '2s'; break;
          case 'fast': duration = '0.3s'; break;
          case 'very_fast': duration = '0.1s'; break;
          default: duration = '0.6s'; break;
        }
        progressBar.style.transition = `width ${duration} ease-out`;
      }
    };

    if (callback) {
      callback(tempController);
    }
  }

  // Helper methods for specific progress bar operations
  getCurrentProgress(progressBar) {
    const widthStyle = progressBar.style.width;
    return parseInt(widthStyle.replace('%', '')) || 0;
  }

  updateSpecificProgress(progressBar, progressLabel, progress) {
    const clampedProgress = Math.max(0, Math.min(100, progress));

    progressBar.style.width = `${clampedProgress}%`;
    progressBar.setAttribute('aria-valuenow', clampedProgress);

    if (progressLabel) {
      progressLabel.textContent = `${clampedProgress}%`;
    }
  }

  animateSpecificProgress(progressBar, progressLabel, startProgress, targetProgress, duration) {
    const difference = targetProgress - startProgress;
    const startTime = performance.now();

    const animate = (currentTime) => {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);
      const easeOut = 1 - Math.pow(1 - progress, 3);
      const currentProgress = startProgress + (difference * easeOut);

      this.updateSpecificProgress(progressBar, progressLabel, Math.round(currentProgress));

      if (progress < 1) {
        requestAnimationFrame(animate);
      } else {
        this.updateSpecificProgress(progressBar, progressLabel, targetProgress);
      }
    };

    requestAnimationFrame(animate);
  }

  disconnect() {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
      this.animationId = null;
    }
  }

  // Global access methods for vanilla JavaScript
  static getController(element) {
    if (typeof element === 'string') {
      element = document.querySelector(element);
    }
    if (!element) return null;

    const controllerElement = element.closest('[data-controller*="fx-progress"]');
    if (!controllerElement) return null;

    return window.Stimulus?.getControllerForElementAndIdentifier(controllerElement, 'fx-progress') ||
           application?.getControllerForElementAndIdentifier(controllerElement, 'fx-progress');
  }

  static updateProgress(selector, progress) {
    const controller = this.getController(selector);
    if (controller) controller.setProgress(progress);
  }

  static incrementProgress(selector, amount = 10) {
    const controller = this.getController(selector);
    if (controller) controller.incrementProgress(amount);
  }

  static animateProgress(selector, target, duration = 1000) {
    const controller = this.getController(selector);
    if (controller) controller.animateToProgress(target, duration);
  }

  static resetProgress(selector) {
    const controller = this.getController(selector);
    if (controller) controller.reset();
  }

  static completeProgress(selector) {
    const controller = this.getController(selector);
    if (controller) controller.complete();
  }

  static updateProgressById(selector, progressId, callback) {
    const controller = this.getController(selector);
    if (controller) controller.updateProgressById(progressId, callback);
  }
}