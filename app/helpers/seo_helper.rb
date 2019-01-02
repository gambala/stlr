module SeoHelper
  def meta_for_article
    return if pagetype.blank?
    return if pagetype != 'article'

    if published_time.present?
      concat content_tag :meta, nil,
                         content: published_time,
                         property: 'article:published_time'
    end

    if modified_time.present?
      concat content_tag :meta, nil,
                         content: modified_time,
                         property: 'article:modified_time'
    end

    if og_author.present?
      content_tag :meta, nil,
                  content: og_author.join(', '),
                  property: 'article:author'
    end
  end

  def meta_for_description
    return if description.blank?
    concat content_tag :meta, nil, content: description, name: 'description'
    content_tag :meta, nil, content: description, property: 'og:description'
  end

  def meta_for_image
    return if page_image.blank?
    content_tag :meta, nil, content: page_image, property: 'og:image'
  end

  def meta_for_keywords
    return if keywords.blank?
    content_tag :meta, nil, content: keywords, name: 'keywords'
  end

  def meta_for_pagetype
    return if pagetype.blank?
    content_tag :meta, nil, content: pagetype, property: 'og:type'
  end

  def meta_for_robots
    return if robots.blank?
    content_tag :meta, nil, content: robots, name: 'robots'
  end

  def meta_for_site_name
    content_tag :meta, nil, content: site_name, property: 'og:site_name'
  end

  def meta_for_title
    return if title.blank?
    content_tag :meta, nil, content: title, property: 'og:title'
  end

  def meta_for_url
    content_tag :meta, nil, content: request.original_url, property: 'og:url'
  end

  def meta_html_prefix
    return if pagetype.blank?
    return unless pagetype.in? %w(article)
    ['og: http://ogp.me/ns#',
     "#{pagetype}: http://ogp.me/ns/#{pagetype}#"].join(' ')
  end

  def text_from_html(value)
    return nil if value.blank?
    value = strip_tags(value)
    value = truncate(value, length: 150, escape: false)
    value = value.gsub(/\n\n+/, '\n').gsub(/^\n|\n$/, ' ').squish
    value
  end

  def title_tag
    content_tag :title, title.presence || site_name
  end

  private

  def site_name
    t('site.title')
  end
end
