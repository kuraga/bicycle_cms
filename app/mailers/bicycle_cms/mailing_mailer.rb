module BicycleCms
  class MailingMailer < StandardMailer

    helper ApplicationHelper # TODO Избавиться. По идее хелпер должен наследоваться

    def mailing_message(mailing, user)
      @mailing, @user = mailing, user
      mail to: "#{@user.name} <#{@user.email}>", subject: t('bicycle_cms/mailings.messages.create.mailing_created', title: @mailing.title) do |format|
        format.html
      end
    end

  end
end
