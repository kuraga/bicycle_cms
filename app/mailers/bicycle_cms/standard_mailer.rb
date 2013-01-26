module BicycleCms
  class StandardMailer < ActionMailer::Base

    include RenderCallbacks
    include Roler

    default from: ActionMailer::Base.email_with_name(BicycleCms.admin_email, BicycleCms.admin_name)

    layout 'mail'

    helper ApplicationHelper # TODO Должно быть :all

  end
end
