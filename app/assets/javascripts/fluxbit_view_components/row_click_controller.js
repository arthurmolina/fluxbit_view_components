import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, frame: String }

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

  navigate(event) {
    if (event.target === event.currentTarget || 
        !event.target.closest('button, a, input, select, textarea')) {
      if (this.frameValue) {
        // Navigate within a turbo frame
        window.Turbo.visit(this.urlValue, { frame: this.frameValue });

      } else {
        // Regular navigation
        window.Turbo.visit(this.urlValue);
      }
    }
  }
}
