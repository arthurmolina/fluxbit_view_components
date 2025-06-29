# frozen_string_literal: true

module Fluxbit::Config::LinkComponent
  mattr_accessor :color, default: :primary

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "font-medium text-blue-600 dark:text-blue-500 hover:underline",
      colors: {
        default: "text-gray-900 dark:text-white",
        primary: "text-blue-600 dark:text-blue-500",
        secondary: "text-gray-500 dark:text-gray-400",
        success: "text-green-600 dark:text-green-500",
        danger: "text-red-600 dark:text-red-500",
        warning: "text-yellow-600 dark:text-yellow-500",
        info: "text-blue-400 dark:text-blue-300",
        light: "text-gray-300 dark:text-gray-200",
        dark: "text-gray-800 dark:text-gray-700"
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
