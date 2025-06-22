# frozen_string_literal: true

require "test_helper"

class Fluxbit::ClassesHelperTest < ActionView::TestCase
  include Fluxbit::ClassesHelper

  def test_fx_body_class
    expected_class = "h-full bg-slate-100 dark:bg-slate-900 dark:text-white"
    assert_equal expected_class, fx_body_class
  end

  # def test_fx_darkmode_js
  #   expected_script = <<-SCRIPT.squish
  #     <script>
  #       if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
  #           document.documentElement.classList.add('dark');
  #       } else {
  #           document.documentElement.classList.remove('dark')
  #       }
  #     </script>
  #   SCRIPT

  #   assert_equal expected_script, fx_darkmode_js
  # end
end
