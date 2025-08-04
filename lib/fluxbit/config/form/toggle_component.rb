# frozen_string_literal: true

module Fluxbit::Config::Form::ToggleComponent
  mattr_accessor :color, default: :default
  mattr_accessor :unchecked_color, default: :default
  mattr_accessor :button_color, default: :default
  mattr_accessor :invert_label, default: false
  mattr_accessor :sizing, default: 1

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      label: "text-sm rtl:text-right font-medium text-gray-700 dark:text-gray-200 flex items-center",
      input: "size-4 bg-gray-100 border-gray-300 dark:ring-offset-gray-800 focus:ring-2 rounded-sm dark:bg-gray-700 dark:border-gray-600 sr-only peer",
      toggle: {
        base: "me-3 shrink-0 rounded-full peer-focus:ring-4 peer-checked:after:translate-x-full peer-checked:rtl:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:border after:rounded-full after:transition-all relative",
        checked: {
          default: "peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 peer-checked:bg-blue-600",
          success: "peer-focus:ring-green-300 dark:peer-focus:ring-green-800 peer-checked:bg-green-600",
          danger: "peer-focus:ring-red-300 dark:peer-focus:ring-red-800 peer-checked:bg-red-600",
          info: "peer-focus:ring-cyan-300 dark:peer-focus:ring-cyan-800 peer-checked:bg-cyan-600",
          warning: "peer-focus:ring-yellow-300 dark:peer-focus:ring-yellow-800 peer-checked:bg-yellow-600",
          dark: "peer-focus:ring-gray-300 dark:peer-focus:ring-gray-800 peer-checked:bg-gray-600",
          light: "peer-focus:ring-gray-300 dark:peer-focus:ring-gray-100 peer-checked:bg-gray-100",
          teal: "peer-focus:ring-teal-300 dark:peer-focus:ring-teal-800 peer-checked:bg-teal-600",
          purple: "peer-focus:ring-purple-300 dark:peer-focus:ring-purple-800 peer-checked:bg-purple-600",
          cyan: "peer-focus:ring-cyan-300 dark:peer-focus:ring-cyan-800 peer-checked:bg-cyan-600",
          lime: "peer-focus:ring-lime-300 dark:peer-focus:ring-lime-800 peer-checked:bg-lime-600",
          indigo: "peer-focus:ring-indigo-300 dark:peer-focus:ring-indigo-800 peer-checked:bg-indigo-600",
          pink: "peer-focus:ring-pink-300 dark:peer-focus:ring-pink-800 peer-checked:bg-pink-600"
        },
        unchecked: {
          default: "bg-slate-200 dark:bg-slate-700 dark:border-slate-600 after:border-slate-300",
          blue: "bg-blue-600 dark:bg-blue-500 dark:border-blue-500 after:border-blue-600",
          success: "bg-green-600 dark:bg-green-500 dark:border-green-500 after:border-green-600",
          danger: "bg-red-600 dark:bg-red-500 dark:border-red-500 after:border-red-600",
          info: "bg-cyan-600 dark:bg-cyan-500 dark:border-cyan-500 after:border-cyan-600",
          warning: "bg-yellow-600 dark:bg-yellow-500 dark:border-yellow-500 after:border-yellow-600",
          teal: "bg-teal-600 dark:bg-teal-500 dark:border-teal-500 after:border-teal-600",
          purple: "bg-purple-600 dark:bg-purple-500 dark:border-purple-500 after:border-purple-600",
          cyan: "bg-cyan-600 dark:bg-cyan-500 dark:border-cyan-500 after:border-cyan-600",
          lime: "bg-lime-600 dark:bg-lime-500 dark:border-lime-500 after:border-lime-600",
          indigo: "bg-indigo-600 dark:bg-indigo-500 dark:border-indigo-500 after:border-indigo-600",
          pink: "bg-pink-600 dark:bg-pink-500 dark:border-pink-500 after:border-pink-600",
          dark: "bg-gray-600 dark:bg-gray-800 dark:border-gray-600 after:border-gray-300",
          light: "bg-gray-50 dark:bg-gray-300 dark:border-gray-200 after:border-gray-50",
          light_success: "bg-green-200 dark:bg-green-700 dark:border-green-600 after:border-green-300",
          light_danger: "bg-red-200 dark:bg-red-700 dark:border-red-600 after:border-red-300",
          light_info: "bg-cyan-200 dark:bg-cyan-700 dark:border-cyan-600 after:border-cyan-300",
          light_warning: "bg-yellow-200 dark:bg-yellow-700 dark:border-yellow-600 after:border-yellow-300",
          light_teal: "bg-teal-200 dark:bg-teal-700 dark:border-teal-600 after:border-teal-300",
          light_purple: "bg-purple-200 dark:bg-purple-700 dark:border-purple-600 after:border-purple-300",
          light_cyan: "bg-cyan-200 dark:bg-cyan-700 dark:border-cyan-600 after:border-cyan-300",
          light_lime: "bg-lime-200 dark:bg-lime-700 dark:border-lime-600 after:border-lime-300",
          light_indigo: "bg-indigo-200 dark:bg-indigo-700 dark:border-indigo-600 after:border-indigo-300",
          light_pink: "bg-pink-200 dark:bg-pink-700 dark:border-pink-600 after:border-pink-300"
        },
        button: {
          default: "after:bg-white",
          success: "after:bg-green-500",
          danger: "after:bg-red-500",
          info: "after:bg-cyan-500"

        },
        sizes: [
          "w-9 h-5 after:top-[2px] after:start-[2px] after:h-4 after:w-4",
          "w-11 h-6 after:top-0.5 after:start-[2px] after:h-5 after:w-5",
          "w-14 h-7 after:top-0.5 after:start-[4px] after:h-6 after:w-6"
        ],
        active: {
          on: "cursor-pointer",
          off: "cursor-not-allowed opacity-50"
        },
        invert_label: "ms-3"
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
