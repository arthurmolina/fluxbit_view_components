# frozen_string_literal: true

module Fluxbit::Config::FlexComponent
  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :styles do
    {
      resolutions: [ :sm, :md, :lg, :xl, :'2xl' ],
      base: "flex",
      direction: {
        horizontal: "flex-row",
        vertical: "flex-col",
        horizontal_reverse: "flex-row-reverse",
        vertical_reverse: "flex-col-reverse"
      },
      justify_content: {
        start: "justify-start",
        end: "justify-end",
        center: "justify-center",
        baseline: "justify-baseline",
        stretch: "justify-stretch",
        space_around: "justify-around",
        space_between: "justify-between",
        space_evenly: "justify-evenly",
        normal: "justify-normal"
      },
      align_items: {
        start: "items-start",
        end: "items-end",
        center: "items-center",
        baseline: "items-baseline",
        stretch: "items-stretch"
      },
      wrap: {
        wrap: "flex-wrap",
        nowrap: "flex-nowrap",
        wrap_reverse: "flex-wrap-reverse"
      },
      gap: [ "gap-0", "gap-2", "gap-4", "gap-6", "gap-8", "gap-10", "gap-12", "gap-14", "gap-16", "gap-18", "gap-20" ],
      elements: [
        "sm:justify-start", "sm:justify-end", "sm:justify-center", "sm:justify-baseline", "sm:justify-stretch", "sm:justify-around", "sm:justify-between", "sm:justify-evenly", "sm:justify-normal",
        "sm:flex-row", "sm:flex-col", "sm:flex-row-reverse", "sm:flex-col-reverse", "sm:items-start", "sm:items-end", "sm:items-center", "sm:items-baseline", "sm:items-stretch", "sm:flex-wrap", "sm:flex-nowrap", "sm:flex-wrap-reverse",
        "sm:gap-0", "sm:gap-2", "sm:gap-4", "sm:gap-6", "sm:gap-8", "sm:gap-10", "sm:gap-12", "sm:gap-14", "sm:gap-16", "sm:gap-18", "sm:gap-20",

        "md:justify-start", "md:justify-end", "md:justify-center", "md:justify-baseline", "md:justify-stretch", "md:justify-around", "md:justify-between", "md:justify-evenly", "md:justify-normal",
        "md:flex-row", "md:flex-col", "md:flex-row-reverse", "md:flex-col-reverse", "md:items-start", "md:items-end", "md:items-center", "md:items-baseline", "md:items-stretch", "md:flex-wrap", "md:flex-nowrap", "md:flex-wrap-reverse",
        "md:gap-0", "md:gap-2", "md:gap-4", "md:gap-6", "md:gap-8", "md:gap-10", "md:gap-12", "md:gap-14", "md:gap-16", "md:gap-18", "md:gap-20",

        "lg:justify-start", "lg:justify-end", "lg:justify-center", "lg:justify-baseline", "lg:justify-stretch", "lg:justify-around", "lg:justify-between", "lg:justify-evenly", "lg:justify-normal",
        "lg:flex-row", "lg:flex-col", "lg:flex-row-reverse", "lg:flex-col-reverse", "lg:items-start", "lg:items-end", "lg:items-center", "lg:items-baseline", "lg:items-stretch", "lg:flex-wrap", "lg:flex-nowrap", "lg:flex-wrap-reverse",
        "lg:gap-0", "lg:gap-2", "lg:gap-4", "lg:gap-6", "lg:gap-8", "lg:gap-10", "lg:gap-12", "lg:gap-14", "lg:gap-16", "lg:gap-18", "lg:gap-20",

        "xl:justify-start", "xl:justify-end", "xl:justify-center", "xl:justify-baseline", "xl:justify-stretch", "xl:justify-around", "xl:justify-between", "xl:justify-evenly", "xl:justify-normal",
        "xl:flex-row", "xl:flex-col", "xl:flex-row-reverse", "xl:flex-col-reverse", "xl:items-start", "xl:items-end", "xl:items-center", "xl:items-baseline", "xl:items-stretch", "xl:flex-wrap", "xl:flex-nowrap", "xl:flex-wrap-reverse",
        "xl:gap-0", "xl:gap-2", "xl:gap-4", "xl:gap-6", "xl:gap-8", "xl:gap-10", "xl:gap-12", "xl:gap-14", "xl:gap-16", "xl:gap-18", "xl:gap-20",

        "2xl:justify-start", "2xl:justify-end", "2xl:justify-center", "2xl:justify-baseline", "2xl:justify-stretch", "2xl:justify-around", "2xl:justify-between", "2xl:justify-evenly", "2xl:justify-normal",
        "2xl:flex-row", "2xl:flex-col", "2xl:flex-row-reverse", "2xl:flex-col-reverse", "2xl:items-start", "2xl:items-end", "2xl:items-center", "2xl:items-baseline", "2xl:items-stretch", "2xl:flex-wrap", "2xl:flex-nowrap", "2xl:flex-wrap-reverse",
        "2xl:gap-0", "2xl:gap-2", "2xl:gap-4", "2xl:gap-6", "2xl:gap-8", "2xl:gap-10", "2xl:gap-12", "2xl:gap-14", "2xl:gap-16", "2xl:gap-18", "2xl:gap-20"
      ]
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
