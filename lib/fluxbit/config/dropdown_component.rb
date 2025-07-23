# frozen_string_literal: true

module Fluxbit::Config::DropdownComponent
  # mattr_accessor :placement, default: :left
  mattr_accessor :sizing, default: 0
  mattr_accessor :auto_divider, default: true
  mattr_accessor :height, default: 0

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "z-10 hidden bg-white rounded-lg shadow-sm dark:bg-gray-700",
      ul: "py-1 text-sm text-gray-700 dark:text-gray-200",
      auto_divider: "divide-y divide-gray-200 dark:divide-gray-600",
      divider: "border-t border-gray-200 dark:border-gray-600",
      icon: "mr-2 h-4 w-4",
      sizes: [ "w-44", "w-60", "w-72", "w-80" ],
      items: {
        types: {
          div: "py-2 overflow-y-auto text-gray-700 dark:text-gray-200",
          a: "flex items-center p-3 text-sm font-medium text-blue-600  rounded-b-lg bg-gray-50 dark:border-gray-600 hover:bg-gray-100 dark:bg-gray-700 dark:hover:bg-gray-600 dark:text-blue-500 hover:underline",
          button: "flex items-center justify-between w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white",
          li: "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-600"
        },
        heights: [ "", "h-48", "h-60", "h-72", "h-80" ]
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
