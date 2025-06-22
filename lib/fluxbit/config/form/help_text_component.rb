# frozen_string_literal: true

module Fluxbit::Config::Form::HelpTextComponent
  mattr_accessor :color, default: :default

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "text-sm ",
      colors: {
        default: "text-gray-500 dark:text-gray-400",
        success: "text-green-600 dark:text-green-500",
        failure: "text-red-600 dark:text-red-500",
        info: "text-cyan-600 dark:text-cyan-500",
        warning: "text-yellow-600 dark:text-yellow-500"
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
