module I18nFields
  def i18n_fields(*args)
    return @i18n_fields if args.empty?

    include ActionView::Helpers::TextHelper
    include I18nHelper

    options = args.extract_options!
    @i18n_fields = args

    after_commit :create_translations, on: :create

    scope :translated, (lambda do |locale = I18n.locale|
      ids = select { |record| record.translated?(locale) }.map(&:id)
      where(id: ids)
    end)

    define_method :create_translations do
      I18nLanguage.all.pluck(:locale).each do |locale|
        i18n_fields.each do |field|
          I18nTranslation.where(locale: locale, key: i18n_key(field)).first_or_create!
        end
      end
    end

    define_method :i18n_fields do
      self.class.i18n_fields
    end

    define_method :i18n_key do |field = nil|
      result = "#{self.class.i18n_key_prefix}.id_#{id}"
      result += ".#{field}" if field.present?
      result
    end

    define_method :translated? do |locale = I18n.locale|
      i18n_fields.each { |field| return false if public_send(field, locale).blank? }
      true
    end

    define_method :translations= do |value|
      return if value.blank?

      value.each do |locale, fields|
        fields.each do |field, translation|
          I18nTranslation.find_by(locale: locale, key: i18n_key(field)).update(value: translation)
        end
      end
    end

    @i18n_fields.each do |field|
      define_method(field) { |locale = nil| i18n_t(i18n_key(field), locale: locale) }
    end
  end

  def i18n_key_prefix
    "activerecord.values.#{model_name.i18n_key}"
  end
end
