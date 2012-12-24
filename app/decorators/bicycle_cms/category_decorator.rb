module BicycleCms
  class CategoryDecorator < ApplicationDecorator

    decorates_association :attachments
    decorates_association :articles
    decorates_association :products
    # TODO Декорация ancestors ?

    class << self

      include Draper::LazyHelpers # TODO Избавиться

      def breadcrumbs
        []
      end

      def root_category
        find(1)
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
        PageVars::Property[ name: :description,  label: t('bicycle_cms/categories.attributes.description'),   value: description ],
        PageVars::Property[ name: :keywords,     label: t('bicycle_cms/categories.attributes.keywords'),      value: keywords ],
        PageVars::Property[ name: :attachments,  label: t('bicycle_cms/attachments.attributes.attachments'), value: (attachments.select { |attachment| attachment.show_in_list }).collect { |attachment| link_with_contenttype_icon attachment } ]
      ]
    end

    def possible_ancestries_options(items, ancestries = [], block)
      items.inject [] do |res, (item, sub_items)|
        item == self ? [] : [ [block.call(item), ancestries.blank? ? "#{item.id}" : "#{ancestries.join('/')}/#{item.id}"], *possible_ancestries_options(sub_items, ancestries << item.id, block) ]
      end
    end

  end
end
