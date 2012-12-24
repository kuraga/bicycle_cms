module BicycleCms
  class EventDecorator < ApplicationDecorator

    decorates_association :attachments

    class << self

      include Draper::LazyHelpers # TODO Избавиться

      def breadcrumbs
        [ PageVars::Breadcrumb[title: t('events.main.events'), path: events_path] ]
      end

    end

    def breadcrumbs
      breadcrumbs << PageVars::Breadcrumb[title: title, path: event_path(self)]
    end


    # TODO Выбор возвращаемых параметров (only-except)
    def properties options = {}
      [
        PageVars::Property[ name: :published_at, label: t('events.properties.published_at'),   value: I18n.localize(published_at, format: :date_full) ],
        PageVars::Property[ name: :attachments,  label: t('attachments.properties.attachments'), value: (attachments.select { |attachment| attachment.show_in_list }).collect { |attachment| link_with_contenttype_icon attachment } ]
      ]
    end

  end
end
