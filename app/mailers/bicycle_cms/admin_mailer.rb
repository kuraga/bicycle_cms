module BicycleCms
  class AdminMailer < ActionMailer::Base
    # TODO Избавиться от использования метода email_with_name

    default to: ActionMailer::Base.email_with_name(configatron.admin_email, configatron.admin_name)

    layout 'mail_admin'

    helper :application # TODO Должно быть :all

  end
end
