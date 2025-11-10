import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["countrySelect"]
  static values = {
    mask: { type: String, default: "(##) #####-####" }
  }

  connect() {
    this.input = this.element.querySelector('input[type="tel"]')
    if (this.input) {
      this.input.addEventListener('input', this.applyMask.bind(this))
      this.input.addEventListener('keydown', this.handleBackspace.bind(this))
    }
  }

  disconnect() {
    if (this.input) {
      this.input.removeEventListener('input', this.applyMask.bind(this))
      this.input.removeEventListener('keydown', this.handleBackspace.bind(this))
    }
  }

  updateMask(event) {
    const selectedOption = event.target.options[event.target.selectedIndex]
    const newMask = selectedOption.dataset.mask

    if (newMask) {
      this.maskValue = newMask
      // Clear the current value and reapply mask
      const currentValue = this.input.value
      this.input.value = ''
      this.input.value = this.getCleanValue(currentValue)
      this.applyMask({ target: this.input })
    }
  }

  handleBackspace(event) {
    if (event.key === 'Backspace' || event.keyCode === 8) {
      const cursorPosition = this.input.selectionStart
      const value = this.input.value

      // Check if the character before cursor is a mask character
      if (cursorPosition > 0) {
        const charBefore = value.charAt(cursorPosition - 1)
        if (this.isMaskCharacter(charBefore)) {
          event.preventDefault()
          // Find the previous digit and remove it
          let newPosition = cursorPosition - 1
          while (newPosition > 0 && this.isMaskCharacter(value.charAt(newPosition))) {
            newPosition--
          }

          if (newPosition >= 0) {
            const cleanValue = this.getCleanValue(value.substring(0, newPosition) + value.substring(cursorPosition))
            this.input.value = cleanValue
            this.applyMask({ target: this.input })
            this.input.setSelectionRange(newPosition, newPosition)
          }
        }
      }
    }
  }

  applyMask(event) {
    const input = event.target
    let value = this.getCleanValue(input.value)
    let maskedValue = ''
    let valueIndex = 0

    for (let i = 0; i < this.maskValue.length && valueIndex < value.length; i++) {
      const maskChar = this.maskValue.charAt(i)

      if (maskChar === '#') {
        maskedValue += value.charAt(valueIndex)
        valueIndex++
      } else {
        maskedValue += maskChar
      }
    }

    input.value = maskedValue
  }

  getCleanValue(value) {
    // Remove all non-numeric characters
    return value.replace(/\D/g, '')
  }

  isMaskCharacter(char) {
    return /[\s\-\(\)\/\.]/.test(char)
  }
}
