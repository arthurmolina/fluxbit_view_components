import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "eyeIcon",
    "eyeSlashIcon",
    "inputWrapper",
    "strengthIndicator",
    "strengthBar",
    "checkLength",
    "checkLengthPass",
    "checkLengthFail",
    "checkUppercase",
    "checkUppercasePass",
    "checkUppercaseFail",
    "checkLowercase",
    "checkLowercasePass",
    "checkLowercaseFail",
    "checkNumbers",
    "checkNumbersPass",
    "checkNumbersFail",
    "checkSpecial",
    "checkSpecialPass",
    "checkSpecialFail"
  ]

  static values = {
    minLength: { type: Number, default: 8 },
    requireUppercase: { type: Boolean, default: true },
    requireLowercase: { type: Boolean, default: true },
    requireNumbers: { type: Boolean, default: true },
    requireSpecial: { type: Boolean, default: true }
  }

  connect() {
    this.passwordVisible = false
    this.passwordInput = this.element.querySelector('input[type="password"]')

    if (!this.passwordInput) {
      this.passwordInput = this.element.querySelector('input[type="text"]')
    }

    // Store original attributes that might be lost when changing type
    this.maxLength = this.passwordInput.getAttribute('maxlength')
  }

  toggleVisibility(event) {
    event.preventDefault()
    event.stopPropagation()

    this.passwordVisible = !this.passwordVisible

    if (this.passwordVisible) {
      this.passwordInput.type = "text"
      this.showEyeSlash()
    } else {
      this.passwordInput.type = "password"
      this.showEye()
    }

    // Restore maxlength if it was set
    if (this.maxLength) {
      this.passwordInput.setAttribute('maxlength', this.maxLength)
    }
  }

  showEye() {
    if (!this.hasEyeIconTarget || !this.hasEyeSlashIconTarget) return

    this.eyeIconTarget.classList.remove('hidden')
    this.eyeSlashIconTarget.classList.add('hidden')
  }

  showEyeSlash() {
    if (!this.hasEyeIconTarget || !this.hasEyeSlashIconTarget) return

    this.eyeIconTarget.classList.add('hidden')
    this.eyeSlashIconTarget.classList.remove('hidden')
  }

  validate() {
    if (!this.hasStrengthIndicatorTarget) return

    const password = this.passwordInput.value
    const checks = {
      length: password.length >= this.minLengthValue,
      uppercase: this.requireUppercaseValue ? /[A-Z]/.test(password) : true,
      lowercase: this.requireLowercaseValue ? /[a-z]/.test(password) : true,
      numbers: this.requireNumbersValue ? /[0-9]/.test(password) : true,
      special: this.requireSpecialValue ? /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?`~]/.test(password) : true
    }

    // Update check indicators
    this.updateCheck("length", checks.length)
    if (this.requireUppercaseValue) this.updateCheck("uppercase", checks.uppercase)
    if (this.requireLowercaseValue) this.updateCheck("lowercase", checks.lowercase)
    if (this.requireNumbersValue) this.updateCheck("numbers", checks.numbers)
    if (this.requireSpecialValue) this.updateCheck("special", checks.special)

    // Calculate strength
    const totalChecks = Object.values(checks).length
    const passedChecks = Object.values(checks).filter(Boolean).length
    const strengthPercentage = (passedChecks / totalChecks) * 100

    this.updateStrengthBar(strengthPercentage)
  }

  updateCheck(type, passed) {
    const capitalizedType = type.charAt(0).toUpperCase() + type.slice(1)
    const checkTarget = `check${capitalizedType}Target`
    const passTarget = `check${capitalizedType}PassTarget`
    const failTarget = `check${capitalizedType}FailTarget`

    // Check if targets exist
    if (!this[`has${checkTarget.charAt(0).toUpperCase() + checkTarget.slice(1)}`]) return
    if (!this[`has${passTarget.charAt(0).toUpperCase() + passTarget.slice(1)}`]) return
    if (!this[`has${failTarget.charAt(0).toUpperCase() + failTarget.slice(1)}`]) return

    const checkElement = this[checkTarget]
    const passIcon = this[passTarget]
    const failIcon = this[failTarget]
    const iconContainer = checkElement.querySelector('.flex-shrink-0')

    if (passed) {
      // Show check icon, hide X icon
      passIcon.classList.remove('hidden')
      failIcon.classList.add('hidden')

      // Update colors
      iconContainer.classList.remove('text-red-500', 'dark:text-red-400')
      iconContainer.classList.add('text-green-500', 'dark:text-green-400')
      checkElement.classList.remove('text-slate-600', 'dark:text-slate-400')
      checkElement.classList.add('text-green-600', 'dark:text-green-400')
    } else {
      // Show X icon, hide check icon
      passIcon.classList.add('hidden')
      failIcon.classList.remove('hidden')

      // Update colors
      iconContainer.classList.remove('text-green-500', 'dark:text-green-400')
      iconContainer.classList.add('text-red-500', 'dark:text-red-400')
      checkElement.classList.remove('text-green-600', 'dark:text-green-400')
      checkElement.classList.add('text-slate-600', 'dark:text-slate-400')
    }
  }

  updateStrengthBar(percentage) {
    if (!this.hasStrengthBarTarget) return

    this.strengthBarTarget.style.width = `${percentage}%`

    // Update color based on strength
    this.strengthBarTarget.classList.remove(
      'bg-red-500', 'dark:bg-red-400',
      'bg-yellow-500', 'dark:bg-yellow-400',
      'bg-green-500', 'dark:bg-green-400',
      'bg-slate-300', 'dark:bg-slate-600'
    )

    if (percentage === 0) {
      this.strengthBarTarget.classList.add('bg-slate-300', 'dark:bg-slate-600')
    } else if (percentage < 50) {
      this.strengthBarTarget.classList.add('bg-red-500', 'dark:bg-red-400')
    } else if (percentage < 100) {
      this.strengthBarTarget.classList.add('bg-yellow-500', 'dark:bg-yellow-400')
    } else {
      this.strengthBarTarget.classList.add('bg-green-500', 'dark:bg-green-400')
    }
  }
}
