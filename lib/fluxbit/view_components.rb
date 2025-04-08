# frozen_string_literal: true

require "fluxbit/view_components/version"
require "fluxbit/view_components/engine"

module Fluxbit
  module ViewComponents
  end

  module Config
    module Form
      require "fluxbit/config/form/helper_text_component"
    end

    require "fluxbit/config/alert_component"
    require "fluxbit/config/avatar_component"
    require "fluxbit/config/badge_component"
    require "fluxbit/config/button_component"
    require "fluxbit/config/card_component"
    require "fluxbit/config/flex_component"
    require "fluxbit/config/gravatar_component"
    require "fluxbit/config/heading_component"
    require "fluxbit/config/modal_component"
    require "fluxbit/config/paragraph_component"
    require "fluxbit/config/popover_component"
    require "fluxbit/config/tab_component"
    require "fluxbit/config/text_component"
    require "fluxbit/config/tooltip_component"
  end
end
