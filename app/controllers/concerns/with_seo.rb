module WithSeo
  extend ActiveSupport::Concern
  include ActionView::Helpers::TagHelper

  included do
    class_attribute :attr_description,
                    :attr_image,
                    :attr_keywords,
                    :attr_modified_time,
                    :attr_og_author,
                    :attr_pagetype,
                    :attr_published_time,
                    :attr_site_image,
                    :attr_robots,
                    :attr_title
    helper_method :description,
                  :image,
                  :keywords,
                  :modified_time,
                  :og_author,
                  :pagetype,
                  :published_time,
                  :robots,
                  :title
    helper_method :meta_for_article,
                  :meta_for_description,
                  :meta_for_image,
                  :meta_for_keywords,
                  :meta_for_pagetype,
                  :meta_for_robots,
                  :meta_for_site_name,
                  :meta_for_title,
                  :meta_for_url
    helper_method :title_tag

    # Setters

    def description(value)
      self.attr_description = value.to_s
    end

    def image(value)
      self.attr_image = value.to_s
    end

    def keywords(value)
      self.attr_keywords = value.to_s
    end

    def modified_time(value)
      return if value.blank?
      self.attr_modified_time = value.iso8601
    end

    def og_author(value)
      self.attr_og_author = value
    end

    def pagetype(value)
      self.attr_pagetype = value.to_s
    end

    def published_time(value)
      return if value.blank?
      self.attr_published_time = value.iso8601
    end

    def robots(value)
      self.attr_robots = value.to_s
    end

    def title(value = nil, &block)
      self.attr_title = block_given? ? capture(&block) : value.to_s
    end

    # Getters with meta prefix

    def meta_for_article
      return if attr_pagetype.blank?
      return if attr_pagetype != 'article'

      if attr_published_time.present?
        concat content_tag :meta, nil,
                           content: attr_published_time,
                           property: 'article:published_time'
      end

      if attr_modified_time.present?
        concat content_tag :meta, nil,
                           content: attr_modified_time,
                           property: 'article:modified_time'
      end

      if attr_og_author.present?
        content_tag :meta, nil,
                    content: attr_og_author.join(', '),
                    property: 'article:author'
      end
    end

    def meta_for_description
      return if attr_description.blank?
      concat content_tag :meta, nil, content: attr_description, name: 'description'
      content_tag :meta, nil, content: attr_description, property: 'og:description'
    end

    def meta_for_image
      return if page_image.blank?
      content_tag :meta, nil, content: page_image, property: 'og:image'
    end

    def meta_for_keywords
      return if attr_keywords.blank?
      content_tag :meta, nil, content: attr_keywords, name: 'keywords'
    end

    def meta_for_pagetype
      return if attr_pagetype.blank?
      content_tag :meta, nil, content: attr_pagetype, property: 'og:type'
    end

    def meta_for_robots
      return if attr_robots.blank?
      content_tag :meta, nil, content: attr_robots, name: 'robots'
    end

    def meta_for_site_name
      content_tag :meta, nil, content: site_name, property: 'og:site_name'
    end

    def meta_for_title
      return if attr_title.blank?
      content_tag :meta, nil, content: attr_title, property: 'og:title'
    end

    def meta_for_url
      content_tag :meta, nil, content: request.original_url, property: 'og:url'
    end

    def meta_html_prefix
      return if attr_pagetype.blank?
      return unless attr_pagetype.in? %w(article)
      ['og: http://ogp.me/ns#',
       "#{attr_pagetype}: http://ogp.me/ns/#{attr_pagetype}#"].join(' ')
    end

    # Getters with tag suffix

    def title_tag
      content_tag :title, attr_title.presence || site_name
    end

    # Other helpers

    def text_from_html(value)
      return nil if value.blank?
      value = strip_tags(value)
      value = truncate(value, length: 150)
      value = value.gsub(/\n\n+/, '\n').gsub(/^\n|\n$/, ' ').squish
      value
    end

    private

    def page_image
      attr_image.presence || site_image
    end

    def site_image
      attr_site_image
    end

    def site_name
      t('site.title')
    end
  end

  module ClassMethods
    # og_author %w(https://www.facebook.com/author_profile https://vk.com/author_profile)
    def og_author(value)
      self.attr_og_author = value
    end

    # site_image ActionController::Base.helpers.image_url('default-image.png')
    def site_image(value)
      self.attr_site_image = value
    end
  end
end
