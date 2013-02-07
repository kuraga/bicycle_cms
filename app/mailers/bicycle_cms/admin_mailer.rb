module BicycleCms
  class AdminMailer < ActionMailer::Base

    include RenderCallbacks
    include Roler

    default to: "#{BicycleCms.admin_name} <#{BicycleCms.admin_email}>"

    layout 'admin_mail'

    helper ApplicationHelper # TODO Должно быть :all

  end
end
