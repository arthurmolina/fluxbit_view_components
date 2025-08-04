import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    delay: { type: Number, default: 150 }
  }

  connect() {
    this.timeout = null;
  }

  submit(event) {
    // Clear any existing timeout
    if (this.timeout) {
      clearTimeout(this.timeout);
    }

    // Set new timeout
    this.timeout = setTimeout(() => {
      if (event.params["formId"]) {
        const form = document.getElementById(event.params["formId"]);
        if (!form) {
          console.error(`fx-auto-submit: Form with ID "${event.params["formId"]}" not found.`);
          return;
        }
        form.requestSubmit();
        return;
      }

      this.element.requestSubmit();
    }, this.delayValue);
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
  }
}