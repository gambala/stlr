module WithSeo
  extend ActiveSupport::Concern

  included do
    class_attribute :attr_description,
                    :attr_keywords,
                    :attr_modified_time,
                    :attr_og_author,
                    :attr_page_image,
                    :attr_pagetype,
                    :attr_published_time,
                    :attr_robots,
                    :attr_site_image,
                    :attr_title
    helper_method :description,
                  :keywords,
                  :modified_time,
                  :og_author,
                  :page_image,
                  :pagetype,
                  :published_time,
                  :robots,
                  :site_image,
                  :title

    def description(value = nil)
      return attr_description if value.blank?
      self.attr_description = value.to_s
    end

    def keywords(value = nil)
      return attr_keywords if value.blank?
      self.attr_keywords = value.to_s
    end

    def modified_time(value = nil)
      return attr_modified_time if value.blank?
      self.attr_modified_time = value.iso8601
    end

    def og_author(value = nil)
      return attr_og_author if value.blank?
      self.attr_og_author = value
    end

    def page_image(value = nil)
      return attr_page_image.presence || site_image if value.blank?
      self.attr_page_image = value.to_s
    end

    def pagetype(value = nil)
      return attr_pagetype if value.blank?
      self.attr_pagetype = value.to_s
    end

    def published_time(value = nil)
      return attr_published_time if value.blank?
      self.attr_published_time = value.iso8601
    end

    def robots(value = nil)
      return attr_robots if value.blank?
      self.attr_robots = value.to_s
    end

    def site_image(value = nil)
      return attr_site_image if value.blank?
      self.attr_site_image = value
    end

    def title(value = nil, &block)
      return attr_title if value.blank? && !block_given?
      self.attr_title = block_given? ? capture(&block) : value.to_s
    end
  end

  module ClassMethods
    # og_author %w(https://www.facebook.com/author_profile https://vk.com/author_profile)
    def og_author(value = nil)
      return attr_og_author if value.blank?
      self.attr_og_author = value
    end

    # site_image ActionController::Base.helpers.image_url('default-image.png')
    def site_image(value = nil)
      return attr_site_image if value.blank?
      self.attr_site_image = value
    end
  end
end
