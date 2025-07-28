# frozen_string_literal: true

module Fluxbit::Config::AvatarComponent
  mattr_accessor :color, default: nil
  mattr_accessor :placeholder_initials, default: false
  mattr_accessor :status, default: false # online, busy, offline, away
  mattr_accessor :status_position, default: :top_right
  mattr_accessor :rounded, default: true
  mattr_accessor :size, default: :md

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      bordered: "p-1 ring-2",
      rounded: {
        base: "rounded-full",
        status_position: {
          top: "top-0",
          bottom: "bottom-0",
          left: { xs: "-left-1", sm: "left-0", md: "left-1", lg: "left-1", xl: "left-6" },
          right: { xs: "left-4", sm: "left-5", md: "left-7", lg: "left-12", xl: "left-24" }
        }
      },
      not_rounded: {
        base: "rounded-sm",
        status_position: {
          top: "-top-1",
          bottom: "-bottom-1",
          left: { xs: "-left-1", sm: "-left-1", md: "-left-1", lg: "-left-1", xl: "-left-1" },
          right: { xs: "left-4", sm: "left-5", md: "left-7", lg: "left-18", xl: "left-32" }
        }
      },
      color: {
        dark: "ring-gray-800 dark:ring-gray-800",
        failure: "ring-red-500 dark:ring-red-700",
        gray: "ring-gray-500 dark:ring-gray-400",
        info: "ring-cyan-400 dark:ring-cyan-800",
        light: "ring-gray-300 dark:ring-gray-500",
        purple: "ring-purple-500 dark:ring-purple-600",
        success: "ring-green-500 dark:ring-green-500",
        warning: "ring-yellow-300 dark:ring-yellow-500",
        pink: "ring-pink-500 dark:ring-pink-500"
      },
      size: {
        xs: "size-6",
        sm: "size-8",
        md: "size-10",
        lg: "size-20",
        xl: "size-36"
      },
      placeholder_icon: {
        base: "relative overflow-hidden bg-gray-200 dark:bg-gray-600",
        size: {
          xs: "size-8",
          sm: "size-10",
          md: "size-12",
          lg: "size-22",
          xl: "size-38"
        }
      },
      stacked: "ring-2 ring-gray-300 dark:ring-gray-500",
      status: {
        base: "absolute h-3.5 w-3.5 rounded-full border-2 border-white dark:border-gray-800",
        options: {
          away: "bg-yellow-400",
          busy: "bg-red-400",
          offline: "bg-gray-400",
          online: "bg-green-400"
        }
      },
      initials: {
        text: "font-medium text-gray-600 dark:text-gray-300",
        base: "inline-flex overflow-hidden relative justify-center items-center bg-gray-200 dark:bg-gray-600"
      },
      group: "flex -space-x-4 rtl:space-x-reverse"
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
