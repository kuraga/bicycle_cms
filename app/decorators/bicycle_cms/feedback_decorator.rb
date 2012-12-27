module BicycleCms
  class FeedbackDecorator < ApplicationDecorator

    class << self

      include Draper::LazyHelpers # TODO Избавиться

      def breadcrumbs
        [ PageVars::Breadcrumb[title: t('bicycle_cms/feedbacks.main.bicycle_cms/feedbacks'), path: new_feedback_path] ]
      end

    end

    include Rails.application.routes.url_helpers # TODO Избавиться

    def breadcrumbs
      Feedback.breadcrumbs << PageVars::Breadcrumb[title: title, path: feedback_path(self)]
    end

  end
end
