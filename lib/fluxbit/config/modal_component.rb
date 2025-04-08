# frozen_string_literal: true

module Fluxbit::Config::ModalComponent
  mattr_accessor :opened, default: false
  mattr_accessor :close_button, default: true
  mattr_accessor :flat, default: false
  mattr_accessor :size, default: 1
  mattr_accessor :only_css, default: false
  mattr_accessor :static, default: false
  mattr_accessor :placement, default: nil

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      root: {
        base: "fixed inset-x-0 top-0 z-50 h-screen overflow-y-auto overflow-x-hidden md:inset-0 md:h-full flex",
        backdrop: "bg-gray-900/50 dark:bg-gray-900/80",
        show: {
          on: "",
          off: "hidden"
        },
        size: [
          "max-w-sm",
          "max-w-md",
          "max-w-lg",
          "max-w-xl",
          "max-w-2xl",
          "max-w-3xl",
          "max-w-4xl",
          "max-w-5xl",
          "max-w-6xl",
          "max-w-7xl"
        ],
        placements: {
          "top-left": "items-start justify-start",
          "top-center": "items-start justify-center",
          "top-right": "items-start justify-end",
          "center-left": "items-center justify-start",
          "center": "items-center justify-center",
          "center-right": "items-center justify-end",
          "bottom-right": "items-end justify-end",
          "bottom-center": "items-end justify-center",
          "bottom-left": "items-end justify-start"
        }
      },
      content: {
        base: "relative h-full w-full p-4 md:h-auto",
        inner: "relative flex max-h-[90dvh] flex-col rounded-lg bg-white shadow-sm dark:bg-gray-700"
      },
      body: {
        base: "flex-1 overflow-auto p-6",
        flat: "pt-0",
        no_title: "-mt-4"
      },
      header: {
        base: "flex items-start justify-between rounded-t border-b p-5 dark:border-gray-600",
        flat: "border-b-0 p-2",
        title: "text-xl font-medium text-gray-900 dark:text-white",
        close: {
          base: "close-button ml-auto inline-flex items-center rounded-lg bg-transparent p-1.5 text-sm text-gray-400 hover:bg-gray-200 hover:text-gray-900 dark:hover:bg-gray-600 dark:hover:text-white",
          icon: "h-5 w-5"
        }
      },
      footer: {
        base: "flex items-center space-x-2 rounded-b border-t border-gray-200 p-6 dark:border-gray-600",
        flat: "border-t-0"
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
