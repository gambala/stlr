# frozen_string_literal: true

module WithI18nFields
  extend ActiveSupport::Concern
  include ActionView::Helpers::TextHelper
  include I18nHelper

  included do
    after_commit :create_translations, on: :create

    scope :translated, (lambda do |locale = I18n.locale|
      ids = select { |record| record.translated?(locale) }.map(&:id)
      where(id: ids)
    end)

    def create_translations
      I18nLanguage.all.pluck(:locale).each do |locale|
        i18n_fields.each do |field|
          I18nTranslation.where(locale: locale, key: i18n_key(field)).first_or_create!
        end
      end
    end

    def i18n_fields
      self.class.i18n_fields
    end

    def i18n_key(field = nil)
      result = "#{self.class.i18n_key_prefix}.id_#{id}"
      result += ".#{field}" if field.present?
      result
    end

    def translated?(locale = I18n.locale)
      i18n_fields.each { |field| return false if public_send("i18n_#{field}", locale).blank? }
      true
    end

    def translations=(value)
      return if value.blank?

      value.each do |locale, fields|
        fields.each do |field, translation|
          I18nTranslation.find_by(locale: locale, key: i18n_key(field)).update(value: translation)
        end
      end
    end
  end

  class_methods do
    def i18n_fields(*args)
      return @i18n_fields if args.empty?

      options = args.extract_options!
      @i18n_fields = args

      @i18n_fields.each do |field|
        define_method("i18n_#{field}") do |locale = nil|
          i18n_t i18n_key(field), locale: locale, record: self, field: field
        end
      end
    end

    def i18n_key_prefix
      "activerecord.values.#{model_name.i18n_key}"
    end
  end
end
