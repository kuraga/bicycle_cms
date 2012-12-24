module BicycleCms
  class Engine < ::Rails::Engine
    isolate_namespace BicycleCms

    initializer 'bicycle_cms.autoload', :before => :set_autoload_paths do |app|
      app.config.autoload_paths += Dir["#{Rails.root}/vendor/engines/bicycle_cms/app/models/**/*"]
    end
  end
end
