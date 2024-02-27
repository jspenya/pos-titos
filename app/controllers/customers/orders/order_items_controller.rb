module Customers
  module Orders
    # Controller for managing order items in the customer's order
    class OrderItemsController < ::Orders::OrderItemsController
      before_action :set_order

      include Customers::Orders::Renderable

      def new
        @products = Product.available
      end
      def show; end

      def create
        @order_item = @order.order_items.build(order_item_params)

        if @order_item.save
          respond_to do |format|
            format.turbo_stream do
              turbo_render_created_item
            end
          end
        end
      end

      private

      def order_item_params
        params.require(:order_item).permit(:product_id)
      end

      def set_order
        @order = Order.find(params[:order_id])
      end
    end
  end
end
