module BicycleCms
  class FeedbackMailer < AdminMailer

    helper ApplicationHelper # TODO Избавиться. По идее хелпер должен наследоваться

    def feedback_message(feedback)
      @feedback = feedback
      mail from: "#{@feedback.name} <#{@feedback.email}>", subject: t('bicycle_cms/feedbacks.messages.create.feedback_created', title: @feedback.title) do |format|
        format.html
      end
    end

  end
end
