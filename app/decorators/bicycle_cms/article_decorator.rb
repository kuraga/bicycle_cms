module BicycleCms
  class ArticleDecorator < ApplicationDecorator

    decorates_association :category
    decorates_association :author
    decorates_association :attachments

    class << self

      include Draper::LazyHelpers # TODO Избавиться

      def breadcrumbs
        []
      end

    end

    # TODO Рассчитано на наличие category
    def breadcrumbs
      category.breadcrumbs << PageVars::Breadcrumb[title: title, path: article_path(self)]
    end

    # TODO Выбор возвращаемых параметров (only-except)
    def properties options = {}
      [
        PageVars::Property[ name: :author,       label: t('articles.properties.published_by'),   value: author.fullname ],
        PageVars::Property[ name: :published_at, label: t('articles.properties.published_at'),   value: I18n.localize(published_at, format: :date_full) ],
        PageVars::Property[ name: :description,  label: t('articles.properties.description'),    value: description ],
        PageVars::Property[ name: :keywords,     label: t('articles.properties.keywords'),       value: keywords ],
        PageVars::Property[ name: :attachments,  label: t('attachments.properties.attachments'), value: (attachments.select { |attachment| attachment.show_in_list }).collect { |attachment| link_with_contenttype_icon attachment } ]
      ]
    end

  end
end
