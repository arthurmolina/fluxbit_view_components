# frozen_string_literal: true

##
# The `Fluxbit::ThemeButtonComponent` is a round button component that toggles between dark, light, and system themes.
# It extends `Fluxbit::ButtonComponent` and automatically updates the theme when clicked.
class Fluxbit::ThemeButtonComponent < Fluxbit::ButtonComponent
  include Fluxbit::Config::ThemeButtonComponent

  ##
  # Initializes the theme button component with the given properties.
  #
  # @param [Hash] props The properties to customize the theme button.
  # @option props [Symbol, String] :color The color style of the button (default: :transparent)
  # @option props [Symbol, String] :size The size of the button (default: 2)
  # @option props [Boolean] :pill (true) Makes the button round
  # @option props [Hash] **props Remaining options declared as HTML attributes.
  #
  # @return [Fluxbit::ThemeButtonComponent]
  def initialize(**props)
    # Set default values specific to theme button
    props[:pill] = true unless props.key?(:pill)
    props[:color] ||= :transparent
    props[:size] ||= 2
    props[:remove_dropdown_arrow] = true

    # Add Stimulus controller
    props["data-controller"] = [props["data-controller"], "fx-theme-button"].compact.join(" ")
    props["data-action"] = [props["data-action"], "click->fx-theme-button#toggle"].compact.join(" ")

    super(**props)
  end

  def call
    concat(render_theme_button)
    concat(render_popover_or_tooltip.to_s)
  end

  private

  def render_theme_button
    button_content = safe_join([
      content_tag(:span, light_icon, class: "fx-theme-icon fx-theme-light hidden", "data-fx-theme-button-target": "lightIcon"),
      content_tag(:span, dark_icon, class: "fx-theme-icon fx-theme-dark hidden", "data-fx-theme-button-target": "darkIcon"),
      content_tag(:span, system_icon, class: "fx-theme-icon fx-theme-system hidden", "data-fx-theme-button-target": "systemIcon")
    ])

    content_tag(@as, button_content, @props)
  end

  def light_icon
    # Sun icon for light mode
    anyicon("heroicons_outline:sun", class: "size-5")
  end

  def dark_icon
    # Moon icon for dark mode
    anyicon("heroicons_outline:moon", class: "size-5")
  end

  def system_icon
    # Computer/display icon for system mode
    anyicon("heroicons_outline:computer-desktop", class: "size-5")
  end
end
