# frozen_string_literal: true

module Fluxbit::Config::BreadcrumbComponent
  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      root: {
        base: "",
        list: "inline-flex items-center"
      },
      item: {
        base: "group flex items-center",
        chevron: "mx-1 h-4 w-4 text-gray-400 group-first:hidden md:mx-2",
        icon: "mr-2 h-4 w-4",
        click_cursor: "cursor-pointer",
        href: {
          on:  "flex items-center text-sm font-medium text-gray-700 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white",
          off: "flex items-center text-sm font-medium text-gray-500 dark:text-gray-400"
        }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
