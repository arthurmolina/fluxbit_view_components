import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    method: "get",
    url: String,
    params: Object,
    formDataId: String,
    debug: false,
    eventType: "click"
  }

  connect() {
    this.element.addEventListener(this.eventTypeValue, this.click.bind(this));
  }

  disconnect() {
    this.element.removeEventListener(this.eventTypeValue, this.click.bind(this));
  }

  click(event) {
    event.preventDefault()
    event.stopPropagation()

    const formData = this.createFormData();

    // Add any additional parameters
    if (this.hasParamsValue) this.addParams(formData)

    // Submit the request
    const url = this.hasUrlValue ? this.urlValue : this.element.href
    this.submitRequest(url, formData)
  }

  createFormData() {
    const formData = new FormData()

    if (this.hasFormDataIdValue) {
      // Try to use existing form data
      const existingForm = document.getElementById(this.formDataIdValue)
      const formElements = existingForm.querySelectorAll("input, select, textarea")
      
      formElements.forEach(element => {
        if (element.name && (element.type !== "checkbox" || element.checked))
          formData.append(element.name, element.value)
      })
    }

    formData.append("_method", (this.methodValue || formData.method).toUpperCase())
    formData.append("authenticity_token", this.getCSRFToken())
    return formData
  }

  addParams(formData) {
    this.appendNestedParams(formData, this.paramsValue, "")
  }

  appendNestedParams(formData, obj, prefix) {
    Object.entries(obj).forEach(([key, value]) => {
      const fullKey = prefix ? `${prefix}[${key}]` : key
      
      if (typeof value === "object" && value !== null) {
        // Check if it's an element reference object
        if (this.isElementReference(value)) {
          const resolvedValue = this.resolveElementValue(value)
          formData.append(fullKey, resolvedValue)
        } else {
          // Recursively handle nested objects
          this.appendNestedParams(formData, value, fullKey)
        }
      } else {
        // Primitive value
        formData.append(fullKey, value)
      }
    })
  }

  isElementReference(obj) {
    return obj.hasOwnProperty("element") && obj.hasOwnProperty("attribute")
  }

  resolveElementValue(elementRef) {
    const { element, attribute } = elementRef
    const domElement = document.querySelector(element)
    
    if (!domElement) {
      console.error(`fx-method-link: Element "${element}" not found.`)
      return ""
    }

    switch (attribute) {
      case "innerHTML":
        return domElement.innerHTML
      case "value":
        return domElement.value
      case "textContent":
        return domElement.textContent
      default:
        return domElement.getAttribute(attribute) || ""
    }
  }

  submitRequest(url, formData) {
    // Debug: Log form data contents
    if (this.debugValue) {
      console.log("Submitting form data:")
      for (let [key, value] of formData.entries()) {
        console.log(`${key}: ${value}`)
      }
    }

    // Submit the request
    fetch(url, {
      method: "POST",
      body: formData,
      headers: {
        "Accept": "text/vnd.turbo-stream.html, text/html",
        "X-Requested-With": "XMLHttpRequest"
      }
    }).then(response => {
      if (response.ok) {
        // Handle successful response
        if (response.headers.get("Content-Type")?.includes("turbo-stream")) {
          return response.text().then(html => {
            Turbo.renderStreamMessage(html)
          })
        } else {
          // For regular HTML responses, you might want to redirect or reload
          window.location.reload()
        }
      } else {
        console.error("Request failed:", response.statusText)
      }
    }).catch(error => {
      console.error("Network error:", error)
    })
  }

  getCSRFToken() {
    const token = document.querySelector('meta[name="csrf-token"]')
    return token ? token.getAttribute("content") : ""
  }
}
