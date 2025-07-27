import { Controller } from "@hotwired/stimulus"
import { visit } from "@hotwired/turbo"

export default class extends Controller {
  static values = { url: String, frame: String }

  initialize() {
    console.log('FxRowClick controller initialized');
  }

  connect() {
    // Ensure we're dealing with a table row
    if (this.element.tagName !== 'TR') {
      console.warn('row-click controller should only be used on <tr> tags')
      return
    }
    this.element.addEventListener("click", this.navigate.bind(this));
  }

  disconnect() {
    this.element.removeEventListener("click", this.navigate.bind(this));
  }

  async navigate(event) {
    if (event.target === event.currentTarget || 
        !event.target.closest('button, a, input, select, textarea')) {
      const { visit } = await import("@hotwired/turbo")
      if (this.frameValue) {
        console.log('Navigating within frame:', this.frameValue, this.urlValue);
        // Navigate within a turbo frame
        Turbo.visit(this.urlValue, { frame: this.frameValue });

      } else {
        console.log('Navigating to:', this.urlValue);
        // Regular navigation
        Turbo.visit(this.urlValue);
      }
    }
  }
}
