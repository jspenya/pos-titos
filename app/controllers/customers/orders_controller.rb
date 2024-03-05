module Customers
  class OrdersController < OrdersController
    before_action :set_orders, only: [:index, :show]
    before_action :set_similar_items_in_order, only: [:show]
    def index; end

    def show
      @allProducts = Product.all
      @order_items = @order.order_items.includes(:product)
      @total_order_amount = @order.order_items.includes(:product).sum("products.price")
      @last_order_item = @order.order_items.last
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "testing",
          template: 'customers/orders/show',
          formats: [:html],
          pagesize: "letter",
          layout: "pdf",
          encoding: "UTF-8",
          viewport_size: '1280x1024'
        end
      end
    end

    private

    def set_similar_items_in_order
      @order_items = @order.order_items
      @grouped_similar_items_in_order = @order_items.similar_items_in_order(@order.id)
                                            .group(:product).count
    end

    def set_orders
      @customer = Customer.includes(:orders).find(params[:customer_id])
      @orders = @customer.orders.where(user_id: current_user.id).includes(:order_items)
    end
  end
end