# frozen_string_literal: true

module Fluxbit::Config::ParagraphComponent
  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "mb-3 text-gray-500 dark:text-gray-400"
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
