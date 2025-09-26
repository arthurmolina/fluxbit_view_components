# frozen_string_literal: true

module Fluxbit::Config::SpeedDialComponent
  mattr_accessor :position, default: :bottom_right
  mattr_accessor :square, default: false
  mattr_accessor :text_outside, default: false

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "fixed z-50 group",
      positions: {
        top_left: "top-6 start-6",
        top_right: "top-6 end-6",
        bottom_left: "bottom-6 start-6",
        bottom_right: "bottom-6 end-6"
      },
      menu: {
        base: "flex flex-col items-center space-y-2",
        hidden: "hidden"
      },
      trigger: {
        base: "flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium text-sm px-4 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 transition-all duration-200",
        shapes: {
          rounded: "rounded-full w-14 h-14",
          square: "rounded-lg w-14 h-14"
        },
        icon: "w-5 h-5 transition-transform group-hover:rotate-45"
      },
      action: {
        base: "flex justify-center items-center w-[52px] h-[52px] text-gray-500 hover:text-gray-900 bg-white border border-gray-200 dark:border-gray-600 shadow-sm dark:hover:text-white dark:text-gray-400 hover:bg-gray-50 dark:bg-gray-700 dark:hover:bg-gray-600 focus:ring-4 focus:ring-gray-300 focus:outline-none dark:focus:ring-gray-400 transition-all duration-200",
        shapes: {
          rounded: "rounded-full",
          square: "rounded-lg"
        },
        icon: "w-5 h-5",
        text: {
          base: "relative",
          outside: "block mb-px text-sm font-medium text-gray-900 dark:text-white"
        }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end