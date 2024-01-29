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
        @order_item = @order.order_items.build(order_item_params)

        if @order_item.save
          respond_to do |format|
            format.turbo_stream do
              # if naay existing nga @order_item.product nga similar ug product name
                # render turbo_stream: turbo.update ......
              # else
              render turbo_stream: turbo_stream.append("order_item", partial: "customers/orders/order_item", locals: { order_item: @order_item })
            end
          end
        end
      end

      private

      # Defines the permitted parameters for creating an order item
      def order_item_params
        params.require(:order_item).permit(:product_id)
      end

      def set_order
        @order = Order.find(params[:order_id])
      end
    end
  end
end
