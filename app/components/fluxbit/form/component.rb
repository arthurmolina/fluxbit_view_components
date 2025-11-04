# frozen_string_literal: true

# Interface to Inputs
class Fluxbit::Form::Component < Fluxbit::Component
  def id
    return @id ||= random_id if @props[:id].nil? && @form.nil?
    return @props[:id] unless @props[:id].nil?

    "#{@form.object_name}_#{@attribute}"
  end

  def define_help_text(help_text, object, attribute)
    return nil if help_text.is_a? FalseClass

    if help_text.nil? && !object.nil? && !attribute.nil?
      help_text = I18n.t(
        attribute,
        scope: [ object.class.name.pluralize.underscore.to_sym, :help_text ],
        default: nil
      )
    end

    (help_text.is_a?(Array) ? help_text : [ help_text ]) + errors
  end

  def define_helper_popover(helper_popover, object, attribute)
    return nil if helper_popover == false
    return helper_popover if !helper_popover.nil? || object.nil?

    I18n.t(attribute, scope: [ object.class.name.pluralize.underscore.to_sym, :helper_popover ], default: nil)
  end

  def label_value(label, object, attribute, id)
    if label.nil? && !object.nil? && !attribute.nil?
      key = [ object.class.name.pluralize.underscore.to_sym, :fields, attribute ]
      return I18n.exists?(key) ? I18n.t(attribute, scope: key[0..-2]) : object.class.human_attribute_name(attribute)
    end
    return attribute.to_s.humanize if label.nil? && object.nil?
    return id.to_s.humanize if label.nil? && !id.nil?
    return label unless label.nil?

    nil
  end

  def label
    return "" if @label.blank?

    Fluxbit::Form::LabelComponent.new(
      for:                      id,
      color:                    @color,
      helper_popover:           @helper_popover,
      helper_popover_placement: @helper_popover_placement,
      class:                    @label_class,
      required:                 @required
    ).with_content(@label).render_in(view_context)
  end

  def errors
    return [] unless @object&.errors&.any?

    @object.errors.filter { |f| f.attribute == @attribute }.map(&:full_message)
  end

  def help_text
    return "" if @help_text.blank? || @help_text.compact.blank?

    nodes = @help_text.compact.map do |text|
      Fluxbit::Form::HelpTextComponent.new(color: @color).with_content(text).render_in(view_context)
    end

    view_context.safe_join(nodes)
  end
end
