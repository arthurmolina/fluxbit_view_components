# frozen_string_literal: true

module Fluxbit::Config::TooltipComponent
  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "absolute z-10 invisible inline-block px-3 py-2 text-sm font-medium text-white transition-opacity duration-300 bg-gray-900 rounded-lg shadow-xs opacity-0 tooltip dark:bg-gray-700"
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
