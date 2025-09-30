# frozen_string_literal: true

module Fluxbit::Config::TimelineComponent
  mattr_accessor :variant, default: :default
  mattr_accessor :position, default: :left

  mattr_accessor :styles do
    {
      base: "relative",
      variants: {
        default: "space-y-8 border-l border-gray-200 dark:border-gray-700",
        vertical: "space-y-6 border-l border-gray-200 dark:border-gray-700",
        stepper: "items-center sm:flex",
        activity: "space-y-4 border-l border-gray-200 dark:border-gray-700"
      },
      positions: {
        left: "ml-3",
        center: "",
        right: "mr-3"
      },
      item: {
        base: "relative flex items-start",
        indicator: {
          base: "absolute flex items-center justify-center w-6 h-6 -left-3 rounded-full bg-white dark:bg-gray-900",
          status: {
            default: "bg-blue-100 dark:bg-blue-900",
            completed: "bg-green-100 dark:bg-green-900",
            current: "bg-blue-600",
            pending: "bg-gray-100 dark:bg-gray-700"
          },
          colors: {
            blue: "text-blue-800 dark:text-blue-300",
            green: "text-green-800 dark:text-green-300",
            red: "text-red-800 dark:text-red-300",
            yellow: "text-yellow-800 dark:text-yellow-300",
            purple: "text-purple-800 dark:text-purple-300",
            indigo: "text-indigo-800 dark:text-indigo-300"
          },
          rings: {
            none: "",
            small: "ring-1 ring-white dark:ring-gray-900",
            default: "ring-2 ring-white dark:ring-gray-900",
            large: "ring-4 ring-white dark:ring-gray-900"
          }
        },
        content: {
          base: "ml-6 mb-8",
          title: "mb-1 text-lg font-semibold text-gray-900 dark:text-white",
          description: "mb-4 text-base font-normal text-gray-500 dark:text-gray-400",
          date: "inline-flex items-center px-2.5 py-0.5 text-xs font-medium text-blue-800 bg-blue-100 rounded dark:bg-blue-900 dark:text-blue-300"
        },
        icon: "w-3.5 h-3.5",
        dot: "w-2.5 h-2.5 bg-current rounded-full"
      },
      stepper: {
        item: "relative mb-6 sm:mb-0",
        indicator_container: "flex items-center",
        indicator: "z-10 flex items-center justify-center w-6 h-6 bg-blue-100 rounded-full dark:bg-blue-900 shrink-0",
        indicator_completed: "z-10 flex items-center justify-center w-6 h-6 bg-blue-600 rounded-full dark:bg-blue-900 shrink-0",
        connector: "hidden sm:flex w-full bg-gray-200 h-0.5 dark:bg-gray-700",
        content: "mt-3 sm:pe-8",
        title: "text-lg font-semibold text-gray-900 dark:text-white",
        description: "block mb-2 text-sm font-normal leading-none text-gray-400 dark:text-gray-500",
        description_paragraph: "text-base font-normal text-gray-500 dark:text-gray-400",
        icon: "w-2.5 h-2.5 text-blue-800 dark:text-blue-300",
        icon_completed: "w-2.5 h-2.5 text-white dark:text-blue-300"
      },
      activity: {
        base: "ml-6",
        time: "mb-1 text-sm font-normal leading-none text-gray-400 dark:text-gray-500",
        title: "text-lg font-semibold text-gray-900 dark:text-white",
        description: "mb-4 text-base font-normal text-gray-500 dark:text-gray-400",
        indicator: "absolute w-3 h-3 bg-gray-200 rounded-full mt-1.5 -left-1.5 border border-white dark:border-gray-900 dark:bg-gray-700"
      }
    }
  end
end
