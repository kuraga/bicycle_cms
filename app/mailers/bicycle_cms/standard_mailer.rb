module BicycleCms
  class StandardMailer < ActionMailer::Base

    default from: ActionMailer::Base.email_with_name(BicycleCms.admin_email, BicycleCms.admin_name)

    layout 'mail'

    helper :application # TODO Должно быть :all

  end
end
