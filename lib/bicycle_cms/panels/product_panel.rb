module BicycleCms
  module Panels
    module ProductPanel

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :product

      def self.supported_capabilities
        [:new, :edit, :destroy]
      end

    end
  end
end
