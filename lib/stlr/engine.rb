module Stlr
  module Rails
    class Engine < ::Rails::Engine
      initializer 'stlr.assets.precompile' do |app|
        app.config.assets.paths << root.join('assets', 'stylesheets').to_s
      end
    end
  end
end
