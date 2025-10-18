# frozen_string_literal: true

require_relative "../../../test_helper"
require "rails/generators/test_case"
require "generators/fluxbit/scaffold_generator"

class Fluxbit::ScaffoldGeneratorTurboTest < Rails::Generators::TestCase
  tests Fluxbit::ScaffoldGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  def test_turbo_true_includes_turbo_stream_responses
    run_generator [ "Product", "name:string", "--turbo" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Create action should have turbo_stream format
      create_action = content.match(/def create.*?end/m)[0]
      assert_match(/format\.turbo_stream.*renders create\.turbo_stream\.erb/, create_action)

      # Update action should have turbo_stream format
      update_action = content.match(/def update.*?end/m)[0]
      assert_match(/format\.turbo_stream.*renders update\.turbo_stream\.erb/, update_action)

      # Destroy action should have turbo_stream format
      destroy_action = content.match(/def destroy.*?end/m)[0]
      assert_match(/format\.turbo_stream.*renders destroy\.turbo_stream\.erb/, destroy_action)

      # Bulk actions should have turbo_stream format
      assert_match(/def respond_with_bulk_result/, content)
      bulk_method = content.match(/def respond_with_bulk_result.*?end/m)[0]
      assert_match(/format\.turbo_stream/, bulk_method)
    end
  end

  def test_turbo_false_removes_turbo_stream_responses
    run_generator [ "Product", "name:string", "--no-turbo" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Should not have any turbo_stream format responses
      assert_no_match(/format\.turbo_stream/, content)

      # Create action should only have html and json
      create_action = content.match(/def create.*?end/m)[0]
      assert_match(/format\.html/, create_action)
      assert_match(/format\.json/, create_action)
      assert_no_match(/format\.turbo_stream/, create_action)

      # Update action should only have html and json
      update_action = content.match(/def update.*?end/m)[0]
      assert_match(/format\.html/, update_action)
      assert_match(/format\.json/, update_action)
      assert_no_match(/format\.turbo_stream/, update_action)

      # Destroy action should only have html and json
      destroy_action = content.match(/def destroy.*?end/m)[0]
      assert_match(/format\.html/, destroy_action)
      assert_match(/format\.json/, destroy_action)
      assert_no_match(/format\.turbo_stream/, destroy_action)
    end
  end

  def test_turbo_true_includes_turbo_frames_in_index
    run_generator [ "Product", "name:string", "--turbo" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # Should have turbo frame for modal (default UI)
      assert_match(/<turbo-frame id="modal"><\/turbo-frame>/, content)
    end
  end

  def test_turbo_false_removes_turbo_frames_from_index
    run_generator [ "Product", "name:string", "--no-turbo" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # Should not have any turbo frames
      assert_no_match(/<turbo-frame/, content)
      assert_no_match(/turbo_frame:/, content)
    end
  end

  def test_turbo_true_includes_turbo_frame_requests_in_forms
    run_generator [ "Product", "name:string", "--turbo" ]

    assert_file "app/views/products/new.html.erb" do |content|
      # Should check for turbo_frame_request
      assert_match(/if turbo_frame_request\?/, content)

      # Should have turbo-frame wrapper
      assert_match(/<turbo-frame id="modal">/, content)

      # Should have JavaScript event dispatch
      assert_match(/document\.dispatchEvent/, content)
    end

    assert_file "app/views/products/edit.html.erb" do |content|
      assert_match(/if turbo_frame_request\?/, content)
      assert_match(/<turbo-frame id="modal">/, content)
      assert_match(/document\.dispatchEvent/, content)
    end
  end

  def test_turbo_false_removes_turbo_frame_requests_from_forms
    run_generator [ "Product", "name:string", "--no-turbo" ]

    assert_file "app/views/products/new.html.erb" do |content|
      # Should not check for turbo_frame_request
      assert_no_match(/turbo_frame_request/, content)

      # Should not have turbo-frame wrapper
      assert_no_match(/<turbo-frame/, content)

      # Should not have JavaScript event dispatch
      assert_no_match(/document\.dispatchEvent/, content)

      # Should only have standard layout
      assert_match(/fx_heading/, content)
      assert_match(/fx_card/, content)
    end

    assert_file "app/views/products/edit.html.erb" do |content|
      assert_no_match(/turbo_frame_request/, content)
      assert_no_match(/<turbo-frame/, content)
      assert_no_match(/document\.dispatchEvent/, content)
    end
  end

  def test_turbo_true_includes_row_click_behavior_in_partial
    run_generator [ "Product", "name:string", "--turbo" ]

    assert_file "app/views/products/_products.html.erb" do |content|
      # Should have row click data attributes
      assert_match(/data: \{/, content)
      assert_match(/controller: "fx-row-click"/, content)
      assert_match(/fx_row_click_url_value: edit_product_path/, content)
      assert_match(/fx_row_click_frame_value: "modal"/, content)

      # Should have cursor pointer class
      assert_match(/cursor-pointer hover:bg-gray-50/, content)

      # Should have click to edit title
      assert_match(/click_to_edit/, content)
    end
  end

  def test_turbo_false_removes_row_click_behavior_from_partial
    run_generator [ "Product", "name:string", "--no-turbo" ]

    assert_file "app/views/products/_products.html.erb" do |content|
      # Should not have row click data attributes
      assert_no_match(/controller: "fx-row-click"/, content)
      assert_no_match(/fx_row_click_url_value/, content)
      assert_no_match(/fx_row_click_frame_value/, content)

      # Should not have interactive styling
      assert_no_match(/cursor-pointer/, content)
      assert_no_match(/hover:bg-gray-50/, content)

      # Should not have click to edit title
      assert_no_match(/click_to_edit/, content)

      # Should not have data attributes at all for the row
      table_row_match = content.match(/table\.with_row\((.*?)\) do \|row\|/m)
      assert table_row_match, "Should have table row"
      row_attributes = table_row_match[1]
      assert_no_match(/data: \{/, row_attributes)
    end
  end

  def test_turbo_true_includes_new_button_frame_target
    run_generator [ "Product", "name:string", "--turbo" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # New button should have turbo_frame data attribute
      new_button_line = content.lines.find { |line| line.include?("new_product_path") }
      assert new_button_line, "Should have new product button"
      assert_match(/turbo_frame: "modal"/, new_button_line)
    end
  end

  def test_turbo_false_removes_new_button_frame_target
    run_generator [ "Product", "name:string", "--no-turbo" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # New button should not have turbo_frame data attribute
      new_button_line = content.lines.find { |line| line.include?("new_product_path") }
      assert new_button_line, "Should have new product button"
      assert_no_match(/turbo_frame:/, new_button_line)
    end
  end

  def test_turbo_true_includes_error_handling_turbo_streams
    run_generator [ "Product", "name:string", "--turbo" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Error handling methods should include turbo_stream responses
      not_found_method = content.match(/def set_product.*?end/m)[0]
      assert_match(/format\.turbo_stream.*turbo_stream\.append.*notice/, not_found_method)

      bulk_actions_method = content.match(/def set_products_for_bulk_actions.*?end/m)[0]
      assert_match(/format\.turbo_stream.*turbo_stream\.append.*notice/, bulk_actions_method)

      auth_method = content.match(/def user_not_authorized.*?end/m)[0]
      assert_match(/format\.turbo_stream.*turbo_stream\.append.*error/, auth_method)
    end
  end

  def test_turbo_false_removes_error_handling_turbo_streams
    run_generator [ "Product", "name:string", "--no-turbo" ]

    assert_file "app/controllers/products_controller.rb" do |content|
      # Error handling methods should not include turbo_stream responses
      not_found_method = content.match(/def set_product.*?end/m)[0]
      assert_no_match(/format\.turbo_stream/, not_found_method)

      bulk_actions_method = content.match(/def set_products_for_bulk_actions.*?end/m)[0]
      assert_no_match(/format\.turbo_stream/, bulk_actions_method)

      auth_method = content.match(/def user_not_authorized.*?end/m)[0]
      assert_no_match(/format\.turbo_stream/, auth_method)
    end
  end

  def test_default_turbo_option_is_true
    run_generator [ "Product", "name:string" ]

    # Default should include turbo functionality
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/format\.turbo_stream/, content)
    end

    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/<turbo-frame/, content)
    end

    assert_file "app/views/products/new.html.erb" do |content|
      assert_match(/turbo_frame_request/, content)
    end
  end

  def test_turbo_with_ui_drawer_generates_drawer_frames
    run_generator [ "Product", "name:string", "--turbo", "--ui=drawer" ]

    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/<turbo-frame id="drawer">/, content)
      assert_match(/turbo_frame: "drawer"/, content)
    end

    assert_file "app/views/products/new.html.erb" do |content|
      assert_match(/fx_drawer/, content)
    end
  end

  def test_turbo_with_ui_none_still_removes_frames
    run_generator [ "Product", "name:string", "--turbo", "--ui=none" ]

    # Even with turbo enabled, ui=none should remove frames
    assert_file "app/views/products/index.html.erb" do |content|
      assert_no_match(/<turbo-frame/, content)
    end

    # But controller should still have turbo_stream responses
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_match(/format\.turbo_stream/, content)
    end
  end

  def test_turbo_false_with_ui_modal_removes_all_interactive_features
    run_generator [ "Product", "name:string", "--no-turbo", "--ui=modal" ]

    # No turbo frames even with modal UI
    assert_file "app/views/products/index.html.erb" do |content|
      assert_no_match(/<turbo-frame/, content)
    end

    # No turbo_stream responses
    assert_file "app/controllers/products_controller.rb" do |content|
      assert_no_match(/format\.turbo_stream/, content)
    end

    # No interactive row behavior
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_no_match(/fx-row-click/, content)
    end
  end

  private

  def prepare_destination
    super
  end
end
