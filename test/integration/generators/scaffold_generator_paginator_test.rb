# frozen_string_literal: true

require_relative "../../../test_helper"
require "rails/generators/test_case"
require "generators/fluxbit/scaffold_generator"

class Fluxbit::ScaffoldGeneratorPaginatorTest < Rails::Generators::TestCase
  tests Fluxbit::ScaffoldGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  def test_paginator_true_includes_pagy_setup
    run_generator [ "Product", "name:string", "--paginator" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Should include Pagy configuration in index action
      assert_match(/Pagy::DEFAULT\[:limit\] = \(params\[:per_page\]\.presence \|\| 5\)\.to_i/, content)

      # Should include pagy pagination call
      assert_match(/@pagy, @products = pagy\(@products\)/, content)
    end
  end

  def test_paginator_false_removes_pagy_setup
    run_generator [ "Product", "name:string", "--no-paginator" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Should not include Pagy configuration
      assert_no_match(/Pagy::DEFAULT\[:limit\]/, content)

      # Should not include pagy pagination call
      assert_no_match(/@pagy, @products = pagy/, content)
    end
  end

  def test_paginator_true_includes_pagination_ui_elements
    run_generator [ "Product", "name:string", "--paginator" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # Should include per_page hidden input
      assert_match(/<input type="hidden" id="perPageParam" name="per_page"/, content)

      # Should include pagination component
      assert_match(/fx_pagination @pagy/, content)

      # Should include per_page selector
      assert_match(/fx_select id="perPage" name:"per_page"/, content)
      assert_match(/options_for_select\(\[/, content)
      assert_match(/count: 5.*count: 10.*count: 20/, content)

      # Should include pagination info
      assert_match(/pagination_info.*@pagy\.from.*@pagy\.to.*@pagy\.count/, content)

      # Should include per_page in filter reset links
      assert_match(/per_page: params\["per_page"\]/, content)
    end
  end

  def test_paginator_false_removes_pagination_ui_elements
    run_generator [ "Product", "name:string", "--no-paginator" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # Should not include per_page hidden input
      assert_no_match(/<input type="hidden" id="perPageParam"/, content)

      # Should not include pagination component
      assert_no_match(/fx_pagination @pagy/, content)

      # Should not include per_page selector
      assert_no_match(/fx_select id="perPage" name:"per_page"/, content)
      assert_no_match(/options_for_select/, content)

      # Should not include pagination info
      assert_no_match(/pagination_info/, content)
      assert_no_match(/@pagy\.from/, content)

      # Should not include per_page in filter reset links
      assert_no_match(/per_page:/, content)

      # Should not have pagination section wrapper
      assert_no_match(/card\.with_section.*pagination/, content)
    end
  end

  def test_default_paginator_option_is_true
    run_generator [ "Product", "name:string" ]

    # Default should include pagination
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/Pagy::DEFAULT\[:limit\]/, content)
      assert_match(/@pagy, @products = pagy/, content)
    end

    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/fx_pagination @pagy/, content)
      assert_match(/per_page/, content)
    end
  end

  def test_paginator_option_affects_filter_links
    run_generator [ "Product", "name:string", "category:string", "--paginator" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # Filter reset buttons should preserve per_page parameter
      assert_match(/href: products_path\(per_page: params\["per_page"\]\)/, content)
    end
  end

  def test_no_paginator_option_simplifies_filter_links
    run_generator [ "Product", "name:string", "category:string", "--no-paginator" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # Filter reset buttons should not include per_page parameter
      assert_match(/href: products_path\(\)/, content)
      assert_no_match(/per_page: params/, content)
    end
  end

  def test_paginator_with_search_and_filters
    run_generator [ "Product", "name:string", "price:decimal", "active:boolean", "--paginator" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Pagination should come after all filtering and sorting
      assert_match(/@products = @products\.order\(created_at: :desc\).*@pagy, @products = pagy\(@products\)/m, content)
    end

    assert_file "app/views/products/index.html.erb" do |content|
      # Search form should include per_page preservation
      assert_match(/perPageParam.*per_page.*params\["per_page"\]/, content)

      # Auto-submit forms should preserve pagination
      assert_match(/fx-auto-submit.*per_page/, content)
    end
  end

  def test_paginator_section_placement_in_view
    run_generator [ "Product", "name:string", "--paginator" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # Pagination section should be the last card section
      pagination_match = content.match(/card\.with_section.*?pagination_info.*?end # section/m)
      assert pagination_match, "Pagination section should exist"

      # Should be after the table section
      table_section_end = content.index("end #section", content.index("fx_table"))
      pagination_section_start = content.index("pagination_info")

      assert table_section_end < pagination_section_start, "Pagination should come after table section"
    end
  end

  private

  def prepare_destination
    super
  end
end
