# frozen_string_literal: true

module Fluxbit::Config::BannerComponent
  mattr_accessor :position, default: :top
  mattr_accessor :color, default: :info
  mattr_accessor :icon, default: :default
  mattr_accessor :dismissible, default: true
  mattr_accessor :full_width, default: true

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "border border-b",
      positions: {
        top: "relative",
        bottom: "relative",
        sticky_top: "fixed top-0 start-0 z-50 w-full",
        sticky_bottom: "fixed bottom-0 start-0 z-50 w-full"
      },
      colors: {
        info: "bg-blue-50 text-blue-800 border-blue-200 dark:bg-gray-800 dark:text-blue-400 dark:border-blue-600",
        success: "bg-green-50 text-green-800 border-green-200 dark:bg-gray-800 dark:text-green-400 dark:border-green-600",
        warning: "bg-yellow-50 text-yellow-800 border-yellow-200 dark:bg-gray-800 dark:text-yellow-300 dark:border-yellow-600",
        danger: "bg-red-50 text-red-800 border-red-200 dark:bg-gray-800 dark:text-red-400 dark:border-red-600",
        dark: "bg-gray-50 text-gray-800 border-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600",
        light: "bg-white text-gray-800 border-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600",
        primary: "bg-primary-50 text-primary-800 border-primary-200 dark:bg-gray-800 dark:text-primary-400 dark:border-primary-600",
        secondary: "bg-gray-50 text-gray-800 border-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600"
      },
      default_icons: {
        info: "information-circle",
        success: "check-circle",
        warning: "exclamation-triangle",
        danger: "exclamation-circle",
        dark: "information-circle",
        light: "information-circle",
        primary: "information-circle",
        secondary: "information-circle"
      },
      content_wrapper: {
        full_width: "flex items-center justify-between w-full p-4",
        constrained: "flex items-center justify-between max-w-screen-xl mx-auto p-4"
      },
      left_content: "flex items-center",
      right_content: "flex items-center",
      text: {
        with_icon_or_logo: "ml-3 text-sm font-normal",
        without_icon_or_logo: "text-sm font-normal"
      },
      dismiss_button: {
        base: "flex-shrink-0 inline-flex justify-center w-7 h-7 items-center text-gray-400 hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 dark:hover:bg-gray-600 dark:hover:text-white",
        with_cta: "ml-3"
      },
      screen_reader: "sr-only",
      icon_default: "size-5 text-current flex-shrink-0",
      close_icon: "w-3 h-3"
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
