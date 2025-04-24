require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Store uploaded files on the local file system in a temporary directory.
    config.active_storage.service = :test

    # Don't generate system test files.
    config.generators.system_tests = nil

    # ViewComponent
    config.view_component.default_preview_layout = "preview"
    config.view_component.preview_paths << Rails.root.join("../previews").to_s
    config.view_component.view_component_path = Rails.root.join("../app/components").to_s

    # Lookbook
    svg_file_path = Rails.root.join("public/fluxbit_logo.svg")
    svg_content = File.read(svg_file_path)
    config.lookbook.project_logo = svg_content
    config.lookbook.ui_favicon = svg_content.gsub("currentColor", "#0068e6")
    config.lookbook.project_name = "Fluxbit ViewComponents"
    config.lookbook.preview_display_options = { theme: [ "light", "dark" ] }
    config.lookbook.preview_inspector.sidebar_panels = [ "pages", "previews" ]
    config.lookbook.page_collection_label = "Documentation"
    config.lookbook.page_paths = [ Rails.root.join("../docs").to_s ]
    config.lookbook.page_extensions << "md"
  end
end
