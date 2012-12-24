module BicycleCms
  module Panels
    module FeedbackPanel

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :feedback, [:destroy]

      def self.supported_capabilities
        [:reply, :destroy]
      end

      def reply_feedback_link feedback
        link_to t('feedbacks.actions_short.reply'), feedback
      end

    end
  end
end
