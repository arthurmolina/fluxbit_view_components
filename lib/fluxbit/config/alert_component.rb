# frozen_string_literal: true

module Fluxbit::Config::AlertComponent
  mattr_accessor :color, default: :info
  mattr_accessor :icon, default: :default
  mattr_accessor :can_close, default: true
  mattr_accessor :out_animation, default: :fade_out
  mattr_accessor :fade_in_animation, default: true
  mattr_accessor :dismiss_timeout, default: 3000
  mattr_accessor :all_rounded, default: true

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "flex p-4 mb-4 dark:bg-gray-800 ",
      all_rounded: {
        on: "rounded-lg border-2",
        off: "rounded-l-lg border-l-2 border-y-2"
      },
      colors: {
        info: "text-blue-800 border-blue-300 bg-blue-50 dark:text-blue-400 dark:border-blue-800",
        danger: "text-red-800 border-red-300 bg-red-50 dark:text-red-400 dark:border-red-800",
        success: "text-green-800 border-green-300 bg-green-50 dark:text-green-400 dark:border-green-800",
        warning: "text-yellow-800 border-yellow-300 bg-yellow-50 dark:text-yellow-300 dark:border-yellow-800",
        dark: "border-gray-300 bg-gray-50 dark:border-gray-600"
      },
      close_button: {
        base: "ml-auto -mx-1.5 -my-1.5 rounded-lg focus:ring-2 p-1.5 inline-flex justify-center h-8 w-8 dark:bg-gray-800",
        colors: {
          info: "bg-blue-50 text-blue-500 focus:ring-blue-400 hover:bg-blue-200 dark:text-blue-400 dark:hover:bg-gray-700",
          danger: "bg-red-50 text-red-500 focus:ring-red-400 hover:bg-red-200 dark:text-red-400 dark:hover:bg-gray-700",
          success: "bg-green-50 text-green-500 focus:ring-green-400 hover:bg-green-200 dark:text-green-400 dark:hover:bg-gray-700",
          warning: "bg-yellow-50 text-yellow-500 focus:ring-yellow-400 hover:bg-yellow-200 dark:text-yellow-300 dark:hover:bg-gray-700",
          dark: "bg-gray-50 text-gray-500 focus:ring-gray-400 hover:bg-gray-200 dark:text-gray-300 dark:hover:bg-gray-700 dark:hover:text-white"
        }
      },
      default_icons: {
        info: "information-circle",
        danger: "exclamation-triangle",
        success: "check-circle",
        warning: "exclamation-circle",
        dark: "information-circle"
      },
      animations: {
        just_remove: { from: "", to: "" },
        dont_remove: "",
        fade_out: { from: "opacity-100", to: "opacity-0" },
        fade_out_to_right: { from: "opacity-100 translate-x-0", to: "opacity-0 translate-x-6" },
        fade_out_to_left: { from: "opacity-100 translate-x-0", to: "opacity-0 -translate-x-6" },
        fade_out_to_top: { from: "opacity-100 translate-x-0", to: "opacity-0 -translate-y-6" },
        fade_out_to_bottom: { from: "opacity-100 translate-x-0", to: "opacity-0 translate-y-6" },
        fade_out_and_shrink: { from: "opacity-100 scale-100", to: "opacity-0 scale-50" },
        fade_out_and_stretch: { from: "opacity-100 scale-100", to: "opacity-0 scale-150" },
        fade_out_and_rotate: { from: "opacity-100 rotate-0", to: "opacity-0 rotate-45" }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
