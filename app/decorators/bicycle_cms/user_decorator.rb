module BicycleCms
  class UserDecorator < ApplicationDecorator

    class << self

      include Draper::LazyHelpers # TODO Избавиться

      def breadcrumbs
        [ PageVars::Breadcrumb[title: t('users.main.users'), path: users_path] ]
      end

    end

    def breadcrumbs
      User.breadcrumbs << PageVars::Breadcrumb[title: user.fullname, path: user_path(self)]
    end


    def fullname make_links = true
      (make_links ? link_to(self.name, user_path(self)) : self.name).html_safe
    end

  end
end
