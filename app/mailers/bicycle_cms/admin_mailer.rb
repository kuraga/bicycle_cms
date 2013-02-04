module BicycleCms
  class AdminMailer < ActionMailer::Base

    include RenderCallbacks
    include Roler

    default to: "#{self.class.admin_name} <#{self.class.admin_email}>"

    layout 'admin_mail'

    helper ApplicationHelper # TODO Должно быть :all

  end
end
