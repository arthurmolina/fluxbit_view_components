# frozen_string_literal: true

require_relative "../../../test_helper"
require "rails/generators/test_case"
require "generators/fluxbit/scaffold_generator"

class Fluxbit::ScaffoldGeneratorPunditTest < Rails::Generators::TestCase
  tests Fluxbit::ScaffoldGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  def test_pundit_true_includes_authorization_setup
    run_generator [ "Product", "name:string", "--pundit" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Should include Pundit module
      assert_match(/include Pundit::Authorization/, content)

      # Should rescue from NotAuthorizedError
      assert_match(/rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized/, content)

      # Should have after_action verifications
      assert_match(/after_action :verify_authorized, except: :index/, content)
      assert_match(/after_action :verify_policy_scoped, only: :index/, content)
    end
  end

  def test_pundit_false_removes_authorization_setup
    run_generator [ "Product", "name:string", "--no-pundit" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Should not include Pundit module
      assert_no_match(/include Pundit::Authorization/, content)

      # Should not rescue from NotAuthorizedError
      assert_no_match(/rescue_from Pundit::NotAuthorizedError/, content)

      # Should not have after_action verifications
      assert_no_match(/after_action :verify_authorized/, content)
      assert_no_match(/after_action :verify_policy_scoped/, content)
    end
  end

  def test_pundit_true_includes_authorization_calls_in_actions
    run_generator [ "Product", "name:string", "--pundit" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Index action should use policy_scope
      index_action = content.match(/def index.*?end/m)[0]
      assert_match(/policy_scope\(Product\)\.all/, index_action)

      # Show action should authorize
      show_action = content.match(/def show.*?end/m)[0]
      assert_match(/authorize @product/, show_action)

      # New action should authorize
      new_action = content.match(/def new.*?end/m)[0]
      assert_match(/authorize @product/, new_action)

      # Edit action should authorize
      edit_action = content.match(/def edit.*?end/m)[0]
      assert_match(/authorize @product/, edit_action)

      # Create action should authorize
      create_action = content.match(/def create.*?end/m)[0]
      assert_match(/authorize @product/, create_action)

      # Update action should authorize
      update_action = content.match(/def update.*?end/m)[0]
      assert_match(/authorize @product/, update_action)

      # Destroy action should authorize
      destroy_action = content.match(/def destroy.*?end/m)[0]
      assert_match(/authorize @product/, destroy_action)

      # Bulk actions should authorize
      update_all_action = content.match(/def update_all.*?end/m)[0]
      assert_match(/authorize @products/, update_all_action)

      destroy_all_action = content.match(/def destroy_all.*?end/m)[0]
      assert_match(/authorize @products/, destroy_all_action)
    end
  end

  def test_pundit_false_removes_authorization_calls_from_actions
    run_generator [ "Product", "name:string", "--no-pundit" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Index action should not use policy_scope
      index_action = content.match(/def index.*?end/m)[0]
      assert_no_match(/policy_scope/, index_action)
      assert_match(/Product\.all/, index_action) # Should use direct model access

      # Actions should not have authorize calls
      assert_no_match(/authorize @product/, content)
      assert_no_match(/authorize @products/, content)
    end
  end

  def test_pundit_true_includes_user_not_authorized_method
    run_generator [ "Product", "name:string", "--pundit" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Should have user_not_authorized method
      assert_match(/def user_not_authorized/, content)

      user_not_auth_method = content.match(/def user_not_authorized.*?end/m)[0]

      # Should handle different response formats
      assert_match(/format\.html do/, user_not_auth_method)
      assert_match(/flash\[:error\] = message/, user_not_auth_method)
      assert_match(/redirect_to products_path/, user_not_auth_method)

      assert_match(/format\.json.*:forbidden/, user_not_auth_method)

      # Should have turbo_stream response if turbo is enabled (default)
      assert_match(/format\.turbo_stream.*turbo_stream\.append.*error/, user_not_auth_method)

      # Should use i18n message
      assert_match(/t\("products\.messages\.not_authorized"\)/, user_not_auth_method)
    end
  end

  def test_pundit_false_removes_user_not_authorized_method
    run_generator [ "Product", "name:string", "--no-pundit" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Should not have user_not_authorized method
      assert_no_match(/def user_not_authorized/, content)
      assert_no_match(/not_authorized/, content)
    end
  end

  def test_pundit_true_generates_policy_file
    run_generator [ "Product", "name:string", "--pundit" ]

    assert_file "app/policies/product_policy.rb" do |content|
      # Should extend ApplicationPolicy
      assert_match(/class ProductPolicy < ApplicationPolicy/, content)

      # Should have all CRUD policy methods
      assert_match(/def index\?/, content)
      assert_match(/def show\?/, content)
      assert_match(/def create\?/, content)
      assert_match(/def new\?/, content)
      assert_match(/def update\?/, content)
      assert_match(/def edit\?/, content)
      assert_match(/def destroy\?/, content)

      # Should have bulk action policies
      assert_match(/def update_all\?/, content)
      assert_match(/def destroy_all\?/, content)

      # Should have policy scope class
      assert_match(/class Scope < ApplicationPolicy::Scope/, content)
      assert_match(/def resolve/, content)
    end
  end

  def test_pundit_false_does_not_generate_policy_file
    run_generator [ "Product", "name:string", "--no-pundit" ]

    assert_no_file "app/policies/product_policy.rb"
  end

  def test_default_pundit_option_is_true
    run_generator [ "Product", "name:string" ]

    # Default should include pundit
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/include Pundit::Authorization/, content)
      assert_match(/authorize @product/, content)
      assert_match(/policy_scope/, content)
    end

    assert_file "app/policies/product_policy.rb"
  end

  def test_pundit_with_turbo_false_removes_turbo_stream_from_auth_method
    run_generator [ "Product", "name:string", "--pundit", "--no-turbo" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Should still have user_not_authorized method
      assert_match(/def user_not_authorized/, content)

      user_not_auth_method = content.match(/def user_not_authorized.*?end/m)[0]

      # Should not have turbo_stream response
      assert_no_match(/format\.turbo_stream/, user_not_auth_method)

      # Should still have html and json responses
      assert_match(/format\.html/, user_not_auth_method)
      assert_match(/format\.json/, user_not_auth_method)
    end
  end

  def test_pundit_true_includes_policy_scoped_queries_in_index
    run_generator [ "Product", "name:string", "category:string", "--pundit" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      index_action = content.match(/def index.*?end/m)[0]

      # Should start with policy_scope
      assert_match(/@products = policy_scope\(Product\)\.all/, index_action)

      # Filtering should work on policy-scoped collection
      assert_match(/@products = @products\.where.*@q/, index_action)
      assert_match(/@products = @products\.where.*category/, index_action)

      # Ordering should work on policy-scoped collection
      assert_match(/@products = @products\.order/, index_action)

      # Pagination should work on policy-scoped collection
      assert_match(/@pagy, @products = pagy\(@products\)/, index_action)
    end
  end

  def test_pundit_false_uses_direct_model_access_in_index
    run_generator [ "Product", "name:string", "category:string", "--no-pundit" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      index_action = content.match(/def index.*?end/m)[0]

      # Should use direct model access
      assert_match(/@products = Product\.all/, index_action)
      assert_no_match(/policy_scope/, index_action)

      # Filtering should work on direct model collection
      assert_match(/@products = @products\.where.*@q/, index_action)

      # Should still have ordering and pagination
      assert_match(/@products = @products\.order/, index_action)
      assert_match(/@pagy, @products = pagy\(@products\)/, index_action)
    end
  end

  def test_pundit_error_messages_use_i18n
    run_generator [ "Product", "name:string", "--pundit" ]

    # Check that i18n files include authorization messages
    assert_file "config/locales/products.en.yml" do |content|
      assert_match(/not_authorized:/, content)
    end

    assert_file "config/locales/products.pt-BR.yml" do |content|
      assert_match(/not_authorized:/, content)
    end

    # Check controller uses i18n messages
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/t\("products\.messages\.not_authorized"\)/, content)
    end
  end

  def test_pundit_policy_includes_all_required_methods
    run_generator [ "Product", "name:string", "--pundit" ]

    assert_file "app/policies/product_policy.rb" do |content|
      # Standard CRUD operations
      %w[index show new create edit update destroy].each do |action|
        assert_match(/def #{action}\?/, content)
      end

      # Bulk operations
      %w[update_all destroy_all].each do |action|
        assert_match(/def #{action}\?/, content)
      end

      # Scope class
      assert_match(/class Scope < ApplicationPolicy::Scope/, content)
      assert_match(/def resolve/, content)
    end
  end

  def test_pundit_policy_scope_returns_records
    run_generator [ "Product", "name:string", "--pundit" ]

    assert_file "app/policies/product_policy.rb" do |content|
      scope_method = content.match(/def resolve.*?end/m)[0]
      assert_match(/scope\.all/, scope_method)
    end
  end

  private

  def prepare_destination
    super
  end
end
