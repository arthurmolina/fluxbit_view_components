# frozen_string_literal: true

module Fluxbit::Config::TableComponent
  mattr_accessor :striped, default: false
  mattr_accessor :bordered, default: false
  mattr_accessor :hover, default: false
  mattr_accessor :shadow, default: false

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      root: {
        base: "w-full text-left text-sm rtl:text-right text-gray-500 dark:text-gray-400",
        shadow: "absolute left-0 top-0 -z-10 h-full w-full rounded-lg bg-white drop-shadow-md dark:bg-black"
      },
      caption: "p-5 text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800",
      wrapper: {
        base: "overflow-x-auto relative",
        shadow: "shadow-md sm:rounded-lg"
      },
      head: {
        base: "text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400",
        cell: "px-6 py-3"
      },
      footer: {
        base: "text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400",
        cell: "px-6 py-3"
      },
      body: {
        base: "bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200"
      },
      row: {
        base: "",
        bordered: "border-b dark:border-gray-700 border-gray-200",
        hovered: {
          default: "hover:bg-gray-200 dark:hover:bg-gray-600",
          primary: "hover:bg-blue-200 dark:hover:bg-blue-700",
          secondary: "hover:bg-gray-200 dark:hover:bg-gray-700",
          success: "hover:bg-green-200 dark:hover:bg-green-700",
          danger: "hover:bg-red-200 dark:hover:bg-red-700",
          warning: "hover:bg-yellow-200 dark:hover:bg-yellow-700",
          info: "hover:bg-cyan-200 dark:hover:bg-cyan-700",
          light: "hover:bg-gray-300 dark:hover:bg-gray-700",
          dark: "hover:bg-gray-700 dark:hover:bg-gray-200"
        },
        striped: {
          default: "odd:bg-white even:bg-gray-50 odd:dark:bg-gray-900 even:dark:bg-gray-800",
          primary: "odd:bg-blue-50 even:bg-blue-100 odd:dark:bg-blue-900 even:dark:bg-blue-800",
          secondary: "odd:bg-gray-50 even:bg-gray-100 odd:dark:bg-gray-900 even:dark:bg-gray-800",
          success: "odd:bg-green-50 even:bg-green-100 odd:dark:bg-green-900 even:dark:bg-green-800",
          danger: "odd:bg-red-50 even:bg-red-100 odd:dark:bg-red-900 even:dark:bg-red-800",
          warning: "odd:bg-yellow-50 even:bg-yellow-100 odd:dark:bg-yellow-900 even:dark:bg-yellow-800",
          info: "odd:bg-cyan-50 even:bg-cyan-100 odd:dark:bg-cyan-900 even:dark:bg-cyan-800",
          light: "odd:bg-gray-100 even:bg-gray-200 odd:dark:bg-gray-700 even:dark:bg-gray-600",
          dark: "odd:bg-gray-800 even:bg-gray-900 odd:dark:bg-gray-200 even:dark:bg-gray-100"
        },
        colors: {
          default: "",
          primary: "bg-blue-50 dark:bg-blue-900",
          secondary: "bg-gray-50 dark:bg-gray-800",
          success: "bg-green-50 dark:bg-green-900",
          danger: "bg-red-50 dark:bg-red-900",
          warning: "bg-yellow-50 dark:bg-yellow-900",
          info: "bg-cyan-50 dark:bg-cyan-900",
          light: "bg-gray-100 dark:bg-gray-700",
          dark: "bg-gray-800 dark:bg-gray-200"
        },
        cell: {
          base: "px-6 py-2",
          selected: "font-medium text-gray-900 whitespace-nowrap dark:text-white"
        }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
