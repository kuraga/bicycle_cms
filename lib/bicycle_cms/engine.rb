module BicycleCms
  class Engine < ::Rails::Engine
    isolate_namespace BicycleCms

    initializer 'bicycle_cms.autoload', before: :set_autoload_paths do |app|
      config.i18n.load_path += Dir["#{BicycleCms::Engine.root}/config/locales/**/*.{rb,yml}"]
      config.autoload_paths += Dir[File.expand_path("../app/models", __FILE__) + "/**/*.rb"]
    end

  end
end
