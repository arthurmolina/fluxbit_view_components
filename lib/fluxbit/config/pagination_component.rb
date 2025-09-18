# frozen_string_literal: true

module Fluxbit::Config::PaginationComponent
  mattr_accessor :show_first_last, default: false
  mattr_accessor :show_prev_next, default: true
  mattr_accessor :show_pages, default: true
  mattr_accessor :show_icons, default: true
  mattr_accessor :show_texts, default: false
  mattr_accessor :sizing, default: 0

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      root: "inline-flex -space-x-px border-e-0 rounded-s-lg",
      page_link: "flex items-center justify-center px-3 h-8 leading-tight text-slate-500 bg-white border border-slate-300 hover:bg-slate-100 hover:text-slate-700 dark:bg-slate-800 dark:border-slate-700 dark:text-slate-400 dark:hover:bg-slate-700 dark:hover:text-white",
      previous: "ms-0 border-e-0 rounded-s-lg",
      next: "rounded-e-lg",
      disabled: "px-3 py-1 text-slate-400 cursor-default",
      current: "flex items-center justify-center px-3 h-8 leading-tight border border-slate-300 text-blue-600 bg-blue-50 hover:bg-blue-100 hover:text-blue-700 dark:bg-slate-700 dark:border-slate-700 dark:text-white",
      text_with_icon_prev: "ms-2",
      text_with_icon_next: "me-2",
      only_text: "",
      only_icon: "sr-only",
      sizes: [
        { root: "text-sm", page_link: "px-3 h-8" },
        { root: "text-base h-10", page_link: "px-4 h-10" }
      ]
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
