module BicycleCms
  module Panels
    module EventPanel

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :event

      def self.supported_capabilities
        [:new, :edit, :destroy]
      end

    end
  end
end
