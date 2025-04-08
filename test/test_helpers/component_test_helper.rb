# frozen_string_literal: true

module Fluxbit
  module ComponentTestHelpers
    include ActionView::Helpers::TagHelper
    include ViewComponent::TestHelpers
    include Fluxbit::ClassesHelper
    include Fluxbit::ComponentsHelper
  end
end
