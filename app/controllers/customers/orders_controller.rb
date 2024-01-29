module Customers
  class OrdersController < OrdersController
    before_action :set_order, only: [:show]
    before_action :set_customer_orders, only: [:index, :show]

    def index; end

    def show
      @allProducts = Product.all
      #@products = Product.find_by!(params[:order_item_id])
      @order_items = @order.order_items.includes(:product)
      # @item = @order_items.products
    end

    private

    def set_order
      @order = Order.includes(:order_items).find(params[:id])
    end

    def set_customer_orders
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders
    end
  end
end