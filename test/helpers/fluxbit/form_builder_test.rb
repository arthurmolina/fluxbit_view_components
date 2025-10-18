require "test_helper"

class Fluxbit::ViewHelperTest < ActionView::TestCase
  include Fluxbit::ComponentTestHelpers

  class Product
    include ActiveModel::Model
    attr_accessor :title, :status, :accept, :access, :selected_markets

    validates :title, presence: true
  end

  setup do
    @product = Product.new
    # @available_markets = [Market.new(id: 1, name: "US"), Market.new(id: 2, name: "Spain")]
    @builder = Fluxbit::FormBuilder.new(:product, @product, self, {})
  end

  # test "#errors_summary" do
  #   @product.validate
  #   @product.errors.add(:base, "Base Error")

  #   @rendered_content = @builder.errors_summary

  #   assert_selector ".Banner--statusCritical" do
  #     assert_text "2 errors with this product"
  #     assert_selector "li", text: "Base Error"
  #     assert_selector "li", text: "Title can't be blank"
  #   end
  # end

  # test "#error_for" do
  #   @product.errors.add(:title, "Error")

  #   assert_equal "Title Error", @builder.error_for(:title)
  # end

  # test "#fx_inline_error_for" do
  #   @product.errors.add(:title, "Error")

  #   @rendered_content = @builder.fx_inline_error_for(:title)

  #   assert_selector ".InlineError" do
  #     assert_selector ".InlineError__Icon"
  #     assert_text "Title Error"
  #   end
  # end

  test "#fx_text_field" do
    @rendered_content = @builder.fx_text_field(:title, help_text: "Help Text")
    assert_selector "label", text: "Title"
    assert_selector "p.text-sm", text: "Help Text"
    assert_selector %(input[name="product[title]"])
  end

  test "#fx_select" do
    @rendered_content = @builder.fx_select(:status, { "Active" => "active", "Draft" => "draft" })

    assert_selector "label.text-sm.flex", text: "Status"
    assert_selector "select[name='product[status]']" do
      assert_selector "option[value='active']", text: "Active"
      assert_selector "option[value='draft']", text: "Draft"
    end
  end

  test "#fx_select with grouped options" do
    @rendered_content = @builder.fx_select(:status, {
      "Professional" => [ "Doctors", "Nurses" ],
      "Culturals" => [ "Artists", "Musicians" ]
    }, { grouped: true })

    assert_selector "label.text-sm.flex", text: "Status"
    assert_selector "select[name='product[status]']" do
      assert_selector "optgroup[label='Professional']" do
        assert_selector "option[value='Doctors']", text: "Doctors"
      end
      assert_selector "optgroup[label='Culturals']" do
        assert_selector "option[value='Artists']", text: "Artists"
      end
    end
  end

  test "#fx_select with time zones" do
    @rendered_content = @builder.fx_select(:status, nil, { time_zone: true })
    assert_selector "label.text-sm.flex", text: "Status"
    assert_selector "select[name='product[status]']" do
      ::ActiveSupport::TimeZone.all.first(50).each do |tz|
        assert_selector "option[value='#{tz.name}']"
      end
    end
  end

  test "#fx_select with choices" do
    @rendered_content = @builder.fx_select(:status, [ "active", "draft" ])

    assert_selector "label.text-sm.flex", text: "Status"
    assert_selector "select[name='product[status]']" do
      assert_selector "option[value='active']", text: "active"
      assert_selector "option[value='draft']", text: "draft"
    end
  end

  test "#fx_select with Rails-style positional parameters" do
    @rendered_content = @builder.fx_select(:status, ["Active", "Draft", "Archived"])

    assert_selector "label.text-sm.flex", text: "Status"
    assert_selector "select[name='product[status]']" do
      assert_selector "option", text: "Active"
      assert_selector "option", text: "Draft"
      assert_selector "option", text: "Archived"
    end
  end

  test "#fx_select with Rails-style options hash" do
    @rendered_content = @builder.fx_select(:status, ["Active", "Draft"], { prompt: "Select status" })

    assert_selector "select[name='product[status]']" do
      assert_selector "option[value='']", text: "Select status"
      assert_selector "option", text: "Active"
      assert_selector "option", text: "Draft"
    end
  end

  test "#fx_select with Rails-style html_options" do
    @rendered_content = @builder.fx_select(:status, ["Active", "Draft"], {}, { class: "custom-class" })

    assert_selector "select.custom-class[name='product[status]']"
  end

  test "#fx_select with options_for_select" do
    choices = ActionView::Helpers::FormOptionsHelper.instance_method(:options_for_select).bind(self).call(
      [["Active", "active"], ["Draft", "draft"]],
      selected: "active"
    )
    @rendered_content = @builder.fx_select(:status, choices)

    assert_selector "select[name='product[status]']" do
      assert_selector "option[value='active'][selected]", text: "Active"
      assert_selector "option[value='draft']", text: "Draft"
    end
  end

  test "#fx_check_box" do
    @rendered_content = @builder.fx_check_box(:accept, label: "Checkbox Label")

    assert_selector "div.flex" do
      assert_selector "div.flex.items-center.h-5" do
        assert_selector %(input[name="product[accept]"][type="checkbox"][value="1"])
      end
      assert_selector "div.ml-2.text-sm" do
        assert_selector "label", text: "Checkbox Label"
      end
    end
  end

  test "#fx_check_box checked" do
    @rendered_content = @builder.fx_check_box(:accept, label: "Checkbox Label", checked: true)
    assert_selector "div.flex" do
      assert_selector "div.flex.items-center.h-5" do
        assert_selector %(input[type="checkbox"][name="product[accept]"][value="1"][checked="checked"])
      end
      assert_selector "div.ml-2.text-sm" do
        assert_selector "label", text: "Checkbox Label"
      end
    end
  end

  test "#fx_radio_button" do
    @rendered_content = @builder.fx_radio_button(:access, value: :allow, label: "Radio Label")

    assert_selector "div.flex" do
      assert_selector "div.flex.items-center.h-5" do
        assert_selector %(input[type="radio"][name="product[access]"])
      end
      assert_selector "div.ml-2.text-sm" do
        assert_selector "label", text: "Radio Label"
      end
    end
  end

  test "#fx_dropzone" do
    @rendered_content = @builder.fx_dropzone(:image, title: "Dropzone Label")

    assert_selector "div.flex.w-full.items-center.justify-center" do
      assert_selector "label.flex.flex-col.items-center.justify-center" do
        assert_selector "div.flex.flex-col.items-center.justify-center.pt-5.pb-6" do
          assert_selector "p.mb-2.text-sm.text-slate-500", text: "Dropzone Label"
          assert_selector "p.text-xs.text-slate-500", text: "SVG, PNG, JPG or GIF (MAX. 800x400px)"
        end
        assert_selector %(input[type="file"][name="product[image]"][id="product_image"].hidden)
      end
    end
  end
end
