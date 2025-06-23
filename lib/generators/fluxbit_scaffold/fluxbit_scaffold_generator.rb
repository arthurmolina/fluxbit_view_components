require "rails/generators"
require "rails/generators/named_base"

class FluxbitScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)
  argument :attributes, type: :array, default: [], banner: "field:type field:type"

  def generate_model_and_migration
    # Use Rails model generator to create model & migration (if not already present)
    model_args = [ name ] + attributes
    generate("model", *model_args)
  end

  def generate_scaffold_files
    # Add resource route
    route %{resources :#{file_name.pluralize}}

    # Generate controller from template
    template "controller.rb.tt", File.join("app/controllers", "#{file_name.pluralize}_controller.rb")

    # Ensure view directory exists
    empty_directory File.join("app/views", file_name.pluralize)

    # Generate view templates from templates
    template "index.html.erb.tt",  File.join("app/views", file_name.pluralize, "index.html.erb")
    template "show.html.erb.tt",   File.join("app/views", file_name.pluralize, "show.html.erb")
    template "new.html.erb.tt",    File.join("app/views", file_name.pluralize, "new.html.erb")
    template "edit.html.erb.tt",   File.join("app/views", file_name.pluralize, "edit.html.erb")
    template "_form.html.erb.tt",  File.join("app/views", file_name.pluralize, "_form.html.erb")
    template "partial.html.erb.tt",File.join("app/views", file_name.pluralize, "_#{file_name}.html.erb")

    # Generate Turbo Stream response templates
    template "create.turbo_stream.erb.tt",   File.join("app/views", file_name.pluralize, "create.turbo_stream.erb")
    template "update.turbo_stream.erb.tt",   File.join("app/views", file_name.pluralize, "update.turbo_stream.erb")
    template "destroy.turbo_stream.erb.tt",  File.join("app/views", file_name.pluralize, "destroy.turbo_stream.erb")
  end
end
