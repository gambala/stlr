module I18nHelper
  def formatted(value)
    return '' if value.blank?
    return value.in_time_zone if value.is_a?(Time)

    if value.is_a?(String)
      return value.html_safe if value.include?("<p>")
      return simple_format(value) if value.include?("\n")
    end

    value
  end

  def t(key, options = {})
    result = super(key, options)
    result = super(key, options.merge(locale: I18n.default_locale)) if result.blank?
    formatted result
  end

  def i18n_t(key, options = {})
    locale = options[:locale] || I18n.locale
    result = I18nTranslation.find_by(locale: locale, key: key).try(:value)

    if result.blank?
      return '' if options[:locale].present?

      result = if options[:record].has_attribute?(options[:field])
                 options[:record].public_send(options[:field])
               else
                 I18nTranslation.find_by(locale: I18n.default_locale, key: key).try(:value)
               end
    end

    formatted result
  end
end
