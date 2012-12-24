module BicycleCms
  class StandardMailer < ActionMailer::Base
    # TODO Избавиться от использования метода email_with_name

    default from: ActionMailer::Base.email_with_name(configatron.admin_email, configatron.admin_name)

    layout 'mail'

    helper :application # TODO Должно быть :all

  end
end
