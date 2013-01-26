module BicycleCms
  class AdminMailer < ActionMailer::Base

    include RenderCallbacks
    include Roler

    default to: ActionMailer::Base.email_with_name(BicycleCms.admin_email, BicycleCms.admin_name)

    layout 'admin_mail'

    helper ApplicationHelper # TODO Должно быть :all

  end
end
