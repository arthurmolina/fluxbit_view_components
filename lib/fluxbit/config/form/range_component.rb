# frozen_string_literal: true

module Fluxbit::Config::Form::RangeComponent
  mattr_accessor :vertical, default: false
  mattr_accessor :sizing, default: 1

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "w-full bg-slate-200 rounded-lg appearance-none cursor-pointer dark:bg-slate-700",
      sizes: [ "h-1 range-sm", "h-2", "h-3 range-lg" ]
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
