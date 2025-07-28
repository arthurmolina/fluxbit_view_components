# frozen_string_literal: true

module Fluxbit::Config::Form::TextFieldComponent
  mattr_accessor :color, default: :default
  mattr_accessor :sizing, default: 0

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      default: "mt-1 block w-full border disabled:cursor-not-allowed disabled:opacity-50 disabled:text-slate-900 disabled:dark:text-slate-400 disabled:bg-slate-100 disabled:dark:bg-slate-700",
      text: {
        default: "text-slate-900 dark:text-white",
        success: "text-green-900",
        failure: "text-red-900",
        info: "text-cyan-900",
        warning: "text-yellow-900"
      },
      ring: {
        default: "focus:ring-blue-500 dark:focus:ring-blue-500",
        success: "focus:ring-green-500",
        failure: "focus:ring-red-500",
        info: "focus:ring-cyan-500",
        warning: "focus:ring-yellow-500"
      },
      bg: {
        default: "bg-slate-50 dark:bg-slate-700",
        success: "bg-green-50 dark:bg-green-100",
        failure: "bg-red-50 dark:bg-red-100",
        info: "bg-cyan-50 dark:bg-cyan-100",
        warning: "bg-yellow-50 dark:bg-yellow-100"
      },
      placeholder: {
        default: "dark:placeholder-slate-400",
        success: "placeholder-green-700",
        failure: "placeholder-red-700",
        info: "placeholder-cyan-700",
        warning: "placeholder-yellow-700"
      },
      border: {
        default: "border-slate-300 focus:border-blue-500 dark:border-slate-600 dark:focus:border-blue-500",
        success: "border-green-500 focus:border-green-500 dark:border-green-400",
        failure: "border-red-500 focus:border-red-500 dark:border-red-400",
        info: "border-cyan-500 focus:border-cyan-500 dark:border-cyan-400",
        warning: "border-yellow-500 focus:border-yellow-500 dark:border-yellow-400"
      },
      shadow: "shadow-xs dark:shadow-xs-light",
      icon: "pl-10",
      right_icon: "pr-10",
      sizing_md_addon: "p-2.5 rounded-none rounded-r-lg flex-1 min-w-0 text-sm",
      sizes: [
        "p-2.5 text-sm rounded-lg",
        "p-4 sm:text-md rounded-lg",
        "p-2 rounded-lg sm:text-xs"
      ],
      additional_icons: {
        class: {
          default: "mt-1 size-4 text-slate-500 dark:text-slate-400",
          success: "mt-1 size-4 text-green-500 dark:text-green-400",
          failure: "mt-1 size-4 text-red-500 dark:text-red-400",
          info: "mt-1 size-4 text-cyan-500 dark:text-cyan-400",
          warning: "mt-1 size-4 text-yellow-500 dark:text-yellow-400"
        },
        icon: "absolute inset-y-0 left-0 flex items-center pl-3",
        right_icon: "absolute inset-y-0 right-0 flex items-center pr-3",
        addon: {
          default: "mt-1 inline-flex items-center px-3 text-sm text-slate-900 bg-slate-200 border border-r-0 border-slate-300 rounded-l-md dark:bg-slate-600 dark:text-slate-400 dark:border-slate-600",
          success: "mt-1 inline-flex items-center px-3 text-sm text-green-900 bg-green-200 border border-r-0 border-green-300 rounded-l-md dark:bg-green-600 dark:text-green-400 dark:border-green-600",
          failure: "mt-1 inline-flex items-center px-3 text-sm text-red-900 bg-red-200 border border-r-0 border-red-300 rounded-l-md dark:bg-red-600 dark:text-red-400 dark:border-red-600",
          info: "mt-1 inline-flex items-center px-3 text-sm text-cyan-900 bg-cyan-200 border border-r-0 border-cyan-300 rounded-l-md dark:bg-cyan-600 dark:text-cyan-400 dark:border-cyan-600",
          warning: "mt-1 inline-flex items-center px-3 text-sm text-yellow-900 bg-yellow-200 border border-r-0 border-yellow-300 rounded-l-md dark:bg-yellow-600 dark:text-yellow-400 dark:border-yellow-600"
        }
      }
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
