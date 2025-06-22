# frozen_string_literal: true

gem_path = Gem.loaded_specs["fluxbit_view_components"].full_gem_path
template_path = File.join(gem_path, "lib/fluxbit/templates/tailwind.config.js.template")
darkmode_path = File.join(gem_path, "lib/fluxbit/templates/darkmode.js.template")
layout_path = Rails.root.join("app/views/layouts/application.html.erb")
importmap_binstub = Rails.root.join("bin/importmap")
importmap_config = Rails.root.join("config/importmap.rb")
stimulus_path = Rails.root.join("app/javascript/controllers/index.js")
package_json_path = Rails.root.join("package.json")
tailwind_config_path = Rails.root.join("tailwind.config.js")
stylesheets_path = Rails.root.join("app/assets/stylesheets/application.tailwind.css")

say = ->(msg, color = :green) { puts color == :red ? "\e[31m#{msg}\e[0m" : "\e[32m#{msg}\e[0m" }

Bundler.with_unbundled_env do
  say.call "- Adding TailwindCSS gems..."
  system "bundle add tailwindcss-ruby"
  system "bundle add tailwindcss-rails"
end

say.call "- Running tailwindcss:install..."
system "#{RbConfig.ruby} ./bin/rails tailwindcss:install"

say.call "- Installing Flowbite via npm..."
system "npm install flowbite --save"

say.call "- Copying tailwind.config.js from template..."
if File.exist?(template_path)
  FileUtils.cp(template_path, tailwind_config_path)
  say.call "  tailwind.config.js copied successfully!"
else
  say.call "  tailwind.config.js.template not found at #{template_path}.", :red
end

if stylesheets_path.exist?
  say.call "- Updating CSS with Flowbite imports..."
  content = File.read(stylesheets_path)
  content.prepend("@import \"flowbite/src/themes/default\";\n")
  content << "\n@plugin \"flowbite/plugin\";\n@source \"../../../node_modules/flowbite\";\n@config \"../../../tailwind.config.js\";\n@custom-variant dark (&:where(.dark, .dark *));\n\n"
  File.write(stylesheets_path, content)
else
  say.call "⚠️ Couldn't find application.tailwind.css, skipping CSS modifications", :red
end

if layout_path.exist?
  say.call "- Updating layout to include Fluxbit styles..."

  layout_content = File.read(layout_path)

  if layout_content.include?("<head>")
    darkmode_content = File.read(darkmode_path)
    gsub_file layout_path.to_s, "</head>", "#{darkmode_content}\n</head>"
    say.call "  Added darkmode js before </head> tag."
  else
    say.call "</head> tag is not found in application layout.", :red
    say.call "        Add darkmode js manually before the </head> tag."
  end


  if layout_content.include?("<body")
    # gsub_file layout_path.to_s, "<html", "<html class=\"<%= fx_html_class %>\""
    gsub_file layout_path.to_s, "<body>", "<body class=\"<%= fx_body_class %>\">"
  else
    say.call "<body> tag is not found in application layout.", :red
    say.call "        Replace <html> and <body> manually as instructed."
  end
else
  say.call "❌ Default application.html.erb is missing!", :red
  say.call "        1. Add stylesheet_link_tag inside <head>"
  say.call "        2. Replace <html> and <body> manually."
end

say.call "✅ Fluxbit ViewComponents install completed!"
