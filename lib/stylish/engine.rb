module Stylish
  class Engine < ::Rails::Engine
    initializer 'stylish.developer_mode' do |app|
      sprockets = app.assets

      Stylish::Developer.config do |cfg|
        cfg.root = app.root
        cfg.environment = sprockets
      end
    end
  end
end
