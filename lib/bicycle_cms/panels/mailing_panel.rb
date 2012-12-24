module BicycleCms
  module Panels
    module MailingPanel

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :mailing, [:destroy]

      def self.supported_capabilities
        [:destroy]
      end

    end
  end
end
