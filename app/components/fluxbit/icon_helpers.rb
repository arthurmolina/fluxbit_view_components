# frozen_string_literal: true

module Fluxbit
  module IconHelpers
    def chevron_right(**props)
      add to: props, class: "w-2.5 h-2.5", first_element: true
      remove_class_from_props(props)
      props["aria-hidden"] = "true"
      props[:xmlns] = "http://www.w3.org/2000/svg"
      props[:fill] = "none"
      props[:viewBox] = "0 0 6 10"
      stroke_width = props.delete(:stroke_width) || 2

      tag.svg(**props) do
        tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => stroke_width, d: "m1 9 4-4-4-4")
      end
    end

    def chevron_left(**props)
      add to: props, class: "w-2.5 h-2.5", first_element: true
      remove_class_from_props(props)
      props["aria-hidden"] = "true"
      props[:xmlns] = "http://www.w3.org/2000/svg"
      props[:fill] = "none"
      props[:viewBox] = "0 0 6 10"
      stroke_width = props.delete(:stroke_width) || 2

      tag.svg(**props) do
        tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => stroke_width, d: "m5 1-4 4 4 4")
      end
    end

    def chevron_up(**props)
      add to: props, class: "w-2.5 h-2.5", first_element: true
      remove_class_from_props(props)
      props["aria-hidden"] = "true"
      props[:xmlns] = "http://www.w3.org/2000/svg"
      props[:fill] = "none"
      props[:viewBox] = "0 0 10 6"
      stroke_width = props.delete(:stroke_width) || 2

      tag.svg(**props) do
        tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => stroke_width, d: "m1 5 4-4 4 4")
      end
    end

    def chevron_down(**props)
      add to: props, class: "w-2.5 h-2.5", first_element: true
      remove_class_from_props(props)
      props["aria-hidden"] = "true"
      props[:xmlns] = "http://www.w3.org/2000/svg"
      props[:fill] = "none"
      props[:viewBox] = "0 0 10 6"
      stroke_width = props.delete(:stroke_width) || 2

      tag.svg(**props) do
        tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => stroke_width, d: "m1 1 4 4 4-4")
      end
    end

    def close_icon(**props)
      props["aria-hidden"] = "true"
      props[:xmlns] = "http://www.w3.org/2000/svg"
      props[:fill] = "none"
      props[:viewBox] = "0 0 14 14"

      tag.svg(**props) do
        tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => 2, d: "m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6")
      end
    end

    def plus_icon(**props)
      props["aria-hidden"] = "true"
      props[:xmlns] = "http://www.w3.org/2000/svg"
      props[:fill] = "currentColor"
      props[:viewBox] = "0 0 24 24"

      tag.svg(**props) do
        tag.path("fill-rule" => "evenodd", d: "M12 3.75a.75.75 0 0 1 .75.75v6.75h6.75a.75.75 0 0 1 0 1.5h-6.75v6.75a.75.75 0 0 1-1.5 0v-6.75H4.5a.75.75 0 0 1 0-1.5h6.75V4.5a.75.75 0 0 1 .75-.75Z", "clip-rule" => "evenodd")
      end
    end

    def chevron_double_left(**props)
      add to: props, class: "w-3 h-2.5", first_element: true
      remove_class_from_props(props)
      props["aria-hidden"] = "true"
      props[:xmlns] = "http://www.w3.org/2000/svg"
      props[:fill] = "none"
      props[:viewBox] = "0 0 10 10"
      stroke_width = props.delete(:stroke_width) || 2

      tag.svg(**props) do
        safe_join [
          tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => stroke_width, d: "M4 1l-4 4 4 4"),
          tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => stroke_width, d: "M10 1l-4 4 4 4")
        ]
      end
    end

    def chevron_double_right(**props)
      add to: props, class: "w-3 h-2.5", first_element: true
      remove_class_from_props(props)
      props["aria-hidden"] = "true"
      props[:xmlns] = "http://www.w3.org/2000/svg"
      props[:fill] = "none"
      props[:viewBox] = "0 0 12 10"
      stroke_width = props.delete(:stroke_width) || 2

      tag.svg(**props) do
        safe_join [
          tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => stroke_width, d: "M2 1l4 4-4 4"),
          tag.path(stroke: "currentColor", "stroke-linecap" => "round", "stroke-linejoin" => "round", "stroke-width" => stroke_width, d: "M8 1l4 4-4 4")
        ]
      end
    end

    def ellipsis_horizontal(**props)
      add to: props, class: "w-2.5 h-2.5", first_element: true
      remove_class_from_props(props)
      props["aria-hidden"] = "true"
      props[:xmlns] = "http://www.w3.org/2000/svg"
      props[:fill] = "currentColor"
      props[:viewBox] = "0 0 10 2"

      tag.svg(**props) do
        safe_join [
          tag.circle(cx: 1, cy: 1, r: 1),
          tag.circle(cx: 5, cy: 1, r: 1),
          tag.circle(cx: 9, cy: 1, r: 1)
        ]
      end
    end
  end
end
