module BreadcrumbsHelper
  def render_breadcrumbs
    return if breadcrumbs.empty?

    content_tag :div, class: 'breadcrumb-list' do
      breadcrumbs.each_with_index do |breadcrumb, index|
        if index + 1 == breadcrumbs.size
          concat content_tag :div, breadcrumb[:label], class: 'breadcrumb-item'
        else
          concat link_to breadcrumb[:label], breadcrumb[:route], class: 'breadcrumb-item'
        end
      end
    end
  end
end
