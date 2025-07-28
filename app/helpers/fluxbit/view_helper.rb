# frozen_string_literal: true

module Fluxbit
  module ViewHelper
    def fx_body_class
      "h-full bg-slate-100 dark:bg-slate-900 dark:text-white"
    end

    def fx_sort_field(field, url, label = nil)
      order = (request.query_parameters[:order] || "").rpartition("_")

      order_direction = "asc"
      if order.first == field.to_s
        order_direction = order.last == "asc" ? "desc" : "asc"
      end

      link_to public_send(url, request.query_parameters.merge(order: "#{field}_#{order_direction}")), class: "order-#{order_direction} flex" do
        "#{label || field.to_s.titlecase} #{order.first == field.to_s ? (order_direction == 'asc' ? fx_sort_up : fx_sort_down) : fx_sort_up_down}".html_safe
      end
    end

    def fx_sort_up_down
      "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\" fill=\"currentColor\" class=\"size-4\">
      <path fill-rule=\"evenodd\"
      d=\"M11.47 4.72a.75.75 0 0 1 1.06 0l3.75 3.75a.75.75 0 0 1-1.06 1.06L12 6.31 8.78 9.53a.75.75 0 0 1-1.06-1.06l3.75-3.75Zm-3.75 9.75a.75.75 0 0 1 1.06 0L12 17.69l3.22-3.22a.75.75 0 1 1 1.06 1.06l-3.75 3.75a.75.75 0 0 1-1.06 0l-3.75-3.75a.75.75 0 0 1 0-1.06Z\"
      clip-rule=\"evenodd\" />
      </svg>"
    end

    def fx_sort_up
      "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\" fill=\"currentColor\" class=\"size-4\">
      <path fill-rule=\"evenodd\" d=\"M11.47 4.72a.75.75 0 0 1 1.06 0l3.75 3.75a.75.75 0 0 1-1.06 1.06L12 6.31 8.78 9.53a.75.75 0 0 1-1.06-1.06l3.75-3.75Z\" clip-rule=\"evenodd\" />
      </svg>"
    end

    def fx_sort_down
      "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\" fill=\"currentColor\" class=\"size-4\">
      <path fill-rule=\"evenodd\" d=\"M11.47 19.28a.75.75 0 0 1 1.06 0l3.75-3.75a.75.75 0 0 1-1.06-1.06L12 17.69l-3.22-3.22a.75.75 0 1 1-1.06 1.06l3.75 3.75Z\" clip-rule=\"evenodd\" />
      </svg>"
    end
  end
end
