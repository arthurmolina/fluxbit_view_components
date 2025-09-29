# frozen_string_literal: true

module Fluxbit::Config::AccordionComponent
  mattr_accessor :flush, default: false
  mattr_accessor :color, default: :default
  mattr_accessor :collapse_all, default: false

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "space-y-2",
      item: {
        base: "",
        header: {
          base: "flex items-center justify-between w-full p-5 font-medium rtl:text-right border border-gray-200 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3",
          first: "rounded-t-xl",
          last: "rounded-b-xl",
          middle: "border-b-0"
        },
        content: {
          base: "p-5 border border-gray-200 dark:border-gray-700",
          first: "",
          last: "rounded-b-xl border-t-0",
          middle: "border-t-0 border-b-0"
        },
        icon: {
          base: "w-3 h-3 rotate-180 shrink-0",
          open: "rotate-180",
          closed: ""
        }
      },
      colors: {
        default: {
          header: "bg-white dark:bg-gray-900 text-gray-500 dark:text-gray-400",
          content: "bg-white dark:bg-gray-900 text-gray-500 dark:text-gray-400"
        },
        light: {
          header: "bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-white",
          content: "bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-white"
        },
        primary: {
          header: "bg-blue-50 dark:bg-blue-900 text-blue-900 dark:text-blue-100 border-blue-200 dark:border-blue-800",
          content: "bg-blue-50 dark:bg-blue-900 text-blue-900 dark:text-blue-100 border-blue-200 dark:border-blue-800"
        },
        secondary: {
          header: "bg-gray-100 dark:bg-gray-800 text-gray-800 dark:text-gray-200 border-gray-300 dark:border-gray-700",
          content: "bg-gray-100 dark:bg-gray-800 text-gray-800 dark:text-gray-200 border-gray-300 dark:border-gray-700"
        },
        success: {
          header: "bg-green-50 dark:bg-green-900 text-green-900 dark:text-green-100 border-green-200 dark:border-green-800",
          content: "bg-green-50 dark:bg-green-900 text-green-900 dark:text-green-100 border-green-200 dark:border-green-800"
        },
        danger: {
          header: "bg-red-50 dark:bg-red-900 text-red-900 dark:text-red-100 border-red-200 dark:border-red-800",
          content: "bg-red-50 dark:bg-red-900 text-red-900 dark:text-red-100 border-red-200 dark:border-red-800"
        },
        warning: {
          header: "bg-yellow-50 dark:bg-yellow-900 text-yellow-900 dark:text-yellow-100 border-yellow-200 dark:border-yellow-800",
          content: "bg-yellow-50 dark:bg-yellow-900 text-yellow-900 dark:text-yellow-100 border-yellow-200 dark:border-yellow-800"
        },
        info: {
          header: "bg-cyan-50 dark:bg-cyan-900 text-cyan-900 dark:text-cyan-100 border-cyan-200 dark:border-cyan-800",
          content: "bg-cyan-50 dark:bg-cyan-900 text-cyan-900 dark:text-cyan-100 border-cyan-200 dark:border-cyan-800"
        },
        dark: {
          header: "bg-gray-800 dark:bg-gray-700 text-gray-100 dark:text-gray-200 border-gray-700 dark:border-gray-600",
          content: "bg-gray-800 dark:bg-gray-700 text-gray-100 dark:text-gray-200 border-gray-700 dark:border-gray-600"
        }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
