# frozen_string_literal: true

module NavigationHelper
  def li_link_to(*args, &block)
    label       =  block_given? ? nil     : args[0]
    route       =  block_given? ? args[0] : args[1]
    html_params = (block_given? ? args[1] : args[2]) || {}
    css_class   =  html_params.delete(:class)
    route_match =  html_params.delete(:route_match)
    html_params[:class] = nav_class(route, css_class, route_match: route_match)

    args = block_given? ? [route, html_params] : [label, route, html_params]
    content_tag :li, class: html_params[:class] do
      link_to(*args, &block)
    end
  end

  def nav_class(route, css_class = nil, route_match: :partial)
    return css_class unless route_matches?(route, route_match: route_match)
    return 'active' if css_class.nil?
    "#{css_class} #{active(css_class)} active"
  end

  def nav_link_to(*args, &block)
    label       =  block_given? ? nil     : args[0]
    route       =  block_given? ? args[0] : args[1]
    html_params = (block_given? ? args[1] : args[2]) || {}
    css_class   =  html_params.delete(:class)
    route_match =  html_params.delete(:route_match)
    html_params[:class] = nav_class(route, css_class, route_match: route_match)

    if route_matches?(route, route_match: :exact)
      content_tag(:div, block_given? ? capture(&block) : label, html_params)
    else
      args = block_given? ? [route, html_params] : [label, route, html_params]
      link_to(*args, &block)
    end
  end

  def route_matches?(route, route_match: :partial)
    if route_match.respond_to? :call
      route_match.call(request.fullpath, url_for(route))
    elsif route_match == :exact
      request.fullpath == url_for(route)
    else
      request.fullpath.include? url_for(route)
    end
  end

  private

  def active(css_class)
    css_class.split.map { |c| "#{c}_active" }.join(' ')
  end
end
