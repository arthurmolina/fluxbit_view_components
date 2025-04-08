# frozen_string_literal: true

module Fluxbit::Config::CardComponent
  mattr_accessor :color, default: :info
  mattr_accessor :icon, default: :default
  mattr_accessor :can_close, default: true
  mattr_accessor :out_animation, default: :fade_out
  mattr_accessor :fade_in_animation, default: true
  mattr_accessor :dismiss_timeout, default: 3000
  mattr_accessor :all_rounded, default: true

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "flex rounded-lg border border-gray-200 bg-white shadow-md dark:border-gray-700 dark:bg-gray-800",
      children: "flex h-full flex-col justify-center gap-4 p-6",
      horizontal: {
        off: "flex-col",
        on: "flex-col md:max-w-xl md:flex-row"
      },
      href: "hover:bg-gray-100 dark:hover:bg-gray-700",
      img: {
        base: "",
        horizontal: {
          off: "rounded-t-lg",
          on: "h-96 w-full rounded-t-lg object-cover md:h-auto md:w-48 md:rounded-none md:rounded-l-lg"
        }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
