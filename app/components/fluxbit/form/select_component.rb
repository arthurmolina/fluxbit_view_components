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
  # @param label [String, false] Label text for the select field (optional, auto-generated from attribute if using form builder)
  # @param help_text [String, Array, false] Help text displayed below the field (optional, supports i18n)
  # @param helper_popover [String, false] Content for an info popover next to the label (optional, supports i18n)
  # @param helper_popover_placement [String] Placement of the popover: "top", "right", "bottom", "left" (default: "right")
  # @param value [String] Value for the field (optional)
  # @param grouped [Boolean] Enables grouped select options (default: false)
  # @param time_zone [Boolean] Uses Rails time zone select options (default: false)
  # @param select_options [Hash] Options for select tag (prompt, selected, disabled, etc)
  # @param choices [Array] List of choices for options (alternative to options)
  # @param options [Array, Hash, String] List or hash of options, or pre-formatted HTML from options_for_select
  # @param prompt [String, Boolean, false] Prompt text, true to use default, or false to disable (optional, defaults to I18n if object/attribute present)
  # @param include_blank [String, Boolean] Include blank option (optional)
  # @param selected [Object] Pre-selected value (optional)
  # @param disabled [Array, Object] Disabled options (optional)
  # @param color [Symbol] Color state: :default, :success, :danger, :warning, :info (optional)
  # @param sizing [Integer] Field size (0 to 2, default: 1)
  # @param class [String] Additional CSS classes for the select element
  # @param ... any other HTML attribute supported by <select>
  def initialize(**props)
    super(**props)
    @grouped = @props.delete(:grouped) || false
    @time_zone = @props.delete(:time_zone) || false
    @select_options = @props.delete(:select_options) || {}
    @choices = @props.delete(:choices) || nil
    @options = @props.delete(:options) || {}

    # Extract select-specific options
    prompt_value = @select_options.delete(:prompt) || @props.delete(:prompt)
    @include_blank = @select_options.delete(:include_blank) || @props.delete(:include_blank)
    @selected = @select_options.delete(:selected) || @props.delete(:selected)
    @disabled_options = @select_options.delete(:disabled) || @props.delete(:disabled)

    @options = ::ActiveSupport::TimeZone.all if @time_zone

    # Define prompt with I18n support
    define_prompt(prompt_value)
  end

  def input
    if @form.present? && @attribute.present?
      # form.select(attribute, choices, options = {}, html_options = {})
      # For form builder with time zones, use the specialized helper
      if @time_zone
        @form.time_zone_select(@attribute, nil, build_select_options_hash, @props)
      else
        # form.select can accept raw choices OR pre-formatted option tags
        # We use pre-formatted tags for consistency with grouped selects
        @form.select(
          @attribute,
          build_options_for_select,
          build_select_options_hash,
          @props
        )
      end
    else
      # select_tag(name, option_tags = nil, options = {})
      # option_tags should be pre-formatted HTML
      select_tag(
        @name,
        build_options_for_select,
        @props
      )
    end
  end

  # Build options hash for form.select (prompt, include_blank, etc.)
  # Note: Don't include selected/disabled if options are pre-formatted HTML
  def build_select_options_hash
    options_hash = @select_options.dup
    options_hash[:prompt] = @prompt if @prompt
    options_hash[:include_blank] = @include_blank if @include_blank

    # Only add selected/disabled if we're building options from raw data
    unless options_are_preformatted?
      options_hash[:selected] = @selected if @selected
      options_hash[:disabled] = @disabled_options if @disabled_options
    end

    options_hash
  end

  # Build pre-formatted option tags for select_tag and form.select
  def build_options_for_select
    # If options are already HTML (from options_for_select/grouped_options_for_select), use as-is
    if options_are_preformatted?
      html = @options.dup
      # Add prompt if needed and not already in the HTML
      html = add_prompt_to_html(html) if @prompt && !html.include?(@prompt.to_s)
      return html
    end

    # Otherwise, build the HTML from raw data
    html = if @grouped
      grouped_options_for_select(
        @options,
        @selected,
        disabled: @disabled_options,
        divider: @divider
      )
    elsif @time_zone
      time_zone_options_for_select(@selected)
    else
      options_for_select(@options, selected: @selected, disabled: @disabled_options)
    end

    # Add prompt option at the beginning if specified
    html = add_prompt_to_html(html) if @prompt
    html
  end

  private

  def define_prompt(prompt)
    # If prompt is explicitly false, don't set it
    return if prompt.is_a?(FalseClass)

    # If prompt is explicitly provided (string or true), use it
    if prompt.present?
      @prompt = prompt
      return
    end

    # If no prompt provided and we have an object and attribute, try I18n lookup
    if prompt.nil? && @object.present? && @attribute.present?
      i18n_prompt = I18n.t(
        @attribute,
        scope: [ @object.class.name.pluralize.underscore.to_sym, :prompts ],
        default: nil
      )
      @prompt = i18n_prompt if i18n_prompt.present?
    end
  end

  # Check if options are already pre-formatted HTML
  # Pre-formatted options are strings containing HTML tags
  def options_are_preformatted?
    @options.is_a?(String) && @options.include?("<option")
  end

  # Add prompt option to the beginning of the HTML options
  def add_prompt_to_html(html)
    prompt_text = @prompt.is_a?(String) ? @prompt : "Please select"
    prompt_option = "<option value=\"\">#{ERB::Util.html_escape(prompt_text)}</option>".html_safe
    prompt_option + html
  end

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
