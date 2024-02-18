module Customers
  class OrdersController < OrdersController
    before_action :set_order, only: [:show]
    before_action :set_customer_orders, only: [:index, :show]
    before_action :count_order_items, only: [:show]
    def index; end

    def show
      @allProducts = Product.all
      #@products = Product.find_by!(params[:order_item_id])
      @order_items = @order.order_items.includes(:product)
      # @item = @order_items.products
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
     def count_order_items
      #set_order
      @order_items = @order.order_items.includes(:product)
      @product_counts = @order_items.group_by { |item| item.product.name }.transform_values(&:count)
     end

    def set_order
      @order = Order.includes(:order_items).find(params[:id])
    end

    def set_customer_orders
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders
    end
  end
end