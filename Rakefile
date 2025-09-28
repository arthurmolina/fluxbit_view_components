# frozen_string_literal: true

require "bundler/setup"

APP_RAKEFILE = File.expand_path("demo/Rakefile", __dir__)
load "rails/tasks/engine.rake"
load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  # Include only specific test directories, excluding integration tests
  t.test_files = FileList[
    "test/components/**/*_test.rb",
    "test/fluxbit/**/*_test.rb",
    "test/helpers/**/*_test.rb",
    "test/models/**/*_test.rb",
    "test/*_test.rb"
  ]
  t.verbose = false
end

# Integration tests that require Rails app context
Rake::TestTask.new("test:generators") do |t|
  t.libs << "test"
  t.pattern = "test/integration/generators/**/*_test.rb"
  t.verbose = false
  t.description = "Run generator tests (requires Rails app context)"
end

task default: :test
task "test:all" => "app:test:all"
task "test:system" => "app:test:system"
