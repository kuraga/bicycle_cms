module BicycleCms
  class CommentDecorator < ApplicationDecorator

    decorates_association :author
    decorates_association :commentable, with: BicycleCms::Article #XYZ

    class << self

      include Draper::LazyHelpers # TODO Избавиться

      # TODO Рассчитано на наличие commentable
      def breadcrumbs commentable
        [ PageVars::Breadcrumb[title: t('bicycle_cms/comments.main.bicycle_cms/comments'), path: polymorphic_path([commentable, Comment])] ]
      end

    end

    def breadcrumbs
      commentable.breadcrumbs + Comment.breadcrumbs(commentable) << PageVars::Breadcrumb[title: title, path: polymorphic_path([commentable, self])]
    end

    def title
      'TODO' # TODO
    end

  end
end
