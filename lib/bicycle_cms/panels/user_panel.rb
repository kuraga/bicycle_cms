module BicycleCms
  module Panels
    module UserPanel

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :user

      def self.supported_capabilities
        [:edit, :destroy]
      end

    end
  end
end
