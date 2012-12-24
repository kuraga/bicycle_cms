module BicycleCms
  module Panels
    module ArticlePanel

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :article

      def self.supported_capabilities
        [:new, :edit, :destroy]
      end

    end
  end
end
