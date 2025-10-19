# frozen_string_literal: true

module Fluxbit::Config::Form::PasswordComponent
  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      strength_wrapper: "mt-2 space-y-2",
      strength_bar_wrapper: "space-y-1",
      strength_bar_label: "text-sm font-medium text-slate-700 dark:text-slate-300",
      strength_bar_container: "w-full bg-slate-200 rounded-full h-2 dark:bg-slate-700",
      strength_bar: "h-2 rounded-full transition-all duration-300 bg-slate-300 dark:bg-slate-600",
      checks_list: "space-y-1",
      check_item: "flex items-center gap-2 text-sm text-slate-600 dark:text-slate-400",
      check_icon: "flex-shrink-0 text-red-500 dark:text-red-400",
      check_label: ""
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
