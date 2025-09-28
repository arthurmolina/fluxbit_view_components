import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["progress", "text"];
  static values = {
    percent: {
      type: Number,
      default: 0
    },
    animate: {
      type: Boolean,
      default: false
    },
    speed: {
      type: String,
      default: "normal"
    },
    hasCustomText: {
      type: Boolean,
      default: false
    }
  };

  connect() {
    this.circumference = 2 * Math.PI * 45; // radius of 45
    this.updateProgress();
    this.updateAnimation();
  }

  percentValueChanged() {
    this.updateProgress();
  }

  animateValueChanged() {
    this.updateAnimation();
  }

  speedValueChanged() {
    this.updateAnimation();
  }

  updateProgress() {
    const clampedPercent = Math.max(0, Math.min(100, this.percentValue));
    const offset = this.circumference - (clampedPercent / 100) * this.circumference;

    if (this.hasProgressTarget) {
      this.progressTarget.style.strokeDashoffset = offset;
      this.progressTarget.setAttribute('aria-valuenow', clampedPercent);
    }

    if (this.hasTextTarget && !this.hasCustomTextValue) {
      this.textTarget.textContent = `${clampedPercent}%`;
    }

    // Update the component's aria attributes
    this.element.setAttribute('aria-valuenow', clampedPercent);
  }

  updateAnimation() {
    const svg = this.element.querySelector('svg');
    if (!svg) return;

    if (this.animateValue) {
      // Set animation duration directly via CSS custom property
      let duration;
      switch (this.speedValue) {
        case 'slow':
          duration = '3s';
          break;
        case 'fast':
          duration = '0.5s';
          break;
        case 'very_fast':
          duration = '0.3s';
          break;
        case 'normal':
        default:
          duration = '1s';
          break;
      }

      // Apply the animation with custom duration
      svg.style.animation = `spin ${duration} linear infinite`;
    } else {
      // Remove animation
      svg.style.animation = '';
    }
  }

  // Public method to update percentage programmatically
  setPercent(percent) {
    this.percentValue = percent;
  }

  // Public method to toggle animation
  setAnimate(animate) {
    this.animateValue = animate;
  }

  // Public method to start animation
  startAnimation() {
    this.animateValue = true;
  }

  // Public method to stop animation
  stopAnimation() {
    this.animateValue = false;
  }

  // Public method to set animation speed
  setSpeed(speed) {
    this.speedValue = speed;
  }

  // Public method to animate to a new percentage
  animateToPercent(targetPercent, duration = 1000) {
    const startPercent = this.percentValue;
    const difference = targetPercent - startPercent;
    const startTime = performance.now();

    // Cancel any existing animation
    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
    }

    const animate = (currentTime) => {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);

      // Easing function (ease-out)
      const easeOut = 1 - Math.pow(1 - progress, 3);
      const currentPercent = startPercent + (difference * easeOut);

      // Update directly without triggering Stimulus value change
      this.updateProgressDirect(Math.round(currentPercent));

      if (progress < 1) {
        this.animationId = requestAnimationFrame(animate);
      } else {
        // Set final value through Stimulus to maintain sync
        this.percentValue = targetPercent;
        this.animationId = null;
      }
    };

    this.animationId = requestAnimationFrame(animate);
  }

  // Direct update method that doesn't trigger Stimulus value change
  updateProgressDirect(percent) {
    const clampedPercent = Math.max(0, Math.min(100, percent));
    const offset = this.circumference - (clampedPercent / 100) * this.circumference;

    if (this.hasProgressTarget) {
      this.progressTarget.style.strokeDashoffset = offset;
      this.progressTarget.setAttribute('aria-valuenow', clampedPercent);
    }

    if (this.hasTextTarget && !this.hasCustomTextValue) {
      this.textTarget.textContent = `${clampedPercent}%`;
    }

    // Update the component's aria attributes
    this.element.setAttribute('aria-valuenow', clampedPercent);
  }

  disconnect() {
    // Clean up animation when controller is disconnected
    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
      this.animationId = null;
    }
  }
}