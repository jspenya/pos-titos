module Customers
  class OrdersController < OrdersController
    before_action :set_customer_orders, only: [:index, :show]
    def index; end

    def show
      @order_items = @order.order_items
      @products = Product.available
    end

    private

    def set_customer_orders
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders
    end
  end
end
