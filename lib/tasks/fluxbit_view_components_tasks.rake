# frozen_string_literal: true

namespace :fluxbit_view_components do
  desc "Setup Fluxbit::ViewComponents for the app"
  task :install do
    system "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{File.expand_path("../install/install.rb", __dir__)}"
  end

  desc "Copy Fluxbit ViewComponents to the application (default value of destination is app/components/fluxbit)"
  task :copy_components, [ :destination ] do |t, args|
    require "fileutils"

    gem_path = Gem.loaded_specs["fluxbit_view_components"].full_gem_path
    components_source = File.join(gem_path, "app/components/fluxbit")
    components_destination = args[:destination] || Rails.root.join("app/components/fluxbit")

    if Dir.exist?(components_source)
      FileUtils.mkdir_p(components_destination)
      FileUtils.cp_r("#{components_source}/.", components_destination)
      puts "✅ Components copied to #{components_destination}"
    else
      puts "❌ Components source directory not found at #{components_source}"
    end
  end

  desc "Copy Fluxbit ViewComponents Previews to the application (default value of destination is test/components/previews/fluxbit)"
  task :copy_previews, [ :destination ] do |t, args|
    require "fileutils"

    gem_path = Gem.loaded_specs["fluxbit_view_components"].full_gem_path
    previews_source = File.join(gem_path, "previews/fluxbit")
    previews_destination = args[:destination] || Rails.root.join("test/components/previews/fluxbit")

    if Dir.exist?(previews_source)
      FileUtils.mkdir_p(previews_destination)
      FileUtils.cp_r("#{previews_source}/.", previews_destination)
      puts "✅ Previews copied to #{previews_destination}"
    else
      puts "❌ Previews source directory not found at #{previews_source}"
    end
  end
end
