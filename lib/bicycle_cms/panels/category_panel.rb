module BicycleCms
  module Panels
    module CategoryPanel
      # TODO Создание статьи

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :category

      def self.supported_capabilities
        [:new, :edit, :destroy]
      end

    end
  end
end
