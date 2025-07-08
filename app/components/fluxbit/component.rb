# frozen_string_literal: true

require "anyicon"

class Fluxbit::Component < ViewComponent::Base
  # Custom class to hold button properties and content
  ComponentObj = Data.define(:props, :content)

  def initialize(**props)
    @popover_placement = props.delete(:popover_placement) || :right
    @popover_trigger = props.delete(:popover_trigger) || :hover # or :click
    @popover_text = props.delete(:popover_text)

    @tooltip_placement = props.delete(:tooltip_placement) || :right
    @tooltip_trigger = props.delete(:tooltip_trigger) || :hover # or :click
    @tooltip_text = props.delete(:tooltip_text)
  end

  def add(to:, first_element: false, **props)
    unless props[:class].nil?
      to[:class] = (to[:class] || "")
        .split
        .insert((first_element ? 0 : -1), props[:class])
        .join(" ")
    end
    to
  end

  def remove_class(elements, from)
    from.split.reject { |c| c.in?(elements || "".split) }.join(" ")
  end

  def remove_class_from_props(props)
    props[:class] = remove_class(props.delete(:remove_class) || "", props[:class])
  end

  def options(value, collection: nil, default: nil)
    if collection.nil?
      value.nil? ? default : value
    else
      value.in?(collection) ? value : default
    end
  end

  def render_popover_or_tooltip
    safe_join [
      (@popover_text.nil? ? "" : Fluxbit::PopoverComponent.new(id: target, **(@popover_props || {})).with_content(@popover_text).render_in(view_context)),
      (@tooltip_text.nil? ? "" : Fluxbit::TooltipComponent.new(id: target, **(@tooltip_props || {})).with_content(@tooltip_text).render_in(view_context))
    ]
  end

  def add_popover_or_tooltip
    if popover? || @popover_text.present?
      @props["data-popover-placement"] = @popover_placement
      @props["data-popover-trigger"] = @popover_trigger unless @popover_trigger == :hover
      @props["data-popover-target"] = target
    end

    if tooltip? || @tooltip_text.present?
      @props["data-tooltip-placement"] = @tooltip_placement
      @props["data-tooltip-trigger"] = @tooltip_trigger unless @tooltip_trigger == :hover
      @props["data-tooltip-target"] = target
    end
  end

  def target
    @popover_target ||= "#{
      @props.try('for') ||
      @props.try(:for) ||
      (0...10).map { ('a'..'z').to_a[rand(26)] }.join}_target"
  end

  def anyicon(icon:, **props)
    Anyicon::Icon.render(icon: icon, **props)
  end

  def random_id
    (0...30).map { ("a".."z").to_a[rand(26)] }.join
  end

  def fx_id
    @fx_id ||= "#{element_name}-#{random_id}"
  end

  def element_name
    self.class.to_s.match(/Fluxbit::(\w+)Component/)[1].underscore
  rescue
    "any"
  end
end
