# frozen_string_literal: true

require_relative "lib/fluxbit/view_components/version"

Gem::Specification.new do |spec|
  spec.name = "fluxbit_view_components"
  spec.version = Fluxbit::ViewComponents::VERSION
  spec.authors = [ "Arthur Molina" ]
  spec.email = [ "arthurmolina@gmail.com" ]

  spec.homepage = "https://github.com/baoagency/fluxbit-view-components"
  spec.summary = "ViewComponents for Fluxbit Design System"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = Dir["lib/**/*", "app/**/*", "config/**/*", "LICENSE.txt", "README.md"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_runtime_dependency "anyicon", ">= 1.0.0"
  spec.add_runtime_dependency "rails", ">= 5.0.0"
  spec.add_runtime_dependency "view_component", ">= 3.0.0", "< 4.0.0"

  spec.add_development_dependency "webdrivers", "~> 5.0"
  spec.add_development_dependency "selenium-webdriver", "~> 4.1"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "sprockets-rails"
  spec.add_development_dependency "kamal"
end
