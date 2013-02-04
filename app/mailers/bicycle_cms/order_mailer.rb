module BicycleCms
  class OrderMailer < StandardMailer

    helper ApplicationHelper # TODO Избавиться. По идее хелпер должен наследоваться

    def order_message(order)
      @order = order
      mail to: "#{@order.name} <#{@orser.email}>", subject: t('bicycle_cms/orders.messages.create.order_created') do |format|
        format.html
      end
    end

  end
end
