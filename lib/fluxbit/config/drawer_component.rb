# frozen_string_literal: true

module Fluxbit::Config::DrawerComponent
  mattr_accessor :placement, default: :left
  mattr_accessor :sizing, default: :sm
  mattr_accessor :show_close_button, default: true
  mattr_accessor :swipeable, default: false
  mattr_accessor :shadow, default: true
  mattr_accessor :backdrop, default: true
  mattr_accessor :auto_show, default: false
  mattr_accessor :body_scrolling, default: false

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      root: "fixed z-40 p-4",
      color: "bg-white dark:bg-gray-800",
      shadow: "shadow-lg dark:shadow-gray-900/50",
      placements: {
        left: "top-0 left-0 h-screen overflow-y-auto transition-transform -translate-x-full",
        right: "top-0 right-0 h-screen overflow-y-auto transition-transform translate-x-full",
        top: "top-0 left-0 right-0 w-full transition-transform -translate-y-full",
        bottom: "bottom-0 left-0 right-0 w-full overflow-y-auto transition-transform transform-none"
      },
      sizes: {
        horizontal: {
          sm: "w-64",
          md: "w-80",
          lg: "w-96",
          xl: "w-128",
          full: "w-full"
        },
        vertical: {
          sm: "h-64",
          md: "h-80",
          lg: "h-96",
          xl: "h-128",
          full: "h-full"
        }
      },
      swipeable: {
        default: "border-t border-gray-200 rounded-t-lg dark:border-gray-700 translate-y-full bottom-[-60px]",
        swipe: "bottom-[60px]"
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
