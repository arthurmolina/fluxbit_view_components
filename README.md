# Fluxbit ViewComponents

![Gem Downloads (for latest version)](https://img.shields.io/gem/dtv/fluxbit_view_components) ![GitHub License](https://img.shields.io/github/license/arthurmolina/fluxbit_view_components) ![GitHub last commit](https://img.shields.io/github/last-commit/arthurmolina/fluxbit_view_components) ![Gem Downloads (for latest version)](https://img.shields.io/gem/dtv/fluxbit_view_components) ![Gem Total Downloads](https://img.shields.io/gem/dt/fluxbit_view_components) ![GitHub forks](https://img.shields.io/github/forks/arthurmolina/fluxbit_view_components)



Fluxbit ViewComponents is an implementation of the Fluxbit Design System using [ViewComponent](https://github.com/github/view_component).

<div style="text-align: center;">
  <img src="docs/fluxbit.png" alt="Fluxbit ViewComponents" width="300" />
</div>

## Preview

We have a Lookbook app online to show the documentation and all the Components available in action!

Just [Click here!](https://fluxbit.artz.to)

## Usage

Render Fluxbit ViewComponents:

```erb
<%= fx_card(title: "Title") do %>
  <p>Card example</p>
<% end %>
```

## Dependencies

- [Anyicon](https://github.com/arthurmolina/anyicon)

## Installation

Add `fluxbit_view_components` to your Gemfile:

```bash
bundle add fluxbit_view_components
```

Run installer:
```bash
bin/rails fluxbit_view_components:install
```

## Development

To get started:

1. Run: `bundle install`
2. Run: `yarn install`
3. Run: `bin/dev`

It will open demo app with component previews on `localhost:3000`. You can change components and they will be updated on page reload. Component previews located in `demo/test/components/previews`.

![Lookbook](/docs/lookbook.png)

To run tests:

```bash
rake
```

## Releases

The library follows [semantic versioning](https://semver.org/). To draft a new release you need to run `bin/release` with a new version number:

```bash
bin/release VERSION
```

Where the VERSION is the version number you want to release. This script will update the version in the gem and push it to GitHub and Rubygems automatically.

To release a new version of npm package update the package.json file with the new version number and run:

```bash
npm run release
```

After that make sure to commit changes in package.json.

## Documentation

For more information, check out the following resources:

- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md): Guidelines for contributing to this project and fostering a welcoming community.
- [CONTRIBUTING.md](CONTRIBUTING.md): Instructions on how to contribute to the project, including setting up your environment and submitting changes.
- [PULL_REQUEST_TEMPLATE.md](PULL_REQUEST_TEMPLATE.md): Template for submitting pull requests to ensure consistency and quality.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
