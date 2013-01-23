module BicycleCms
  class CategoryDecorator < ApplicationDecorator

    decorates_associations :attachments

    decorates_associations :articles, :products
    # TODO Разобраться с предыдущей строчкой
    # TODO Декорация ancestors ?

    class << self

      include Draper::LazyHelpers # TODO Избавиться

      def breadcrumbs
        []
      end

      def categories_options items = Category.scoped.arrange, block = ->(i) { "#{'-' * i.depth} #{i.title}" }
        items.inject [] do |res, (item, sub_items)|
          res + [ [block.call(item), item.id], *categories_options(sub_items, block) ]
        end
      end

    end

    def breadcrumbs
      ancestors_breadcrumbs = ancestors.collect { |some_category| PageVars::Breadcrumb[title: some_category.title, path: category_path(some_category)] }
      ancestors_breadcrumbs << PageVars::Breadcrumb[title: title, path: category_path(self)]
      ancestors_breadcrumbs.shift
      ancestors_breadcrumbs
    end

    # TODO Выбор возвращаемых параметров (only-except)
    def properties options = {}
      [
        PageVars::Property[name: :description,  label: t('bicycle_cms/categories.attributes.description'),  value: description],
        PageVars::Property[name: :keywords,     label: t('bicycle_cms/categories.attributes.keywords'),     value: keywords   ],
        PageVars::Property[name: :attachments,  label: t('bicycle_cms/attachments.attributes.attachments'), value: attachments.select(&:show_in_list).collect { |attachment| link_with_contenttype_icon attachment }]
      ]
    end

    def possible_ancestries_options items = Category.scoped.arrange, block = ->(i) { "#{'-' * i.depth} #{i.title}" }, ancestries = []
      items.inject [] do |res, (item, sub_items)|
        res + (item == self ? [] : [ [block.call(item), ancestries.blank? ? "#{item.id}" : "#{ancestries.join('/')}/#{item.id}"], *possible_ancestries_options(sub_items, block, ancestries.dup << item.id) ])
      end
    end

  end
end
