# frozen_string_literal: true

require_relative "../../../test_helper"
require "rails/generators/test_case"
require "generators/fluxbit/scaffold_generator"

class Fluxbit::ScaffoldGeneratorTest < Rails::Generators::TestCase
  tests Fluxbit::ScaffoldGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  def test_generator_creates_all_required_files
    run_generator [ "Product", "name:string", "price:decimal", "active:boolean" ]

    # Controller
    assert_file "app/controllers/products_controller.rb"

    # Views
    assert_file "app/views/products/index.html.erb"
    assert_file "app/views/products/show.html.erb"
    assert_file "app/views/products/new.html.erb"
    assert_file "app/views/products/edit.html.erb"
    assert_file "app/views/products/_form.html.erb"
    assert_file "app/views/products/_metadata.html.erb"
    assert_file "app/views/products/_products.html.erb"

    # Turbo Stream templates
    assert_file "app/views/products/create.turbo_stream.erb"
    assert_file "app/views/products/update.turbo_stream.erb"
    assert_file "app/views/products/update_all.turbo_stream.erb"
    assert_file "app/views/products/destroy.turbo_stream.erb"
    assert_file "app/views/products/destroy_all.turbo_stream.erb"

    # JSON templates
    assert_file "app/views/products/index.json.jbuilder"
    assert_file "app/views/products/show.json.jbuilder"

    # I18n files
    assert_file "config/locales/products.en.yml"
    assert_file "config/locales/products.pt-BR.yml"

    # Policy
    assert_file "app/policies/product_policy.rb"

    # Shared partials
    assert_file "app/views/shared/_alert.html.erb"
    assert_file "app/views/shared/_flash.html.erb"
  end

  def test_default_options_are_applied_correctly
    run_generator [ "Product", "name:string" ]

    # Check controller has pagination by default
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/Pagy::DEFAULT\[:limit\]/, content)
      assert_match(/@pagy, @products = pagy/, content)
    end

    # Check index view has pagination elements by default
    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/fx_pagination @pagy/, content)
      assert_match(/per_page/, content)
    end

    # Check turbo is enabled by default
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/format\.turbo_stream/, content)
    end

    # Check UI is set to modal by default
    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/turbo_frame: "modal"/, content)
    end

    # Check pundit is enabled by default
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/include Pundit::Authorization/, content)
      assert_match(/verify_authorized/, content)
    end
  end

  def test_paginator_false_removes_pagination
    run_generator [ "Product", "name:string", "--no-paginator" ]

    # Controller should not have pagination
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_no_match(/Pagy::DEFAULT\[:limit\]/, content)
      assert_no_match(/@pagy, @products = pagy/, content)
    end

    # Index view should not have pagination elements
    assert_file "app/views/products/index.html.erb" do |content|
      assert_no_match(/fx_pagination @pagy/, content)
      assert_no_match(/per_page/, content)
    end
  end

  def test_ui_option_drawer_generates_drawer_interface
    run_generator [ "Product", "name:string", "--ui=drawer" ]

    # Index should have drawer frame
    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/turbo-frame id="drawer"/, content)
      assert_match(/turbo_frame: "drawer"/, content)
    end

    # New view should have drawer
    assert_file "app/views/products/new.html.erb" do |content|
      assert_match(/fx_drawer\(id: "new-drawer"/, content)
      assert_match(/showDrawer:new-drawer/, content)
    end

    # Edit view should have drawer
    assert_file "app/views/products/edit.html.erb" do |content|
      assert_match(/fx_drawer\(id: "edit-drawer"/, content)
      assert_match(/showDrawer:edit-drawer/, content)
    end

    # Partial should reference drawer frame
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_match(/fx_row_click_frame_value: "drawer"/, content)
    end
  end

  def test_ui_option_modal_generates_modal_interface
    run_generator [ "Product", "name:string", "--ui=modal" ]

    # Index should have modal frame
    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/turbo-frame id="modal"/, content)
      assert_match(/turbo_frame: "modal"/, content)
    end

    # New view should have modal
    assert_file "app/views/products/new.html.erb" do |content|
      assert_match(/fx_modal\(id: "new-modal"/, content)
      assert_match(/showModal:new-modal/, content)
    end

    # Edit view should have modal
    assert_file "app/views/products/edit.html.erb" do |content|
      assert_match(/fx_modal\(id: "edit-modal"/, content)
      assert_match(/showModal:edit-modal/, content)
    end

    # Partial should reference modal frame
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_match(/fx_row_click_frame_value: "modal"/, content)
    end
  end

  def test_ui_option_none_generates_standard_interface
    run_generator [ "Product", "name:string", "--ui=none" ]

    # Index should not have turbo frames
    assert_file "app/views/products/index.html.erb" do |content|
      assert_no_match(/turbo-frame/, content)
      assert_no_match(/turbo_frame:/, content)
    end

    # New view should only have standard layout
    assert_file "app/views/products/new.html.erb" do |content|
      assert_match(/fx_heading/, content)
      assert_match(/fx_card/, content)
      assert_no_match(/fx_drawer/, content)
      assert_no_match(/fx_modal/, content)
    end

    # Partial should not have row click behavior
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_no_match(/fx-row-click/, content)
      assert_no_match(/fx_row_click_frame_value/, content)
    end
  end

  def test_turbo_false_removes_turbo_functionality
    run_generator [ "Product", "name:string", "--no-turbo" ]

    # Controller should not have turbo_stream responses
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_no_match(/format\.turbo_stream/, content)
    end

    # Views should not have turbo frames
    assert_file "app/views/products/index.html.erb" do |content|
      assert_no_match(/turbo-frame/, content)
    end

    assert_file "app/views/products/new.html.erb" do |content|
      assert_no_match(/turbo-frame/, content)
      assert_no_match(/turbo_frame_request/, content)
    end

    # Partial should not have turbo behavior
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_no_match(/fx-row-click/, content)
    end
  end

  def test_pundit_false_removes_authorization
    run_generator [ "Product", "name:string", "--no-pundit" ]

    # Controller should not include Pundit
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_no_match(/include Pundit::Authorization/, content)
      assert_no_match(/verify_authorized/, content)
      assert_no_match(/verify_policy_scoped/, content)
    end
  end

  def test_combined_options_work_together
    run_generator [ "Product", "name:string", "price:decimal", "--no-paginator", "--ui=drawer", "--no-turbo", "--no-pundit" ]

    # Should not have pagination
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_no_match(/Pagy::DEFAULT/, content)
      assert_no_match(/@pagy/, content)
    end

    # Should not have turbo but should still have drawer layout structure
    assert_file "app/views/products/new.html.erb" do |content|
      assert_match(/fx_heading/, content) # Standard layout
      assert_no_match(/turbo-frame/, content) # No turbo frames
      assert_no_match(/fx_drawer/, content) # No drawer since no turbo
    end

    # Should not have pundit
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_no_match(/Pundit/, content)
    end
  end

  def test_attributes_are_processed_correctly
    run_generator [ "Product", "name:string", "price:decimal", "active:boolean", "description:text", "category:references" ]

    # Controller should have proper params
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/:name, :price, :active, :description, :category_id/, content)
    end

    # Index view should handle different field types
    assert_file "app/views/products/index.html.erb" do |content|
      # Should have filters for string and text fields
      assert_match(/filter_name/, content)
      assert_match(/filter_description/, content)
      # Should have filters for numeric fields
      assert_match(/filter_price/, content)
    end

    # Partial should handle boolean display
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_match(/check-circle.*x-circle/, content) # Boolean field rendering
      assert_match(/active\?/, content)
    end

    # CSV generation should handle different types
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/strftime.*datetime/, content) # Date formatting
      assert_match(/I18n\.t.*boolean/, content) # Boolean formatting
    end
  end

  def test_routes_are_added_correctly
    run_generator [ "Product", "name:string" ]

    assert_file "config/routes.rb" do |content|
      assert_match(/resources :products do/, content)
      assert_match(/collection do/, content)
      assert_match(/put "update_all"/, content)
      assert_match(/patch "update_all"/, content)
      assert_match(/delete "destroy_all"/, content)
    end
  end

  def test_i18n_files_have_correct_structure
    run_generator [ "Product", "name:string", "price:decimal" ]

    assert_file "config/locales/products.en.yml" do |content|
      assert_match(/en:/, content)
      assert_match(/products:/, content)
      assert_match(/titles:/, content)
      assert_match(/fields:/, content)
      assert_match(/actions:/, content)
      assert_match(/messages:/, content)
      assert_match(/name:/, content)
      assert_match(/price:/, content)
    end

    assert_file "config/locales/products.pt-BR.yml" do |content|
      assert_match(/pt-BR:/, content)
      assert_match(/products:/, content)
    end
  end

  def test_policy_file_is_generated_correctly
    run_generator [ "Product", "name:string" ]

    assert_file "app/policies/product_policy.rb" do |content|
      assert_match(/class ProductPolicy < ApplicationPolicy/, content)
      assert_match(/def index\?/, content)
      assert_match(/def show\?/, content)
      assert_match(/def create\?/, content)
      assert_match(/def update\?/, content)
      assert_match(/def destroy\?/, content)
    end
  end

  private

  def prepare_destination
    super
    # Ensure routes file exists for route testing
    routes_file = File.join(destination_root, "config", "routes.rb")
    FileUtils.mkdir_p(File.dirname(routes_file))
    File.write(routes_file, "Rails.application.routes.draw do\nend\n") unless File.exist?(routes_file)
  end
end
