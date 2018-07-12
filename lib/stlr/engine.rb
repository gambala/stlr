module Stlr
  class Engine < ::Rails::Engine
    initializer 'stlr.include_view_helpers' do |app|
      ActiveSupport.on_load :action_view do
        include RoutesHelper
      end
    end
  end
end
