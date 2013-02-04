module BicycleCms
  class AdminMailer < ActionMailer::Base

    include RenderCallbacks
    include Roler

    default to: ActionMailer::Base.email_with_name(self.class.admin_email, self.class.admin_name)

    layout 'admin_mail'

    helper ApplicationHelper # TODO Должно быть :all

  end
end
