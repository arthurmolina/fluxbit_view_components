# frozen_string_literal: true

require "rails/generators/base"

module Fluxbit
  module ViewPathTemplates
    extend ActiveSupport::Concern

    included do
      argument :scope, required: false, default: nil, desc: "The scope to copy views to"
      class_option :views, aliases: "-v", type: :array, desc: "Select specific view directories to generate (confirmations, passwords, registrations, sessions, unlocks, mailer)"

      public_task :copy_views
    end

    def copy_views
      if options[:views]
        options[:views].each do |directory|
          view_directory directory.to_sym
        end
      else
        view_directory :confirmations
        view_directory :passwords
        view_directory :registrations
        view_directory :sessions
        view_directory :unlocks
        view_directory :shared
        view_directory :mailer
      end

      copy_layout
      configure_layouts
    end

    def copy_layout
      template "layouts/devise.html.erb", "app/views/layouts/devise.html.erb"
    end

    def configure_layouts
      layout_config = <<-RUBY
    # Use the Devise layout for all Devise controllers
    config.to_prepare do
      Devise::SessionsController.layout "devise"
      Devise::RegistrationsController.layout "devise"
      Devise::ConfirmationsController.layout "devise"
      Devise::UnlocksController.layout "devise"
      Devise::PasswordsController.layout "devise"
    end

      RUBY

      inject_into_file(
        "config/application.rb",
        layout_config,
        after: "class Application < Rails::Application\n"
      )
    end

    protected

    def view_directory(name, _target_path = nil)
      directory name.to_s, _target_path || "#{target_path}/#{name}" do |content|
        if scope
          content.gsub("devise/shared", "#{plural_scope}/shared")
        else
          content
        end
      end
    end

    def target_path
      @target_path ||= "app/views/#{plural_scope || :devise}"
    end

    def plural_scope
      @plural_scope ||= scope.presence && scope.underscore.pluralize
    end
  end

  class DeviseViewsGenerator < Rails::Generators::Base
    include ViewPathTemplates

    source_root File.expand_path("templates/devise_views", __dir__)
    desc "Copies Devise views into your app. Usage: rails g fluxbit:devise_views"
  end

  class SharedViewsGenerator < Rails::Generators::Base # :nodoc:
    include ViewPathTemplates
    source_root File.expand_path("./devise_views", __FILE__)
    desc "Copies shared Devise views to your application."
    hide!

    # Override copy_views to just copy mailer and shared.
    def copy_views
      view_directory :shared
    end
  end

  class FormForGenerator < Rails::Generators::Base # :nodoc:
    include ViewPathTemplates
    source_root File.expand_path("./devise_views", __FILE__)
    desc "Copies default Devise views to your application."
    hide!
  end

  class ErbGenerator < Rails::Generators::Base # :nodoc:
    include ViewPathTemplates
    source_root File.expand_path("./devise_views", __FILE__)
    desc "Copies Devise mail erb views to your application."
    hide!

    def copy_views
      view_directory(:mailer) if !options[:views] || options[:views].include?("mailer")
    end
  end
end
