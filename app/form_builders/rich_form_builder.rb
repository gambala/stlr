class RichFormBuilder < ActionView::Helpers::FormBuilder
  def error_message(field_name, options = {})
    return if field_without_errors?(field_name)
    class_def = options[:class] || 'field-paragraph field-paragraph_danger'
    @template.content_tag :div, message(field_name), class: class_def
  end

  def label(method, text = nil, options = {}, &block)
    options[:for] ||= "#{@object_name}-#{method.to_s.tr('_', '-')}-input"
    options[:class] ||= 'label'
    super(method, text, options, &block)
  end

  def moderation_message(field_name, options = {})
    return unless @object.moderating_record.send("#{field_name}?")
    class_def = options[:class] || 'field-paragraph'
    message = options[:message] || '* Проверяется модераторами'
    @template.content_tag :div, message, class: class_def
  end

  def rest_errors_message(excluded_errors, options = {})
    errors = @object.errors.dup
    excluded_errors.each { |error| errors.delete(error) }
    return unless errors.any?
    class_def = options[:class] || 'field-paragraph field-paragraph_danger'
    @template.content_tag :div, "Также: #{errors.full_messages.join('; ')}", class: class_def
  end

  private

  def field_without_errors?(field_name)
    @object.errors[field_name].blank?
  end

  def message(field_name)
    @object.errors[field_name].join(', ').sub(/^./, &:upcase)
  end
end
