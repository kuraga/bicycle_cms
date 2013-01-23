module BicycleCms
  class OrdersController < ApplicationController

    respond_to :html
    inherit_resources
    actions :all, only: [:show, :new, :create, :destroy]
    # FIXME page_vars
    custom_actions resource: [:add, :update, :delete, :delete_product_inclusion]
    before_filter :define_order, except: :create

    def add
      order << params[:order_item]
      redirect_to order_path
    end

    def update
      id = params[:order_item].delete(:id)
      order.update id, params[:order_item]
      redirect_to order_path
    end

    def delete
      order.delete params[:id]
      redirect_to order_path
    end

    def destroy
      order.clear
      redirect_to order_path
    end

    def new
      redirect_to(order_path) and return if order.blank?
      new!
    end

    def create
      # TODO Подумать, эти две строчки кривоваты
      build_resource
      @order.items = order.items

      create! do |success,failure|
        success.any do
          order.clear
          # TODO оплата и т.п.
          redirect_to root_path
        end
      end
    end

    def delete_product_inclusions
      order.delete_product_inclusions params[:id]
      redirect_to order_path
    end

    protected

      def order
        session[:order] ||= Order.new
      end

      def define_order
        @order = order
      end

  end
end
