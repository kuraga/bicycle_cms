module BicycleCms
  module Panels
    module FeedbackReplyPanel

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :feedback_reply, [:destroy]

      def self.supported_capabilities
        [:destroy]
      end

    end
  end
end
