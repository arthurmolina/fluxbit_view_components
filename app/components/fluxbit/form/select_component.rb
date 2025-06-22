# frozen_string_literal: true

# The `Fluxbit::Form::SelectComponent` is a styled dropdown/select field for forms.
# It supports standard, grouped, and time zone options, integrates with Rails form builders,
# and provides flexible props for prompt, disabled/selected options, helper text, and more.
#
# @example Basic usage
#   = render Fluxbit::Form::SelectComponent.new(name: :role, options: ["Admin", "User", "Guest"], label: "User Role")
#
# @see docs/03_Forms/Select.md For detailed documentation and examples.
class Fluxbit::Form::SelectComponent < Fluxbit::Form::TextFieldComponent
  # Initializes the select component with the given properties.
  #
  # @param name [String] Name of the field (required unless using form builder)
  # @param label [String] Label for the input (optional)
  # @param value [String] Value for the field (optional)
  # @param grouped [Boolean] Enables grouped select options (default: false)
  # @param time_zone [Boolean] Uses Rails time zone select options (default: false)
  # @param select_options [Hash] Options for select tag (prompt, selected, disabled, etc)
  # @param choices [Array] List of choices for options (alternative to options)
  # @param options [Array, Hash] List or hash of options (or groups if grouped)
  # @param help_text [String] Helper or error text below the field
  # @param class [String] Additional CSS classes for the select element
  # @param ... any other HTML attribute supported by <select>
  def initialize(**props)
    super(**props)
    @grouped = @props.delete(:grouped) || false
    @time_zone = @props.delete(:time_zone) || false
    @select_options = @props.delete(:select_options) || {}
    @choices = @props.delete(:choices) || nil
    @options = @props.delete(:options) || {}
    @options = ::ActiveSupport::TimeZone.all if @time_zone
  end

  def input
    if @form.present? && @attribute.present?
      @form.select(
        @attribute,
        build_options_for_select,
        @select_options,
        @props
      )
    else
      select_tag(
        @name,
        build_options_for_select,
        @props
      )
    end
  end

  def build_options_for_select
    if @grouped
      grouped_options_for_select(
        @options,
        @selected,
        disabled: @disabled_options,
        prompt: @prompt,
        divider: @divider
      )
    elsif @time_zone
      time_zone_options_for_select(@selected)
    else
      options_for_select(@options, selected: @selected, disabled: @disabled_options)
    end
  end

  private

  def grouped_selected_option
    @options.each do |group|
      group_to_traverse = @divider ? group[1] : group
      if group_to_traverse.is_a?(String)
        return group_to_traverse if group_to_traverse == @selected.to_s

        next
      end

      group_to_traverse.each do |item|
        if item.is_a?(Array) && item[1] == @selected.to_s
          return item[0]
        elsif item.is_a?(String) && item == @selected.to_s
          return item
        end
      end
    end
  end
end
