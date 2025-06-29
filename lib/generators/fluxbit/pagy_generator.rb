# frozen_string_literal: true

require "rails/generators/base"

module Fluxbit
  class PagyGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)
    desc "Copies fluxbit_pagy.css and imports it in application.css"

    def copy_css_file
      copy_file "fluxbit_pagy.css", "app/assets/stylesheets/fluxbit_pagy.css"
    end

    def import_into_application_css
      import_line = "@import \"fluxbit_pagy\";"
      tailwind_path = "app/assets/stylesheets/application.tailwind.css"
      default_path  = "app/assets/stylesheets/application.css"

      target_file = if File.exist?(tailwind_path)
                      tailwind_path
      elsif File.exist?(default_path)
                      default_path
      else
                      say_status :error, "No application CSS file found (expected application.tailwind.css or application.css)", :red
                      return
      end

      if File.exist?(target_file)
        unless File.read(target_file).include?(import_line)
          append_to_file target_file, "\n#{import_line}\n"
        else
          say_status :skipped, "#{import_line} already present in #{target_file}"
        end
      else
        say_status :error, "#{target_file} not found", :red
      end
    end
  end
end
