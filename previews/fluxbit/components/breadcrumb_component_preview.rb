# frozen_string_literal: true

class Fluxbit::Components::BreadcrumbComponentPreview < ViewComponent::Preview
  # Basic breadcrumb with current page
  def basic; end

  # Breadcrumb with icons on items
  def with_icons; end

  # Breadcrumb demonstrating dropdown on an item
  def with_dropdown; end

  # Custom aria-label on <nav>
  def custom_aria; end

  # Only link items (no current page)
  def links_only; end

  # Long trail to showcase separators and layout
  def long_trail; end
end
