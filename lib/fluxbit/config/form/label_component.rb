# frozen_string_literal: true

module Fluxbit::Config::Form::LabelComponent
  mattr_accessor :color, default: :default
  mattr_accessor :helper_popover_icon, default: "heroicons_solid:question-mark-circle"
  mattr_accessor :helper_popover_icon_class, default: "size-4"
  mattr_accessor :sizing, default: 1
  mattr_accessor :helper_popover_placement, default: "right"

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "flex font-medium",
      colors: {
        default: "text-gray-900 dark:text-white",
        success: "text-green-700 dark:text-green-500",
        danger: "text-red-700 dark:text-red-500",
        info: "text-cyan-500 dark:text-cyan-600",
        warning: "text-yellow-500 dark:text-yellow-600"
      },
      sizes: [
        "text-sm",
        "text-md",
        "text-lg"
      ],
      required: "text-red-500 px-1 required",
      helper_popover: "px-2 text-slate-400"
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
