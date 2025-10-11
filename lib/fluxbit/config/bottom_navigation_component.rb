# frozen_string_literal: true

module Fluxbit::Config::BottomNavigationComponent
  mattr_accessor :variant, default: :default
  mattr_accessor :border, default: true

  # rubocop:disable Layout/LineLength
  mattr_accessor :styles do
    {
      variants: {
        default: {
          base: "fixed bottom-0 left-0 z-50 w-full h-16 bg-white dark:bg-gray-700",
          border: "border-t border-gray-200 dark:border-gray-600"
        },
        app_bar: {
          base: "fixed z-50 w-full h-16 max-w-lg -translate-x-1/2 bg-white border border-gray-200 rounded-full bottom-4 left-1/2 dark:bg-gray-700 dark:border-gray-600",
          border: ""
        }
      },
      container: {
        base: "grid h-full max-w-lg mx-auto font-medium",
        columns: [
          "grid-cols-2",  # 2 columns (index 0)
          "grid-cols-3",  # 3 columns (index 1)
          "grid-cols-4",  # 4 columns (index 2)
          "grid-cols-5",  # 5 columns (index 3)
          "grid-cols-6"   # 6 columns (index 4)
        ]
      },
      item: {
        base: "inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-800 group",
        active: "text-blue-600 dark:text-blue-500",
        inactive: "text-gray-500 dark:text-gray-400",
        icon_wrapper: "w-5 h-5 mb-2",
        icon: "w-5 h-5",
        text: "text-sm group-hover:text-blue-600 dark:group-hover:text-blue-500",
        sr_only: "sr-only"
      },
      cta_wrapper: "flex items-center justify-center",
      cta: {
        button: "inline-flex items-center justify-center w-10 h-10 font-medium bg-blue-600 rounded-full hover:bg-blue-700 group focus:ring-4 focus:ring-blue-300 focus:outline-none dark:focus:ring-blue-800",
        icon: "w-4 h-4 text-white dark:text-white"
      },
      tooltip: {
        base: "absolute z-10 invisible inline-block px-3 py-2 text-sm font-medium text-white transition-opacity duration-300 bg-gray-900 rounded-lg shadow-sm opacity-0 tooltip dark:bg-gray-700",
        arrow: "tooltip-arrow"
      },
      pagination: {
        container: "inline-flex items-center justify-center col-span-2",
        button: "inline-flex items-center justify-center h-full px-5 hover:bg-gray-50 dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed",
        icon: "w-3 h-3 text-gray-500 dark:text-gray-400",
        info: "flex items-center text-sm text-gray-500 dark:text-gray-400"
      },
      button_group: {
        container: "grid max-w-xs p-1 mx-auto my-2 bg-gray-100 rounded-lg dark:bg-gray-600",
        grid: "grid gap-1",
        button: "px-5 py-1.5 text-xs font-medium hover:bg-white dark:hover:bg-gray-700 rounded-lg",
        button_active: "text-gray-900 bg-white dark:text-white dark:bg-gray-700",
        button_inactive: "text-gray-500 dark:text-gray-400"
      }
    }
  end
  # rubocop:enable Layout/LineLength
end
