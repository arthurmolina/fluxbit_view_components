# frozen_string_literal: true

module Fluxbit::Config::HeadingComponent
  mattr_accessor :size, default: 1
  mattr_accessor :spacing, default: :tight
  mattr_accessor :line_height, default: :none

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "mb-4 text-gray-900 dark:text-white",
      sizes: {
        h1: "text-5xl font-extrabold md:text-6xl lg:text-7xl",
        h2: "text-4xl font-bold md:text-5xl lg:text-6xl",
        h3: "text-3xl font-bold md:text-4xl lg:text-5xl",
        h4: "text-2xl font-bold md:text-3xl lg:text-4xl",
        h5: "text-xl font-bold md:text-2xl lg:text-3xl",
        h6: "text-lg font-bold md:text-xl lg:text-2xl"
      },
      spacings: {
        tighter: "tracking-tighter",
        tight: "tracking-tight",
        normal: "tracking-normal",
        wide: "tracking-wide",
        wider: "tracking-wider",
        widest: "tracking-widest"
    },
      line_heights: {
        none: "leading-none",
        tight: "leading-tight",
        snug: "leading-snug",
        normal: "leading-normal",
        relaxed: "leading-relaxed",
        loose: "leading-loose"
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
