# frozen_string_literal: true

module Fluxbit::Config::SpinnerComponent
  mattr_accessor :color, default: :default
  mattr_accessor :size, default: 1
  mattr_accessor :label, default: "Loading..."

  mattr_accessor :styles do
    {
      base: "animate-spin",
      sizes: [
        "w-4 h-4",      # 0 - xs
        "w-6 h-6",      # 1 - sm (default)
        "w-8 h-8",      # 2 - md
        "w-10 h-10",    # 3 - lg
        "w-12 h-12"     # 4 - xl
      ],
      colors: {
        default: "text-gray-200 fill-blue-600",
        info: "text-gray-200 fill-cyan-600",
        success: "text-gray-200 fill-green-500",
        failure: "text-gray-200 fill-red-600",
        warning: "text-gray-200 fill-yellow-400",
        pink: "text-gray-200 fill-pink-600",
        purple: "text-gray-200 fill-purple-600"
      },
      screen_reader: "sr-only"
    }
  end
end