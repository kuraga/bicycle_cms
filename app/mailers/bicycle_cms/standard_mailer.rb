module BicycleCms
  class StandardMailer < ActionMailer::Base

    include RenderCallbacks
    include Roler

    default from: "#{BicycleCms.admin_name} <#{BicycleCms.admin_email}>"

    layout 'mail'

    helper ApplicationHelper # TODO Должно быть :all

  end
end
