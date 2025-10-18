---
label: Install
title: Installation Guide
---

You can install everything automatically by running:

```sh
  bundle add fluxbit_view_components
  bin/rails fluxbit_view_components:install
```

Or follow the steps below to install **manually**. Some steps below are the same as the instructions to install Tailwind and Flowbite from this link: [https://flowbite.com/docs/getting-started/rails/](https://flowbite.com/docs/getting-started/rails/)

> ⚠️ This guide assumes you are using **Rails 7.0** or later with **ESBuild** as the JavaScript bundler. If you are using a different setup, please refer to the [Flowbite documentation](https://flowbite.com/docs/getting-started/rails/) for more information.

## Create a new project

If you don't have a Rails project yet, create one:

```sh
  gem install rails
```

Then create a new Rails project with TailwindCSS and ESBuild:

```sh
  rails new myapp -j esbuild --css tailwind; cd myapp
```

> ⚠️ If you already have a Rails project, skip this step.
> ⚠️ If you are using **Importmap** or **Webpacker**, you can use the `--skip-javascript` option to skip the JavaScript setup. You can then add your preferred JavaScript setup later.
> ⚠️ If you are using **Rails 7.1** or later, you can use the `--css tailwind` option to set up TailwindCSS automatically.

## Add Required Gems

Add the TailwindCSS gems to your Gemfile:

```sh
  bundle add tailwindcss-ruby
  bundle add tailwindcss-rails
  bundle add view_components
  bundle add fluxbit_view_components
```

## Install TailwindCSS

Run the installer to generate the configuration files:

```sh
  bin/rails tailwindcss:install
```

## Install Flowbite and Fluxbit ViewComponents via NPM

```sh
  npm install flowbite --save
  npm install fluxbit_view_components --save
  npm install flowbite-datepicker --save
```
> 💡 Replace `npm` with `yarn` or `bun` depending on your setup.

## Configure JavaScript Files

### Update `app/javascript/application.js`

Add the following imports to your `app/javascript/application.js` file:

```js
import "flowbite/dist/flowbite.turbo.js"
import "flowbite-datepicker"
import "./controllers"
import "fluxbit-view-components"
```

### Update `app/javascript/controllers/index.js`

Add the following lines to register Fluxbit Stimulus controllers:

```js
import { registerFluxbitControllers } from "fluxbit-view-components"
registerFluxbitControllers(Stimulus)
```

## Configure `tailwind.config.js`

Create or replace the file `tailwind.config.js` with the following content:

```js
<%= 
  gem_path = Gem.loaded_specs['fluxbit_view_components'].full_gem_path
  template_path = File.join(gem_path, "lib/fluxbit/templates/tailwind.config.js.template")
  File.read(template_path)
%>
```

> ⚠️ The new version of Tailwind CSS (v4.0+) doesn't require to have a `tailwind.config.js` file, but to use Flowbite and Fluxbite you need to have it.

## Update Your Main CSS File

In `app/assets/stylesheets/application.tailwind.css`, add the following lines:

```css
@import "flowbite/src/themes/default";

@plugin "flowbite/plugin";

@source "../../../node_modules/flowbite";

@config "../../../tailwind.config.js";
```

## Update the Default Layout

Edit `app/views/layouts/application.html.erb`:

### Inside the `<head>` tag:

```erb
<%= 
  gem_path = Gem.loaded_specs['fluxbit_view_components'].full_gem_path
  template_path = File.join(gem_path, "lib/fluxbit/templates/darkmode.js.template")
  File.read(template_path)
%>
```

> ⚠️ You only need to add this line if you want to use the dark mode feature.

### Replace the `<body>` tag with:

```erb
  <body class="&lt;%= fx_body_class %&gt;">
```

> ⚠️ If you're using a custom layout, apply the same changes accordingly.

## Done!

Your app is now configured with:

- TailwindCSS
- Flowbite and Flowbite Datepicker
- Fluxbit ViewComponents (Ruby gem and JavaScript package)
- Fluxbit Stimulus controllers
- All necessary styles and helpers

