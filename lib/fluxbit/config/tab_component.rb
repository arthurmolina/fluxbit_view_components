# frozen_string_literal: true

module Fluxbit::Config::TabComponent
  mattr_accessor :variant, default: :default
  mattr_accessor :color, default: :blue
  mattr_accessor :vertical, default: false
  mattr_accessor :tab_panel, default: :default
  mattr_accessor :align, default: :left

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      div: {
        horizontal: "",
        vertical: "md:flex"
      },
      tab_list: {
        ul: {
          horizontal: "flex text-center",
          vertical: "flex-column space-y space-y-4 text-sm font-medium text-gray-500 dark:text-gray-400 md:me-4 mb-4 md:mb-0"
        },
        align: {
          left: "justify-start",
          center: "justify-center",
          right: "justify-end"
        },
        li: "",
        variant: {
          default: "flex-wrap text-sm font-medium text-gray-500 border-b border-gray-200 dark:border-gray-700 dark:text-gray-400",
          underline: "-mb-px flex-wrap border-b border-gray-200 dark:border-gray-700",
          pills: "flex-wrap space-x-2 text-sm font-medium text-gray-500 dark:text-gray-400",
          full_width: "grid w-full grid-flow-col divide-x divide-gray-200 rounded-none text-sm font-medium shadow dark:divide-gray-700 dark:text-gray-400"
        },
        tab_item: {
          base: "inline-flex w-full",
          variant: {
            default: {
              base: "inline-block p-4 rounded-t-lg",
              active: {
                blue: "text-blue-600 bg-gray-100 active dark:bg-gray-800 dark:text-blue-500",
                cyan: "text-cyan-600 bg-gray-100 active dark:bg-gray-800 dark:text-cyan-500",
                green: "text-green-600 bg-gray-100 active dark:bg-gray-800 dark:text-green-500",
                indigo: "text-indigo-600 bg-gray-100 active dark:bg-gray-800 dark:text-indigo-500",
                pink: "text-pink-600 bg-gray-100 active dark:bg-gray-800 dark:text-pink-500",
                purple: "text-purple-600 bg-gray-100 active dark:bg-gray-800 dark:text-purple-500",
                red: "text-red-600 bg-gray-100 active dark:bg-gray-800 dark:text-red-500",
                yellow: "text-yellow-600 bg-gray-100 active dark:bg-gray-800 dark:text-yellow-500",
                gray: "text-gray-600 bg-gray-100 active dark:bg-gray-700 dark:text-white"
              },
              inactive: "hover:text-gray-600 hover:bg-gray-50 dark:hover:bg-gray-800 dark:hover:text-gray-300",
              disabled: "text-gray-400 cursor-not-allowed dark:text-gray-500"
            },
            underline: {
              base: "inline-block p-4 rounded-t-lg border-b-2 ",
              active: {
                blue: "active text-blue-600 border-blue-600 dark:text-blue-500 dark:border-blue-500",
                cyan: "active text-cyan-600 border-cyan-600 dark:text-cyan-500 dark:border-cyan-500",
                green: "active text-green-600 border-green-600 dark:text-green-500 dark:border-green-500",
                indigo: "active text-indigo-600 border-indigo-600 dark:text-indigo-500 dark:border-indigo-500",
                pink: "active text-pink-600 border-pink-600 dark:text-pink-500 dark:border-pink-500",
                purple: "active text-purple-600 border-purple-600 dark:text-purple-500 dark:border-purple-500",
                red: "active text-red-600 border-red-600 dark:text-red-500 dark:border-red-500",
                yellow: "active text-yellow-600 border-yellow-600 dark:text-yellow-500 dark:border-yellow-500",
                gray: "active text-gray-600 border-gray-600 dark:text-gray-500 dark:border-gray-500"
              },
              inactive: "border-transparent hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300",
              disabled: "text-gray-400 border-transparent cursor-not-allowed dark:text-gray-500"
            },
            pills: {
              base: "inline-block px-4 py-3 rounded-lg",
              active: {
                blue: "active text-white bg-blue-600",
                cyan: "active text-white bg-cyan-600",
                green: "active text-white bg-green-600",
                indigo: "active text-white bg-indigo-600",
                pink: "active text-white bg-pink-600",
                purple: "active text-white bg-purple-600",
                red: "active text-white bg-red-600",
                yellow: "active text-white bg-yellow-600",
                gray: "active text-white bg-gray-600"
              },
              inactive: "hover:text-gray-900 hover:bg-gray-100 dark:hover:bg-gray-800 dark:hover:text-white",
              disabled: "text-gray-400 dark:text-gray-500 cursor-not-allowed"
            },
            full_width: {
              base: "inline-block w-full p-4 border-r border-gray-200 dark:border-gray-700 focus:ring-2 focus:ring-blue-300 focus:outline-none",
              active: {
                blue: "text-blue-600 bg-gray-100 active dark:text-blue-500 dark:bg-gray-800",
                cyan: "text-cyan-600 bg-gray-100 active dark:text-cyan-500 dark:bg-gray-800",
                green: "text-green-600 bg-gray-100 active dark:text-green-500 dark:bg-gray-800",
                indigo: "text-indigo-600 bg-gray-100 active dark:text-indigo-500 dark:bg-gray-800",
                pink: "text-pink-600 bg-gray-100 active dark:text-pink-500 dark:bg-gray-800",
                purple: "text-purple-600 bg-gray-100 active dark:text-purple-500 dark:bg-gray-800",
                red: "text-red-600 bg-gray-100 active dark:text-red-500 dark:bg-gray-800",
                yellow: "text-yellow-600 bg-gray-100 active dark:text-yellow-500 dark:bg-gray-800",
                gray: "active text-gray-900 bg-gray-100 dark:bg-gray-700 dark:text-white"
              },
              inactive: "bg-white hover:text-gray-700 hover:bg-gray-50 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700",
              disabled: "cursor-not-allowed",
              first: "rounded-s-lg",
              last: "rounded-e-lg",
              middle: ""
            }
          },
          icon: "mr-2 h-5 w-5"
        }
      },
      tabpanel_container: {
        horizontal: "",
        vertical: "w-full"
      },
      tabpanel: {
        horizontal: {
          none: {
            active: "",
            inactive: "hidden"
          },
          default: {
            active: "p-4 rounded-b-lg bg-gray-50 dark:bg-gray-800",
            inactive: "p-4 rounded-b-lg bg-gray-50 dark:bg-gray-800 hidden"
          }
        },
        vertical: {
          none: {
            active: "",
            inactive: "hidden"
          },
          default: {
            active: "p-6 bg-gray-50 text-medium text-gray-500 dark:text-gray-400 dark:bg-gray-800 rounded-lg h-full",
            inactive: "p-6 bg-gray-50 text-medium text-gray-500 dark:text-gray-400 dark:bg-gray-800 rounded-lg h-full hidden"
          }
        }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
