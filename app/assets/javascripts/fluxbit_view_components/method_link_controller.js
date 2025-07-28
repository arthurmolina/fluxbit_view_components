import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    method: String,
    url: String,
    confirm: String,
    params: Object
  }

  connect() {
    // Ensure we're dealing with an anchor tag
    if (this.element.tagName !== 'A') {
      console.warn('method-link controller should only be used on <a> tags')
      return
    }
    this.element.addEventListener("click", this.click.bind(this));
  }

  disconnect() {
    this.element.removeEventListener("click", this.click.bind(this));
  }

  click(event) {
    event.preventDefault()
    event.stopPropagation()

    // Show confirmation dialog if specified
    if (this.hasConfirmValue && !confirm(this.confirmValue)) {
      return
    }

    this.submitRequest()
  }

  submitRequest() {
    const url = this.hasUrlValue ? this.urlValue : this.element.href
    const method = this.methodValue.toLowerCase()
    
    // Create form data
    const formData = new FormData()
    formData.append('_method', method.toUpperCase())
    formData.append('authenticity_token', this.getCSRFToken())

    // Add any additional parameters
    if (this.hasParamsValue) {
      Object.entries(this.paramsValue).forEach(([key, value]) => {
        if (typeof value === 'object') {
          Object.entries(value).forEach(([subKey, subValue]) => {
            formData.append(`${key}[${subKey}]`, subValue)
          })
        } else {
          formData.append(key, value)
        }
      })
    }

    // Submit the request
    fetch(url, {
      method: 'POST',
      body: formData,
      headers: {
        'Accept': 'text/vnd.turbo-stream.html, text/html',
        'X-Requested-With': 'XMLHttpRequest'
      }
    }).then(response => {
      if (response.ok) {
        // Handle successful response
        if (response.headers.get('Content-Type')?.includes('turbo-stream')) {
          return response.text().then(html => {
            Turbo.renderStreamMessage(html)
          })
        } else {
          // For regular HTML responses, you might want to redirect or reload
          window.location.reload()
        }
      } else {
        console.error('Request failed:', response.statusText)
      }
    }).catch(error => {
      console.error('Network error:', error)
    })
  }

  getCSRFToken() {
    const token = document.querySelector('meta[name="csrf-token"]')
    return token ? token.getAttribute('content') : ''
  }
}
