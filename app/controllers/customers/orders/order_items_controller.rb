module Customers
  module Orders
    # Controller for managing order items in the customer's order
    class OrderItemsController < ::Orders::OrderItemsController
      before_action :set_order
      # Displays the form for creating a new order item
      def new
        @products = Product.available
      end

      def show

      end

      # Creates a new order item
      def create
        @order_item = @order.order_items.new(order_item_params)

        #puts "PARAMS: #{params}"
        respond_to do |format|
          format.html { redirect_to customer_order_path, notice: "Product was successfully added." }
          #format.json { render :show, status: :created, location: @order }
          #format.turbo_stream
        end
      end

      private

      # Defines the permitted parameters for creating an order item
      def order_item_params
        params.require(:order_item).permit(:product_id, :quantity)
      end
      
      def set_order
        @order = Order.find(params[:order_id])
      end
    end
  end
end
