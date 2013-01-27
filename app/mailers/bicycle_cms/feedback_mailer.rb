module BicycleCms
  class FeedbackMailer < AdminMailer

    helper ApplicationHelper # TODO Избавиться. По идее хелпер должен наследоваться

    def feedback_message(feedback)
      @feedback = feedback
      mail from: ActionMailer::Base.email_with_name(@feedback.email, @feedback.name), subject: t('bicycle_cms/feedbacks.messages.create.feedback_created', title: @feedback.title) do |format|
        format.html
      end
    end

  end
end
