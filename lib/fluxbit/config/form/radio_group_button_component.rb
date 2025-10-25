# frozen_string_literal: true

module Fluxbit::Config::Form::RadioGroupButtonComponent
  mattr_accessor :color, default: :default
  mattr_accessor :size, default: 1

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      group: "inline-flex rounded-md shadow-xs",
      input: "sr-only peer",
      label: {
        base: "group flex items-center justify-center text-center font-medium relative focus:z-10 focus:outline-hidden cursor-pointer",
        selected: "brightness-90 dark:brightness-75",
        position: {
          start: "rounded-r-none",
          middle: "rounded-none",
          end: "rounded-l-none"
        }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
