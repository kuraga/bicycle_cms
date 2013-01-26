module BicycleCms
  class OrderMailer < StandardMailer

    helper ApplicationHelper # TODO Избавиться. По идее хелпер должен наследоваться

    def order_message order
      @order = order
      mail to: ActionMailer::Base.email_with_name(@order.email, @order.name), subject: t('bicycle_cms/orders.messages.create.order_created') do |format|
        format.html
      end
    end

  end
end
