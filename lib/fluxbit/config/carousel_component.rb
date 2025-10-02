# frozen_string_literal: true

module Fluxbit::Config::CarouselComponent
  mattr_accessor :slide, default: true
  mattr_accessor :slide_interval, default: 3000
  mattr_accessor :indicators, default: true
  mattr_accessor :controls, default: true

  # rubocop:disable Layout/LineLength
  mattr_accessor :styles do
    {
      base: "relative w-full",
      slides_container: "relative h-56 overflow-hidden rounded-lg md:h-96",
      slide: {
        base: "duration-700 ease-in-out",
        inactive: "hidden"
      },
      indicators: {
        container: "absolute z-30 flex -translate-x-1/2 bottom-5 left-1/2 space-x-3 rtl:space-x-reverse",
        button: "w-3 h-3 rounded-full bg-white/50 hover:bg-white dark:bg-gray-800/50 dark:hover:bg-gray-800"
      },
      controls: {
        button: "absolute top-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none",
        previous: "start-0",
        next: "end-0",
        icon_wrapper: "inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none",
        icon: "w-4 h-4 text-white dark:text-gray-800 rtl:rotate-180",
        sr_only: "sr-only"
      }
    }
  end
  # rubocop:enable Layout/LineLength
end
