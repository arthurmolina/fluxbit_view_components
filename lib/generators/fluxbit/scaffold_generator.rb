require "rails/generators"
require "rails/generators/named_base"

module Fluxbit
  class ScaffoldGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)
    argument :attributes, type: :array, default: [], banner: "field:type field:type"

    # Turbo option
    class_option :turbo, type: :boolean, default: true, desc: "Use Turbo Streams for dynamic updates"

    # Modal/Drawer option
    class_option :ui, type: :string, default: "drawer", enum: [ "modal", "drawer", "none" ], desc: "Choose UI interaction for forms"

    # Paginator option
    class_option :paginator, type: :boolean, default: true, desc: "Include pagination using Pagy"

    # Authorization option
    class_option :pundit, type: :boolean, default: true, desc: "Include Pundit for authorization"

    # Namespace option
    class_option :namespace, type: :string, default: nil, desc: "Namespace for the controller (e.g., 'admin', 'api/v1')"

    def generate_model_and_migration
      # Use Rails model generator to create model & migration (if not already present)
      model_args = [ name ] + attributes
      generate("model", *model_args)
    end

    def generate_scaffold_files
      # Add resource route
      if namespaced?
        # Build nested namespace blocks
        namespace_parts = namespace_path.split("/")
        namespace_opens = namespace_parts.map.with_index do |part, idx|
          "  " * idx + "namespace :#{part} do"
        end.join("\n")
        namespace_closes = namespace_parts.size.times.map { |i| "  " * (namespace_parts.size - 1 - i) + "end" }.join("\n")
        indent = "  " * namespace_parts.size

        route %(#{namespace_opens}
#{indent}resources :#{file_name.pluralize} do
#{indent}  collection do
#{indent}    put "update_all"
#{indent}    patch "update_all"
#{indent}    delete "destroy_all"
#{indent}  end
#{indent}end
#{namespace_closes})
      else
        route %(resources :#{file_name.pluralize} do
    collection do
      put "update_all"
      patch "update_all"
      delete "destroy_all"
    end
  end)
      end

      # Ensure controller directory exists
      empty_directory controller_dir if namespaced?

      # Generate controller from template
      template "controller.rb.tt", File.join(controller_dir, "#{file_name.pluralize}_controller.rb")

      # Ensure view directory exists
      empty_directory view_dir

      # Generate view templates from templates
      template "index.html.erb.tt",     File.join(view_dir, "index.html.erb")
      template "show.html.erb.tt",      File.join(view_dir, "show.html.erb")
      template "new.html.erb.tt",       File.join(view_dir, "new.html.erb")
      template "edit.html.erb.tt",      File.join(view_dir, "edit.html.erb")
      template "_form.html.erb.tt",     File.join(view_dir, "_form.html.erb")
      template "_metadata.html.erb.tt", File.join(view_dir, "_metadata.html.erb")
      template "partial.html.erb.tt",   File.join(view_dir, "_#{file_name.pluralize}.html.erb")

      # Generate Jbuilder templates
      template "index.json.jbuilder.tt", File.join(view_dir, "index.json.jbuilder")
      template "show.json.jbuilder.tt",  File.join(view_dir, "show.json.jbuilder")

      # Generate Turbo Stream response templates
      template "create.turbo_stream.erb.tt",      File.join(view_dir, "create.turbo_stream.erb")
      template "update.turbo_stream.erb.tt",      File.join(view_dir, "update.turbo_stream.erb")
      template "update_all.turbo_stream.erb.tt",  File.join(view_dir, "update_all.turbo_stream.erb")
      template "destroy.turbo_stream.erb.tt",     File.join(view_dir, "destroy.turbo_stream.erb")
      template "destroy_all.turbo_stream.erb.tt", File.join(view_dir, "destroy_all.turbo_stream.erb")

      # Generate i18n
      template "i18n.en.yml.tt",    File.join("config", "locales", "#{file_name.pluralize}.en.yml")
      template "i18n.pt-BR.yml.tt", File.join("config", "locales", "#{file_name.pluralize}.pt-BR.yml")

      # Generate Policy
      template "policy.rb.tt", File.join("app/policies", "#{file_name.singularize}_policy.rb")

      # Generate shared partials
      template "_alert.html.erb.tt", File.join("app/views/shared", "_alert.html.erb")
      template "_flash.html.erb.tt", File.join("app/views/shared", "_flash.html.erb")
    end

    private

    # Returns the namespace path (e.g., "admin" or "api/v1")
    def namespace_path
      options[:namespace]
    end

    # Returns true if namespace is present
    def namespaced?
      namespace_path.present?
    end

    # Returns the namespace as a module (e.g., "Admin" or "Api::V1")
    def namespace_module
      return nil unless namespaced?
      namespace_path.split("/").map(&:camelize).join("::")
    end

    # Returns the controller directory path (e.g., "app/controllers/admin")
    def controller_dir
      if namespaced?
        File.join("app/controllers", namespace_path)
      else
        "app/controllers"
      end
    end

    # Returns the view directory path (e.g., "app/views/admin/products")
    def view_dir
      if namespaced?
        File.join("app/views", namespace_path, file_name.pluralize)
      else
        File.join("app/views", file_name.pluralize)
      end
    end

    # Returns the namespaced class name (e.g., "Admin::ProductsController")
    def namespaced_class_name
      if namespaced?
        "#{namespace_module}::#{class_name}"
      else
        class_name
      end
    end

    # Returns the controller file path (e.g., "admin/products_controller.rb")
    def controller_file_path
      if namespaced?
        File.join(namespace_path, "#{file_name.pluralize}_controller.rb")
      else
        "#{file_name.pluralize}_controller.rb"
      end
    end

    # Returns the path helper prefix (e.g., "admin_" or "api_v1_")
    def path_prefix
      if namespaced?
        namespace_path.split("/").join("_") + "_"
      else
        ""
      end
    end
  end
end
