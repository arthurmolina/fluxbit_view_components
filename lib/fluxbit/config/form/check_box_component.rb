# frozen_string_literal: true

module Fluxbit::Config::Form::CheckBoxComponent
  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      checkbox: "rounded-sm",
      base: "size-4 text-blue-600 bg-slate-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-slate-700 dark:border-slate-600",
      label: {
        with_helper: "font-medium text-slate-900 dark:text-slate-300",
        base: "ml-2 text-sm font-medium text-slate-900 dark:text-slate-300"
      },
      input_div: "flex items-center h-5",
      helper_div: "ml-2 text-sm",
      no_helper_div: "flex items-center"
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
