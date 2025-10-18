# frozen_string_literal: true

# Shared helper methods for generator tests
module GeneratorTestHelper
  # Helper to run generator with common test model
  def run_test_generator(options = [])
    run_generator([ "TestModel", "name:string", "description:text", "active:boolean", "price:decimal" ] + options)
  end

  # Helper to assert controller includes specific option behavior
  def assert_controller_includes_option(option_name, pattern)
    assert_file "app/controllers/test_models_controller.rb" do |content|
      assert_match(pattern, content)
    end
  end

  # Helper to assert controller excludes specific option behavior
  def assert_controller_excludes_option(option_name, pattern)
    assert_file "app/controllers/test_models_controller.rb" do |content|
      assert_no_match(pattern, content)
    end
  end

  # Helper to assert view includes specific option behavior
  def assert_view_includes_option(view_name, option_name, pattern)
    assert_file "app/views/test_models/#{view_name}.html.erb" do |content|
      assert_match(pattern, content)
    end
  end

  # Helper to assert view excludes specific option behavior
  def assert_view_excludes_option(view_name, option_name, pattern)
    assert_file "app/views/test_models/#{view_name}.html.erb" do |content|
      assert_no_match(pattern, content)
    end
  end

  # Helper to check if all standard files are generated
  def assert_all_scaffold_files_generated(model_name = "test_model")
    plural = model_name.pluralize

    # Controller
    assert_file "app/controllers/#{plural}_controller.rb"

    # Views
    %w[index show new edit _form _metadata].each do |view|
      assert_file "app/views/#{plural}/#{view}.html.erb"
    end

    # Partial
    assert_file "app/views/#{plural}/_#{plural}.html.erb"

    # Turbo Stream templates
    %w[create update update_all destroy destroy_all].each do |action|
      assert_file "app/views/#{plural}/#{action}.turbo_stream.erb"
    end

    # JSON templates
    %w[index show].each do |action|
      assert_file "app/views/#{plural}/#{action}.json.jbuilder"
    end

    # I18n
    %w[en pt-BR].each do |locale|
      assert_file "config/locales/#{plural}.#{locale}.yml"
    end

    # Policy
    assert_file "app/policies/#{model_name}_policy.rb"

    # Shared partials
    assert_file "app/views/shared/_alert.html.erb"
    assert_file "app/views/shared/_flash.html.erb"
  end
end
