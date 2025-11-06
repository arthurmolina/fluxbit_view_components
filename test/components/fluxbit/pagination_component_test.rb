# frozen_string_literal: true

require "test_helper"

class Fluxbit::PaginationComponentTest < ViewComponent::TestCase
  include Fluxbit::Config::PaginationComponent

  PagyStub = Struct.new(:count, :last, :next, :page, :prev, :vars, keyword_init: true)

  def build_pagy_stub(page:, last:, next_page:, prev_page:, vars: {})
    PagyStub.new(
      count: last * 10,
      last: last,
      next: next_page,
      page: page,
      prev: prev_page,
      vars: {
        size: 10,
        page_param: :page,
        absolute: false,
        limit_extra: false,
        limit_param: :per_page,
        request_path: nil
      }.merge(vars)
    )
  end

  # New-style Pagy mock (without vars method, uses 'previous' instead of 'prev')
  PagyStubNew = Struct.new(:count, :last, :next, :page, :previous, keyword_init: true)

  def build_pagy_stub_new(page:, last:, next_page:, previous_page:)
    PagyStubNew.new(
      count: last * 10,
      last: last,
      next: next_page,
      page: page,
      previous: previous_page
    )
  end

  test "renders <nav> with default aria-label and root classes" do
    render_inline(Fluxbit::PaginationComponent.new(nil, size: 10, aria_label: "Pages (10)"))

    assert_selector 'nav[aria-label="Pages (10)"]'
    assert_selector "nav#{styled(:root)}"
    assert_selector "nav.text-sm"
  end

  test "allows overriding aria-label via prop" do
    render_inline(Fluxbit::PaginationComponent.new(nil, size: 10, aria_label: "My Pages"))

    assert_selector 'nav[aria-label="My Pages"]'
  end

  test "by default shows prev/next and hides first/last" do
    pagy = build_pagy_stub(page: 1, last: 5, next_page: 2, prev_page: nil)
    render_inline(Fluxbit::PaginationComponent.new(pagy))

    assert_selector "a#{styled(:page_link)}#{styled(:disabled)}[aria-disabled='true']"
    assert_selector "a#{styled(:page_link)}#{styled(:next)}[href*='?page=2']"
    refute_selector "a[aria-label='#{I18n.t('fluxbit.pagination.aria_label.first', default: 'First', raise: false)}']"
    refute_selector "a[aria-label='#{I18n.t('fluxbit.pagination.aria_label.last',  default: 'Last',  raise: false)}']"
  end

  test "shows first/last when show_first_last: true and sets disabled/enabled correctly" do
    pagy = build_pagy_stub(page: 1, last: 5, next_page: 2, prev_page: nil)
    render_inline(Fluxbit::PaginationComponent.new(pagy, show_first_last: true))

    assert_selector "a#{styled(:page_link)}#{styled(:disabled)}#{styled(:previous)}[aria-disabled='true']"
    assert_selector "a#{styled(:page_link)}#{styled(:next)}[href*='?page=5']"
    assert_selector "a[aria-label='#{I18n.t('fluxbit.pagination.aria_label.prev', default: 'Previous', raise: false)}']"
    assert_selector "a[aria-label='#{I18n.t('fluxbit.pagination.aria_label.next', default: 'Next', raise: false)}']"
  end

  test "renders pages series with links, current page, and gaps when size >= 7 and ends enabled" do
    pagy = build_pagy_stub(page: 5, last: 10, next_page: 6, prev_page: 4, vars: { request_path: "/items" })
    render_inline(Fluxbit::PaginationComponent.new(pagy, show_first_last: true, size: 7))

    assert_selector "a#{styled(:current)}[aria-current='page'][aria-disabled='true']", text: "5"
    assert_selector "a#{styled(:page_link)}[href='/items?page=4']", text: "4"
    assert_selector "a#{styled(:page_link)}[href='/items?page=6']", text: "6"
    assert_selector "a[aria-disabled='true']"
  end

  test "size == 0 does not render numeric page links" do
    render_inline(Fluxbit::PaginationComponent.new(nil, size: 0, aria_label: "Pages"))
    refute_selector "a[aria-label='1']"
    refute_selector "a[aria-label='2']"
  end

  test "sizing=1 applies sizes[1] classes to root and page links" do
    pagy = build_pagy_stub(page: 2, last: 3, next_page: 3, prev_page: 1)
    render_inline(Fluxbit::PaginationComponent.new(pagy, sizing: 1, aria_label: "Pages"))

    assert_selector "nav.text-base.h-10"
    assert_selector "a.px-4.h-10", minimum: 2
  end

  test "when show_icons=false and show_texts=false it forces show_texts=true" do
    pagy = build_pagy_stub(page: 1, last: 2, next_page: 2, prev_page: nil)
    render_inline(Fluxbit::PaginationComponent.new(pagy, show_icons: false, show_texts: false, aria_label: "Pages"))

    refute_selector "a span#{styled(:only_icon)}"
  end

  test "raises ArgumentError when size is not an Integer >= 0" do
    assert_raises(ArgumentError) { Fluxbit::PaginationComponent.new(nil, size: -1) }
    assert_raises(ArgumentError) { Fluxbit::PaginationComponent.new(nil, size: "2") }
  end

  test "first/last buttons disabled state at extremes" do
    pagy = build_pagy_stub(page: 10, last: 10, next_page: nil, prev_page: 9)
    render_inline(Fluxbit::PaginationComponent.new(pagy, show_first_last: true, aria_label: "Pages"))

    assert_selector "a#{styled(:page_link)}#{styled(:disabled)}#{styled(:next)}[aria-disabled='true']"
    assert_selector "a#{styled(:page_link)}#{styled(:previous)}[href*='?page=1']"
  end

  # Tests for new-style Pagy (without vars method, uses 'previous' instead of 'prev')
  test "new pagy: renders with prev/next and correct page parameter in URLs" do
    pagy = build_pagy_stub_new(page: 2, last: 5, next_page: 3, previous_page: 1)
    render_inline(Fluxbit::PaginationComponent.new(pagy))

    # Should use 'page' as default parameter name
    assert_selector "a#{styled(:page_link)}[href*='?page=1']"
    assert_selector "a#{styled(:page_link)}#{styled(:next)}[href*='?page=3']"
    # Should NOT have empty parameter (was the bug: ?=2 instead of ?page=2)
    refute_selector "a[href*='?=']"
  end

  test "new pagy: shows first/last when show_first_last: true" do
    pagy = build_pagy_stub_new(page: 3, last: 5, next_page: 4, previous_page: 2)
    render_inline(Fluxbit::PaginationComponent.new(pagy, show_first_last: true))

    assert_selector "a#{styled(:page_link)}#{styled(:previous)}[href*='?page=1']"
    assert_selector "a#{styled(:page_link)}#{styled(:next)}[href*='?page=5']"
    assert_selector "a[aria-label='#{I18n.t('fluxbit.pagination.aria_label.first', default: 'First', raise: false)}']"
    assert_selector "a[aria-label='#{I18n.t('fluxbit.pagination.aria_label.last',  default: 'Last',  raise: false)}']"
  end

  test "new pagy: renders page links correctly with default page parameter" do
    pagy = build_pagy_stub_new(page: 2, last: 4, next_page: 3, previous_page: 1)
    render_inline(Fluxbit::PaginationComponent.new(pagy, size: 4))

    assert_selector "a#{styled(:current)}[aria-current='page']", text: "2"
    assert_selector "a#{styled(:page_link)}[href*='?page=1']", text: "1"
    assert_selector "a#{styled(:page_link)}[href*='?page=3']", text: "3"
    assert_selector "a#{styled(:page_link)}[href*='?page=4']", text: "4"
  end

  test "new pagy: handles disabled state at page boundaries" do
    # At first page
    pagy = build_pagy_stub_new(page: 1, last: 5, next_page: 2, previous_page: nil)
    render_inline(Fluxbit::PaginationComponent.new(pagy, show_first_last: true))

    assert_selector "a#{styled(:page_link)}#{styled(:disabled)}#{styled(:previous)}[aria-disabled='true']"
    assert_selector "a#{styled(:page_link)}#{styled(:next)}[href*='?page=5']"

    # At last page
    pagy = build_pagy_stub_new(page: 5, last: 5, next_page: nil, previous_page: 4)
    render_inline(Fluxbit::PaginationComponent.new(pagy, show_first_last: true))

    assert_selector "a#{styled(:page_link)}#{styled(:disabled)}#{styled(:next)}[aria-disabled='true']"
    assert_selector "a#{styled(:page_link)}#{styled(:previous)}[href*='?page=1']"
  end
end
