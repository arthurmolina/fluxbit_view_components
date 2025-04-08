# frozen_string_literal: true

module Fluxbit::Config::PopoverComponent
  mattr_accessor :has_arrow, default: true
  mattr_accessor :image_position, default: :right
  mattr_accessor :image_props, default: {}
  mattr_accessor :size, default: 2

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "absolute z-10 invisible inline-block text-sm text-gray-500 transition-opacity duration-300 bg-white border border-gray-200 rounded-lg shadow-xs opacity-0 dark:text-gray-400 dark:border-gray-600 dark:bg-gray-800",
      size: [
        "w-24",
        "w-32",
        "w-48",
        "w-64",
        "w-96"
      ],
      title: {
        div: "px-3 py-2 bg-gray-100 border-b border-gray-200 rounded-t-lg dark:border-gray-600 dark:bg-gray-700",
        h3: "font-semibold text-gray-900 dark:text-white"
      },
      content: "px-3 py-2",
      image_base: "grid grid-cols-5",
      image_content: {
        text: "col-span-3 p-3 space-y-2",
        image: "h-full col-span-2"
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
