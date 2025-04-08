# frozen_string_literal: true

module Fluxbit
  module ClassesHelper
    def fx_body_class
      "h-full bg-slate-100 dark:bg-slate-900 dark:text-white"
    end

    def fx_darkmode_js
      <<-SCRIPT.squish
        <script>
          if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
              document.documentElement.classList.add('dark');
          } else {
              document.documentElement.classList.remove('dark')
          }
        </script>
      SCRIPT
    end
  end
end
