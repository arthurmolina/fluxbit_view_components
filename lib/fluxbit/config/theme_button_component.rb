# frozen_string_literal: true

module Fluxbit::Config::ThemeButtonComponent
  # Theme button specific defaults
  mattr_accessor :color, default: :transparent
  mattr_accessor :pill, default: true
  mattr_accessor :size, default: 2
  mattr_accessor :as, default: :button

  # Delegate styles to ButtonComponent (class method)
  def self.styles
    Fluxbit::Config::ButtonComponent.styles
  end

  # Delegate styles to ButtonComponent (instance method for tests)
  def styles
    Fluxbit::Config::ButtonComponent.styles
  end
end
