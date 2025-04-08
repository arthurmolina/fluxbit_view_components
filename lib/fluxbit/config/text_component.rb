# frozen_string_literal: true

module Fluxbit::Config::TextComponent
  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      color: {
        blue: "text-blue-600 dark:text-blue-500",
        red: "text-red-600 dark:text-red-500",
        green: "text-green-600 dark:text-green-500",
        yellow: "text-yellow-600 dark:text-yellow-500",
        purple: "text-purple-600 dark:text-purple-500",
        pink: "text-pink-600 dark:text-pink-500",
        orange: "text-orange-600 dark:text-orange-500",
        teal: "text-teal-600 dark:text-teal-500",
        cyan: "text-cyan-600 dark:text-cyan-500",
        indigo: "text-indigo-600 dark:text-indigo-500",
        blue_to_green: "text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400",
        blue_to_purple: "text-transparent bg-clip-text bg-gradient-to-r from-blue-500 to-purple-500",
        red_to_yellow: "text-transparent bg-clip-text bg-gradient-to-r from-red-500 to-yellow-500",
        green_to_blue: "text-transparent bg-clip-text bg-gradient-to-r from-green-500 to-blue-500",
        purple_to_pink: "text-transparent bg-clip-text bg-gradient-to-r from-purple-500 to-pink-500",
        orange_to_red: "text-transparent bg-clip-text bg-gradient-to-r from-orange-500 to-red-500"
      },
      bg_color: {
        blue: "px-2 bg-blue-600 rounded-sm dark:bg-blue-500",
        red: "px-2 bg-red-600 rounded-sm dark:bg-red-500",
        green: "px-2 text-white bg-green-600 rounded-sm dark:bg-green-500",
        yellow: "px-2 text-white bg-yellow-600 rounded-sm dark:bg-yellow-500",
        purple: "px-2 text-white bg-purple-600 rounded-sm dark:bg-purple-500",
        pink: "px-2 text-white bg-pink-600 rounded-sm dark:bg-pink-500",
        orange: "px-2 text-white bg-orange-600 rounded-sm dark:bg-orange-500",
        teal: "px-2 text-white bg-teal-600 rounded-sm dark:bg-teal-500",
        cyan: "px-2 text-white bg-cyan-600 rounded-sm dark:bg-cyan-500",
        indigo: "px-2 text-white bg-indigo-600 rounded-sm dark:bg-indigo-500",
        blue_to_purple: "px-2 text-white bg-gradient-to-r from-blue-500 to-purple-500 rounded-sm",
        red_to_yellow: "px-2 text-white bg-gradient-to-r from-red-500 to-yellow-500 rounded-sm",
        green_to_blue: "px-2 text-white bg-gradient-to-r from-green-500 to-blue-500 rounded-sm",
        purple_to_pink: "px-2 text-white bg-gradient-to-r from-purple-500 to-pink-500 rounded-sm",
        orange_to_red: "px-2 text-white bg-gradient-to-r from-orange-500 to-red-500 rounded-sm"
      },
      size: {
        xs: "text-xs",
        sm: "text-sm",
        base: "text-base",
        lg: "text-lg",
        xl: "text-xl",
        "2xl": "text-2xl",
        "3xl": "text-3xl",
        "4xl": "text-4xl",
        "5xl": "text-5xl",
        "6xl": "text-6xl"
      },
      weight: {
        thin: "font-thin",
        extralight: "font-extralight",
        light: "font-light",
        normal: "font-normal",
        medium: "font-medium",
        semibold: "font-semibold",
        bold: "font-bold",
        extrabold: "font-extrabold",
        black: "font-black"
      },
      transform: {
        uppercase: "uppercase",
        lowercase: "lowercase",
        capitalize: "capitalize"
      },
      decoration_line: {
        underline: "underline",
        overline: "overline",
        line_through: "line-through"
      },
      decoration_type: {
        double: "decoration-double",
        dotted: "decoration-dotted",
        dashed: "decoration-dashed",
        wavy: "decoration-wavy"
      },
      decoration_color: {
        blue: "decoration-blue-400 dark:decoration-blue-600",
        red: "decoration-red-400 dark:decoration-red-600",
        green: "decoration-green-400 dark:decoration-green-600",
        yellow: "decoration-yellow-400 dark:decoration-yellow-600",
        purple: "decoration-purple-400 dark:decoration-purple-600",
        pink: "decoration-pink-400 dark:decoration-pink-600",
        orange: "decoration-orange-400 dark:decoration-orange-600",
        teal: "decoration-teal-400 dark:decoration-teal-600",
        cyan: "decoration-cyan-400 dark:decoration-cyan-600",
        indigo: "decoration-indigo-400 dark:decoration-indigo-600"
      },
      decoration_tickness: [
        "decoration-0",
        "decoration-1",
        "decoration-2",
        "decoration-4",
        "decoration-8"
      ],
      underline_offset: [
        "underline-offset-0",
        "underline-offset-1",
        "underline-offset-2",
        "underline-offset-4",
        "underline-offset-8"
      ]
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
