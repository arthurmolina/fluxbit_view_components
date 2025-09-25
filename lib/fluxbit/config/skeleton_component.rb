# frozen_string_literal: true

module Fluxbit::Config::SkeletonComponent
  mattr_accessor :variant, default: :default
  mattr_accessor :animation, default: true
  mattr_accessor :rows, default: 3

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "animate-pulse",
      container: "w-full",
      text: {
        line: "h-2.5 bg-gray-200 rounded-full dark:bg-gray-700",
        small: "h-2 bg-gray-200 rounded-full dark:bg-gray-700",
        large: "h-3 bg-gray-200 rounded-full dark:bg-gray-700"
      },
      avatar: {
        small: "w-8 h-8 bg-gray-200 rounded-full dark:bg-gray-700",
        medium: "w-10 h-10 bg-gray-200 rounded-full dark:bg-gray-700",
        large: "w-14 h-14 bg-gray-200 rounded-full dark:bg-gray-700"
      },
      image: {
        small: "h-32 bg-gray-300 rounded dark:bg-gray-700",
        medium: "h-48 bg-gray-300 rounded dark:bg-gray-700",
        large: "h-64 bg-gray-300 rounded dark:bg-gray-700"
      },
      video: {
        small: "h-32 bg-gray-300 rounded dark:bg-gray-700",
        medium: "h-48 bg-gray-300 rounded dark:bg-gray-700",
        large: "h-64 bg-gray-300 rounded dark:bg-gray-700"
      },
      button: "h-8 bg-gray-200 rounded dark:bg-gray-700 w-20",
      card: {
        container: "p-4 border border-gray-200 rounded shadow dark:border-gray-700",
        header: "h-4 bg-gray-200 rounded-full dark:bg-gray-700",
        body: "h-2 bg-gray-200 rounded-full dark:bg-gray-700"
      },
      widget: {
        container: "p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700",
        title: "h-4 bg-gray-200 rounded-full dark:bg-gray-700 mb-4",
        content: "h-2 bg-gray-200 rounded-full dark:bg-gray-700"
      },
      list: {
        container: "space-y-3",
        item: "flex items-center space-x-4",
        avatar: "w-10 h-10 bg-gray-200 rounded-full dark:bg-gray-700",
        content: "flex-1 space-y-2"
      },
      testimonial: {
        container: "p-4",
        quote: "h-2 bg-gray-200 rounded-full dark:bg-gray-700",
        author: "flex items-center mt-4 space-x-3"
      },
      spacing: {
        none: "",
        small: "mb-2.5",
        medium: "mb-4",
        large: "mb-6"
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end