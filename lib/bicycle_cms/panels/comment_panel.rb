module BicycleCms
  module Panels
    module CommentPanel

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :comment

      def self.supported_capabilities
        [:edit, :destroy]
      end

    end
  end
end
