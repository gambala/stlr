module I18nHelper
  def formatted(value)
    return '' if value.blank?
    return value.in_time_zone if value.is_a?(Time)
    return value.html_safe if value.include?("<p>")
    return simple_format(value) if value.include?("\n")
    value
  end

  def t(key, options = {})
    result = super(key, options)
    result = super(key, options.merge(locale: :en)) if result.blank?
    formatted result
  end

  def i18n_t(key, options = {})
    return '' if options[:locale].present? && !i18n_exists?(key, options[:locale])
    result = I18n.t(key, options)
    result = '' if result.try(:include?, 'translation missing')
    formatted result
  end

  def i18n_exists?(key, locale)
    I18nTranslation.find_by(key: key, locale: locale).try(:value).present?
  end
end
