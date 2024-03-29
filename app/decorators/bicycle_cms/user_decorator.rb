module BicycleCms
  class UserDecorator < ApplicationDecorator

    class << self

      include Draper::LazyHelpers # TODO Избавиться

      def breadcrumbs
        [ PageVars::Breadcrumb[title: t('bicycle_cms/users.main.bicycle_cms/users'), path: users_path] ]
      end

    end

    def breadcrumbs
      UserDecorator.breadcrumbs << PageVars::Breadcrumb[title: fullname, path: user_path(self)]
    end

    def fullname(make_links = true)
      ( make_links ? link_to(name, user_path(self) ) : name).html_safe
    end

  end
end
