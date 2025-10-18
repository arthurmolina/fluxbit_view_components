module.exports = {
  plugins: [
    require('flowbite/plugin')
  ],
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './test/components/**/*.html.erb',
    '../previews/fluxbit/**/*.{erb,rb}',
    './node_modules/flowbite/**/*.js'
  ],
  safelist: [
    'duration-300',
    'duration-500',
    'duration-1000',
    'duration-[3s]',
    'animate-spin'
  ]
}

const execSync = require('child_process').execSync;
module.exports.content.push(
  `${execSync("bundle show fluxbit").toString().trim()}/**/*.{erb,html,rb}`
);
