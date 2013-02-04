module BicycleCms
  class StandardMailer < ActionMailer::Base

    include RenderCallbacks
    include Roler

    default from: ActionMailer::Base.email_with_name(self.class.admin_email, self.class.admin_name)

    layout 'mail'

    helper ApplicationHelper # TODO Должно быть :all

  end
end
