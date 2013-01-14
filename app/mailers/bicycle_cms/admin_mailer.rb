module BicycleCms
  class AdminMailer < ActionMailer::Base

    default to: ActionMailer::Base.email_with_name(BicycleCms.admin_email, BicycleCms.admin_name)

    layout 'mail_admin'

    helper :application # TODO Должно быть :all

  end
end
