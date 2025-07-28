# frozen_string_literal: true

module Fluxbit::Config::BadgeComponent
  mattr_accessor :color, default: :info
  mattr_accessor :border, default: false
  mattr_accessor :pill, default: false
  mattr_accessor :size, default: 0
  mattr_accessor :as, default: :div
  mattr_accessor :perfect_rounded, default: 0
  mattr_accessor :notification, default: ""

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "inline-flex items-center gap-1 font-medium me-2 rounded-sm",
      pill: "rounded-full",
      colors: {
        info: "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300",
        dark: "bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300",
        failure: "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300",
        success: "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300",
        warning: "bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300",
        indigo: "bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-300",
        purple: "bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-300",
        pink: "bg-pink-100 text-pink-800 dark:bg-pink-900 dark:text-pink-300",
        cyan: "bg-cyan-100 text-cyan-800 dark:bg-cyan-900 dark:text-cyan-200",
        lime: "bg-lime-100 text-lime-800 dark:bg-lime-900 dark:text-lime-400",
        teal: "bg-teal-100 text-teal-800 dark:bg-teal-900 dark:text-teal-400",
        solid_info: "text-white bg-blue-500 border-1 border-white dark:border-gray-900",
        solid_dark: "text-white bg-gray-500 border-1 border-white dark:border-gray-900",
        solid_failure: "text-white bg-red-500 border-1 border-white dark:border-gray-900",
        solid_success: "text-white bg-green-500 border-1 border-white dark:border-gray-900",
        solid_warning: "text-white bg-yellow-500 border-1 border-white dark:border-gray-900",
        solid_indigo: "text-white bg-indigo-500 border-1 border-white dark:border-gray-900",
        solid_purple: "text-white bg-purple-500 border-1 border-white dark:border-gray-900",
        solid_pink: "text-white bg-pink-500 border-1 border-white dark:border-gray-900",
        solid_cyan: "text-white bg-cyan-500 border-1 border-white dark:border-gray-900",
        solid_lime: "text-white bg-lime-500 border-1 border-white dark:border-gray-900",
        solid_teal: "text-white bg-teal-500 border-1 border-white dark:border-gray-900",

        info_bordered: "bg-blue-100 text-blue-800 dark:bg-gray-700 dark:text-blue-400 border border-blue-400",
        dark_bordered: "bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-400 border border-gray-500",
        failure_bordered: "bg-red-100 text-red-800 dark:bg-gray-700 dark:text-red-400 border border-red-400",
        success_bordered: "bg-green-100 text-green-800 dark:bg-gray-700 dark:text-green-400 border border-green-400",
        warning_bordered: "bg-yellow-100 text-yellow-800 dark:bg-gray-700 dark:text-yellow-300 border border-yellow-300",
        indigo_bordered: "bg-indigo-100 text-indigo-800 dark:bg-gray-700 dark:text-indigo-400 border border-indigo-400",
        purple_bordered: "bg-purple-100 text-purple-800 dark:bg-gray-700 dark:text-purple-400 border border-purple-400",
        pink_bordered: "bg-pink-100 text-pink-800 dark:bg-gray-700 dark:text-pink-400 border border-pink-400",
        cyan_bordered: "bg-cyan-100 text-cyan-800 dark:bg-cyan-900 dark:text-cyan-200 border border-cyan-400",
        lime_bordered: "bg-lime-100 text-lime-800 dark:bg-lime-900 dark:text-lime-400 border border-lime-400",
        teal_bordered: "bg-teal-100 text-teal-800 dark:bg-teal-900 dark:text-teal-400 border border-teal-400"
      },
      sizes: [
        "p-1 text-xs", "p-1.5 text-sm"
      ],
      perfect_rounded: [
        "h-fit px-2.5 py-0.5",
        "justify-center size-4",
        "justify-center size-6",
        "justify-center size-8",
        "justify-center size-10",
        "justify-center size-12"
    ],
      notification: {
        default: "absolute",
        positions: {
          top: "-top-1",
          bottom: "top-5",
          left: "end-4",
          right: "-end-4"
        }
      },
      dismissable: "ml-2 cursor-pointer"
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
