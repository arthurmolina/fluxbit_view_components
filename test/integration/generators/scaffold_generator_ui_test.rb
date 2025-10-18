# frozen_string_literal: true

require_relative "../../../test_helper"
require "rails/generators/test_case"
require "generators/fluxbit/scaffold_generator"

class Fluxbit::ScaffoldGeneratorUiTest < Rails::Generators::TestCase
  tests Fluxbit::ScaffoldGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  def test_ui_modal_generates_modal_interface
    run_generator [ "Product", "name:string", "--ui=modal" ]

    # Index view should have modal turbo frame
    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/<turbo-frame id="modal"><\/turbo-frame>/, content)
      assert_match(/turbo_frame: "modal"/, content)
    end

    # New view should have modal layout
    assert_file "app/views/products/new.html.erb" do |content|
      # Should check for turbo_frame_request
      assert_match(/if turbo_frame_request\?/, content)

      # Should have modal inside turbo frame
      assert_match(/<turbo-frame id="modal">/, content)
      assert_match(/fx_modal\(id: "new-modal", size: :xl/, content)
      assert_match(/modal\.with_header.*titles\.new/, content)

      # Should dispatch show modal event
      assert_match(/showModal:new-modal/, content)

      # Should have fallback layout
      assert_match(/fx_heading.*titles\.new/, content)
      assert_match(/fx_card/, content)
    end

    # Edit view should have modal layout
    assert_file "app/views/products/edit.html.erb" do |content|
      assert_match(/if turbo_frame_request\?/, content)
      assert_match(/<turbo-frame id="modal">/, content)
      assert_match(/fx_modal\(id: "edit-modal", size: :xl/, content)
      assert_match(/modal\.with_header.*titles\.edit/, content)
      assert_match(/showModal:edit-modal/, content)
    end

    # Partial should reference modal frame
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_match(/fx_row_click_frame_value: "modal"/, content)
    end
  end

  def test_ui_drawer_generates_drawer_interface
    run_generator [ "Product", "name:string", "--ui=drawer" ]

    # Index view should have drawer turbo frame
    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/<turbo-frame id="drawer"><\/turbo-frame>/, content)
      assert_match(/turbo_frame: "drawer"/, content)
    end

    # New view should have drawer layout
    assert_file "app/views/products/new.html.erb" do |content|
      # Should check for turbo_frame_request
      assert_match(/if turbo_frame_request\?/, content)

      # Should have drawer inside turbo frame
      assert_match(/<turbo-frame id="drawer">/, content)
      assert_match(/fx_drawer\(id: "new-drawer", placement: :right, sizing: :xl/, content)
      assert_match(/drawer\.with_header.*titles\.new/, content)

      # Should dispatch show drawer event
      assert_match(/showDrawer:new-drawer/, content)

      # Should have fallback layout
      assert_match(/fx_heading.*titles\.new/, content)
      assert_match(/fx_card/, content)
    end

    # Edit view should have drawer layout
    assert_file "app/views/products/edit.html.erb" do |content|
      assert_match(/if turbo_frame_request\?/, content)
      assert_match(/<turbo-frame id="drawer">/, content)
      assert_match(/fx_drawer\(id: "edit-drawer", placement: :right, sizing: :xl/, content)
      assert_match(/drawer\.with_header.*titles\.edit/, content)
      assert_match(/showDrawer:edit-drawer/, content)
    end

    # Partial should reference drawer frame
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_match(/fx_row_click_frame_value: "drawer"/, content)
    end
  end

  def test_ui_none_generates_standard_interface
    run_generator [ "Product", "name:string", "--ui=none" ]

    # Index view should not have turbo frames
    assert_file "app/views/products/index.html.erb" do |content|
      assert_no_match(/<turbo-frame/, content)
      assert_no_match(/turbo_frame:/, content)
    end

    # New view should only have standard layout
    assert_file "app/views/products/new.html.erb" do |content|
      # Should only have standard layout elements
      assert_match(/fx_heading.*titles\.new/, content)
      assert_match(/fx_card/, content)

      # Should not have modal or drawer
      assert_no_match(/fx_modal/, content)
      assert_no_match(/fx_drawer/, content)
      assert_no_match(/turbo-frame/, content)
      assert_no_match(/turbo_frame_request/, content)
    end

    # Edit view should only have standard layout
    assert_file "app/views/products/edit.html.erb" do |content|
      assert_match(/fx_heading.*titles\.edit/, content)
      assert_match(/fx_card/, content)
      assert_no_match(/fx_modal/, content)
      assert_no_match(/fx_drawer/, content)
      assert_no_match(/turbo-frame/, content)
    end

    # Partial should not have row click behavior
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_no_match(/fx-row-click/, content)
      assert_no_match(/fx_row_click_frame_value/, content)
      assert_no_match(/data: \{/, content)
    end
  end

  def test_default_ui_option_is_modal
    run_generator [ "Product", "name:string" ]

    # Default should be modal
    assert_file "app/views/products/index.html.erb" do |content|
      assert_match(/<turbo-frame id="modal">/, content)
      assert_match(/turbo_frame: "modal"/, content)
    end

    assert_file "app/views/products/new.html.erb" do |content|
      assert_match(/fx_modal/, content)
    end

    assert_file "app/views/products/_products.html.erb" do |content|
      assert_match(/fx_row_click_frame_value: "modal"/, content)
    end
  end

  def test_ui_modal_with_turbo_false_removes_interactive_elements
    run_generator [ "Product", "name:string", "--ui=modal", "--no-turbo" ]

    # Index should not have turbo frames even with modal UI
    assert_file "app/views/products/index.html.erb" do |content|
      assert_no_match(/<turbo-frame/, content)
      assert_no_match(/turbo_frame:/, content)
    end

    # New view should not have turbo frame check or modal
    assert_file "app/views/products/new.html.erb" do |content|
      assert_no_match(/turbo_frame_request/, content)
      assert_no_match(/fx_modal/, content)
      assert_match(/fx_heading/, content) # Should have standard layout
    end

    # Partial should not have interactive behavior
    assert_file "app/views/products/_products.html.erb" do |content|
      assert_no_match(/fx-row-click/, content)
      assert_no_match(/data: \{/, content)
    end
  end

  def test_ui_drawer_with_turbo_false_removes_interactive_elements
    run_generator [ "Product", "name:string", "--ui=drawer", "--no-turbo" ]

    # Index should not have turbo frames even with drawer UI
    assert_file "app/views/products/index.html.erb" do |content|
      assert_no_match(/<turbo-frame/, content)
      assert_no_match(/turbo_frame:/, content)
    end

    # New view should not have turbo frame check or drawer
    assert_file "app/views/products/new.html.erb" do |content|
      assert_no_match(/turbo_frame_request/, content)
      assert_no_match(/fx_drawer/, content)
      assert_match(/fx_heading/, content) # Should have standard layout
    end
  end

  def test_ui_modal_javascript_events_are_correct
    run_generator [ "Product", "name:string", "--ui=modal" ]

    assert_file "app/views/products/new.html.erb" do |content|
      # Should have correct modal show event
      assert_match(/document\.dispatchEvent\(new CustomEvent\("showModal:new-modal"\)\)/, content)
    end

    assert_file "app/views/products/edit.html.erb" do |content|
      # Should have correct modal show event
      assert_match(/document\.dispatchEvent\(new CustomEvent\("showModal:edit-modal"\)\)/, content)
    end
  end

  def test_ui_drawer_javascript_events_are_correct
    run_generator [ "Product", "name:string", "--ui=drawer" ]

    assert_file "app/views/products/new.html.erb" do |content|
      # Should have correct drawer show event
      assert_match(/document\.dispatchEvent\(new CustomEvent\("showDrawer:new-drawer"\)\)/, content)
    end

    assert_file "app/views/products/edit.html.erb" do |content|
      # Should have correct drawer show event
      assert_match(/document\.dispatchEvent\(new CustomEvent\("showDrawer:edit-drawer"\)\)/, content)
    end
  end

  def test_ui_option_affects_new_button_frame_target
    run_generator [ "Product", "name:string", "--ui=modal" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # New button should target modal frame
      assert_match(/href: new_product_path.*turbo_frame: "modal"/, content)
    end
  end

  def test_ui_drawer_new_button_targets_drawer_frame
    run_generator [ "Product", "name:string", "--ui=drawer" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # New button should target drawer frame
      assert_match(/href: new_product_path.*turbo_frame: "drawer"/, content)
    end
  end

  def test_ui_none_new_button_has_no_frame_target
    run_generator [ "Product", "name:string", "--ui=none" ]

    assert_file "app/views/products/index.html.erb" do |content|
      # New button should not have turbo frame data
      new_button_line = content.lines.find { |line| line.include?("new_product_path") }
      assert new_button_line, "Should have new product button"
      assert_no_match(/turbo_frame:/, new_button_line)
    end
  end

  def test_ui_option_affects_row_click_behavior_in_partial
    run_generator [ "Product", "name:string", "active:boolean", "--ui=modal" ]

    assert_file "app/views/products/_products.html.erb" do |content|
      # Should have row click controller and modal frame target
      assert_match(/controller: "fx-row-click"/, content)
      assert_match(/fx_row_click_url_value: edit_product_path/, content)
      assert_match(/fx_row_click_frame_value: "modal"/, content)
      assert_match(/cursor-pointer hover:bg-gray-50/, content)
    end
  end

  private

  def prepare_destination
    super
  end
end
