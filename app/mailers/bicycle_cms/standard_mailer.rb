module BicycleCms
  class StandardMailer < ActionMailer::Base

    include RenderCallbacks
    include Roler

    default from: "#{self.class.admin_name} <#{self.class.admin_email}>"

    layout 'mail'

    helper ApplicationHelper # TODO Должно быть :all

  end
end
