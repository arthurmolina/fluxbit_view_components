# frozen_string_literal: true

require "bundler/setup"

APP_RAKEFILE = File.expand_path("demo/Rakefile", __dir__)
load "rails/tasks/engine.rake"
load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end

task default: :test
task "test:all" => "app:test:all"
task "test:system" => "app:test:system"
