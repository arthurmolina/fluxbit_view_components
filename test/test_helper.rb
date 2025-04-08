# frozen_string_literal: true

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../demo/config/environment.rb", __dir__)

require "minitest/autorun"
require "rails"
require "rails/test_help"
require "test_helpers/component_test_helper"
require "pry"

def styled(*elements, variable: "styles")
  "." + send(variable).dig(*elements).strip.gsub(":", "\\:").gsub(".", "\\.").gsub("/", "\\/").gsub(" ", ".")
end
