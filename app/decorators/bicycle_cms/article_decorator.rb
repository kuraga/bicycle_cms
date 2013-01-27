module BicycleCms
  class ArticleDecorator < ApplicationDecorator

    decorates_associations :category, :author, :attachments, :comments

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
    def properties(options = {})
      [
        PageVars::Property[name: :author,       label: t('bicycle_cms/articles.attributes.published_by'),   value: author.fullname                    ],
        PageVars::Property[name: :published_at, label: t('bicycle_cms/articles.attributes.published_at'),   value: l(published_at, format: :date_full)],
        PageVars::Property[name: :description,  label: t('bicycle_cms/articles.attributes.description'),    value: description                        ],
        PageVars::Property[name: :keywords,     label: t('bicycle_cms/articles.attributes.keywords'),       value: keywords                           ],
        PageVars::Property[name: :attachments,  label: t('bicycle_cms/attachments.attributes.attachments'), value: (attachments.select { |attachment| attachment.show_in_list }).collect { |attachment| link_with_contenttype_icon attachment }]
      ]
    end

  end
end
