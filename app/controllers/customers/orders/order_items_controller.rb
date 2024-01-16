module Customers
  module Orders
    # Controller for managing order items in the customer's order
    class OrderItemsController < ::Orders::OrderItemsController
      # Displays the form for creating a new order item
      def new
        @products = Product.available
      end

      # Creates a new order item
      def create
        @order_item = OrderItem.create!(order_item_params)

        puts "PARAMS: #{params}"
        respond_to do |format|
          format.html {  }
          format.turbo_stream
        end
      end

      private

      # Defines the permitted parameters for creating an order item
      def order_item_params
        params.permit(:product_id, :order_id)
      end
    end
  end
end
