# frozen_string_literal: true

module Fluxbit::Config::Form::DropzoneComponent
  mattr_accessor :icon, default: "heroicons_outline:cloud-arrow-up"
  mattr_accessor :height, default: 0

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      base: "flex items-center justify-center w-full",
      label: "flex flex-col items-center justify-center w-full border-2 border-slate-300 border-dashed rounded-lg cursor-pointer bg-slate-50 dark:hover:bg-bray-800 dark:bg-slate-700 hover:bg-slate-100 dark:border-slate-600 dark:hover:border-slate-500 dark:hover:bg-slate-600",
      inner_div: "flex flex-col items-center justify-center pt-5 pb-6",
      title: "mb-2 text-sm text-slate-500 dark:text-slate-400",
      subtitle: "text-xs text-slate-500 dark:text-slate-400",
      icon: "w-10 h-10 mb-4 text-slate-500 dark:text-slate-400",
      height: [ "", "h-32", "h-64", "h-96" ]
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
