module WithBreadcrumbs
  extend ActiveSupport::Concern

  included do
    helper_method :add_breadcrumb, :breadcrumbs

    def add_breadcrumb(label, route)
      return if label.blank? || route.blank?
      breadcrumbs << { label: label, route: route }
    end

    def breadcrumbs
      @breadcrumbs ||= []
    end
  end
end
