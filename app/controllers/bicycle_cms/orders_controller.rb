module BicycleCms
  class OrdersController < ApplicationController

    respond_to :html
    respond_to :js
    actions :all, only: [:new, :create]
    page_vars
    custom_actions resource: [:add, :clean]
    before_filter :define_order, except: :create #XYZ

    def show
    end

    def add
      order.add params[:id], (params[:quantity] || 1)
    end

    def update
      @item = order[params[:id]]
      order.set_product_params params[:id], params[:item]
      redirect_to show_order_path
    end

    def destroy
      @item = order[params[:id]]
      order.remove params[:id]
      redirect_to show_order_path
    end

    def clean
      order.clean
      redirect_to(root_path)
    end

    def create
      #XYZ Сущий бред вышел
      object = build_resource
      @order.items = order.items
      create! do |success,failure|
        @products = []
        @order.items.each { |product_id, product_item| @products << Product.find(product_id) }
        @total_price = @products.inject(0) { |total, product| total+product.price*@order[product.id][:quantity].to_i }.round(2)
        success.any do
          order.clean
          #XYZ @order.deliver
          redirect_to(root_path)
        end
      end
    end

    protected

      def order
        session[:order] ||= Order.new
      end

      def define_order
        @order = order
        @products = []
        @order.items.each { |product_id, product_item| @products << Product.find(product_id).decorate }
        @total_price = @products.inject(0) { |total, product| total+product.price*@order[product.id][:quantity].to_i }.round(2)
      end

  end
end
