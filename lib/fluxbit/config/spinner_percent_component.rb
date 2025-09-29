# frozen_string_literal: true

module Fluxbit::Config::SpinnerPercentComponent
  mattr_accessor :color, default: :default
  mattr_accessor :size, default: 1
  mattr_accessor :percent, default: 10
  mattr_accessor :label, default: "Loading..."
  mattr_accessor :show_percent, default: true
  mattr_accessor :text, default: nil
  mattr_accessor :animate, default: false
  mattr_accessor :speed, default: :normal

  mattr_accessor :styles do
    {
      base: "relative",
      sizes: {
        -1 => "w-12 h-12",    # -1 - xxs
        0 => "w-16 h-16",     # 0 - xs
        1 => "w-20 h-20",     # 1 - sm (default)
        2 => "w-24 h-24",     # 2 - md
        3 => "w-32 h-32",     # 3 - lg
        4 => "w-40 h-40"      # 4 - xl
      },
      colors: {
        default: "text-gray-200 stroke-blue-600",
        info: "text-gray-200 stroke-cyan-600",
        success: "text-gray-200 stroke-green-500",
        failure: "text-gray-200 stroke-red-600",
        warning: "text-gray-200 stroke-yellow-400",
        pink: "text-gray-200 stroke-pink-600",
        purple: "text-gray-200 stroke-purple-600"
      },
      screen_reader: "sr-only",
      text_colors: {
        default: "text-blue-600",
        info: "text-cyan-600",
        success: "text-green-500",
        failure: "text-red-600",
        warning: "text-yellow-400",
        pink: "text-pink-600",
        purple: "text-purple-600"
      },
      animation: "animate-spin",
      speeds: {
        slow: "animate-spin duration-[3s]",      # 3 seconds per rotation
        normal: "animate-spin duration-1000",    # 1 second per rotation (default)
        fast: "animate-spin duration-500",       # 0.5 seconds per rotation
        very_fast: "animate-spin duration-300"   # 0.3 seconds per rotation
      }
    }
  end
end
