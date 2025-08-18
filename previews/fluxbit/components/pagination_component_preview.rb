# frozen_string_literal: true

class Fluxbit::Components::PaginationComponentPreview < ViewComponent::Preview
  # Basic: prev/next + numeric pages (default sizing 0)
  def basic; end

  # With first/last controls enabled
  def with_first_last; end

  # Icons only (default config: show_icons: true, show_texts: false)
  def icons_only; end

  # Texts only (force show_texts: true, disable icons)
  def texts_only; end

  # Sizing variants (0 and 1)
  def sizes; end

  # Edge cases: first page and last page (disabled prev/next appropriately)
  def edge_cases; end

  # Long series with gaps (size >= 7 + ends)
  def long_series_with_gaps; end

  # No pages rendered (size: 0)
  def zero_size; end

  # Custom aria-label and custom request_path/params in URLs
  def custom_aria_and_urls; end
end
