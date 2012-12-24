module BicycleCms
  class OrderMailer < StandardMailer
    # TODO Избавиться от использования метода email_with_name

    def order_message order
      @order = order
      mail to: ActionMailer::Base.email_with_name(@order.email, @order.name), subject: t('orders.messages.create.order_created') do |format|
        format.html
      end
    end

  end
end
