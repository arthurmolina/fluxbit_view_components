import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["lightIcon", "darkIcon", "systemIcon"]
  static values = {
    theme: { type: String, default: "system" }
  }

  connect() {
    // Load saved theme from localStorage or use default
    this.themeValue = this.getSavedTheme() || "system"
    this.applyTheme(this.themeValue)
    this.updateIcon()
  }

  toggle() {
    // Cycle through: light -> dark -> system -> light
    const themes = ["light", "dark", "system"]
    const currentIndex = themes.indexOf(this.themeValue)
    const nextIndex = (currentIndex + 1) % themes.length
    this.themeValue = themes[nextIndex]

    this.applyTheme(this.themeValue)
    this.saveTheme(this.themeValue)
    this.updateIcon()

    // Dispatch custom event for other components to listen to
    this.dispatch("changed", { detail: { theme: this.themeValue } })
  }

  applyTheme(theme) {
    const html = document.documentElement

    if (theme === "system") {
      // Remove explicit theme, use system preference
      localStorage.removeItem("theme")
      if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
        html.classList.add("dark")
      } else {
        html.classList.remove("dark")
      }
    } else if (theme === "dark") {
      localStorage.setItem("theme", "dark")
      html.classList.add("dark")
    } else {
      localStorage.setItem("theme", "light")
      html.classList.remove("dark")
    }
  }

  getSavedTheme() {
    const saved = localStorage.getItem("theme")
    if (saved) return saved

    // If no saved theme, check if dark class is present
    if (document.documentElement.classList.contains("dark")) {
      return "dark"
    }

    return "system"
  }

  saveTheme(theme) {
    if (theme === "system") {
      localStorage.removeItem("theme")
    } else {
      localStorage.setItem("theme", theme)
    }
  }

  updateIcon() {
    // Hide all icons first
    this.lightIconTargets.forEach(icon => icon.classList.add("hidden"))
    this.darkIconTargets.forEach(icon => icon.classList.add("hidden"))
    this.systemIconTargets.forEach(icon => icon.classList.add("hidden"))

    // Show the current theme icon
    if (this.themeValue === "light" && this.hasLightIconTarget) {
      this.lightIconTargets.forEach(icon => icon.classList.remove("hidden"))
    } else if (this.themeValue === "dark" && this.hasDarkIconTarget) {
      this.darkIconTargets.forEach(icon => icon.classList.remove("hidden"))
    } else if (this.themeValue === "system" && this.hasSystemIconTarget) {
      this.systemIconTargets.forEach(icon => icon.classList.remove("hidden"))
    }
  }

  themeValueChanged() {
    this.updateIcon()
  }
}
