module Customers
  module Orders
    # Controller for managing order items in the customer's order
    class OrderItemsController < ::Orders::OrderItemsController
      before_action :set_order

      include Customers::Orders::Renderable

      def new
        @products = Product.available
      end

      def create
        @order_item = @order.order_items.build(order_item_params)

        if @order_item.save
          respond_to do |format|
            format.turbo_stream { turbo_render_order_items }
          end
        end
      end

      def destroy
        @order_item = @order.order_items.where(product_id: params[:product_id]).first

        @order_item.destroy!

        respond_to do |format|
          format.turbo_stream { turbo_render_order_items }
        end
      end

      private

      def order_item_params
        params.require(:order_item).permit(:product_id)
      end

      def set_order
        @customer = Customer.includes(:orders).find(params[:customer_id])
        @order = @customer.orders.includes(:order_items).find(params[:order_id])
      end
    end
  end
end
