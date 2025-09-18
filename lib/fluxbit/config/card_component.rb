# frozen_string_literal: true

module Fluxbit::Config::CardComponent
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
      base:         "",
      base_image_left: "flex flex-row",
      border:       "border border-gray-200 dark:border-gray-700",
      shadow:       "shadow-sm",
      rounded:      "rounded-lg",
      hoverable:    "transition-shadow hover:shadow-lg",
      clickable: {
        default: "cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-700",
        primary: "cursor-pointer hover:bg-blue-100 dark:hover:bg-blue-800",
        success: "cursor-pointer hover:bg-green-100 dark:hover:bg-green-800",
        danger:  "cursor-pointer hover:bg-red-100 dark:hover:bg-red-800"
      },
      # "flex flex-col items-center bg-white border border-gray-200 rounded-lg shadow-sm md:flex-row md:max-w-xl dark:border-gray-700"
      header:       "px-4 py-2 font-semibold text-gray-900 dark:text-gray-100",
      body:         "px-4 py-2 space-y-4",
      footer:       "px-4 py-2 text-sm text-gray-500 dark:text-gray-400",
      image_top:    "w-full",
      image_left:   "object-cover w-full rounded-t-lg h-96 md:h-auto md:w-48 md:rounded-none md:rounded-s-lg",
      content_left: "px-4 py-2",
      colors: {
        default: "bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100",
        primary: "bg-blue-50 text-blue-900 border-blue-200 dark:bg-blue-900 dark:text-white dark:border-blue-800",
        success: "bg-green-50 text-green-900 border-green-200 dark:bg-green-900 dark:text-white dark:border-green-800",
        danger:  "bg-red-50 text-red-900 border-red-200 dark:bg-red-900 dark:text-white dark:border-red-800"
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
