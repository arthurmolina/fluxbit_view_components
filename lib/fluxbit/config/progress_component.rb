# frozen_string_literal: true

module Fluxbit::Config::ProgressComponent
  # Default values
  mattr_accessor :progress, default: 0
  mattr_accessor :color, default: :default
  mattr_accessor :size, default: 1
  mattr_accessor :text_label, default: nil
  mattr_accessor :label_progress, default: false
  mattr_accessor :label_text, default: false
  mattr_accessor :progress_label_position, default: :inside
  mattr_accessor :text_label_position, default: :outside
  mattr_accessor :label_html, default: {}
  mattr_accessor :stimulus, default: false

  # Styling system
  mattr_accessor :styles do
    {
      base: "w-full bg-gray-200 rounded-full dark:bg-gray-700",
      bar: {
        base: "h-full font-medium text-center leading-none rounded-full transition-all duration-300 ease-in-out flex items-center justify-center",
        colors: {
          default: "bg-blue-600 text-blue-100",
          dark: "bg-gray-600 text-gray-100",
          blue: "bg-blue-600 text-blue-100",
          red: "bg-red-600 text-red-100",
          green: "bg-green-600 text-green-100",
          yellow: "bg-yellow-400 text-yellow-800",
          indigo: "bg-indigo-600 text-indigo-100",
          purple: "bg-purple-600 text-purple-100",
          cyan: "bg-cyan-600 text-cyan-100",
          gray: "bg-gray-600 text-gray-100",
          lime: "bg-lime-600 text-lime-100",
          pink: "bg-pink-600 text-pink-100",
          teal: "bg-teal-600 text-teal-100"
        },
        text_sizes: [
          "text-xs px-1",  # size 0 - very small text, minimal padding
          "text-xs px-1",  # size 1 - small text, minimal padding
          "text-xs px-2",  # size 2 - normal text, normal padding
          "text-sm px-2"   # size 3 - larger text, normal padding
        ]
      },
      sizes: [
        "h-1.5",  # size 0 - sm
        "h-2.5",  # size 1 - md (default)
        "h-4",    # size 2 - lg
        "h-6"     # size 3 - xl
      ],
      labels: {
        outside: {
          base: "flex justify-between items-center mb-1",
          text: "text-base font-medium text-blue-700 dark:text-white",
          progress: "text-sm font-medium text-blue-700 dark:text-white"
        },
        inside: {
          text: "text-xs font-medium text-center",
          progress: "text-xs font-medium text-center"
        }
      }
    }
  end
end
