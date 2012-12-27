module BicycleCms
  module Panels
    module FeedbackPanel

      # TODO Как правильно вызывать?
      Panels.define_default_action_links_for :feedback, [:destroy]

    end
  end
end
