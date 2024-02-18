module Customers
  module Orders
    # Controller for managing order items in the customer's order
    class OrderItemsController < ::Orders::OrderItemsController
      before_action :set_order, :last_order_item
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
            count_order_items
              #raise
              if @last_order_item.nil?
                render turbo_stream: turbo_stream.update("order_item", partial: "customers/orders/order_item", locals: { product_counts:  @product_counts })
              else
                if @last_order_item.product.name == @order_item.product.name
                  render turbo_stream: turbo_stream.update("order_item", partial: "customers/orders/order_item", locals: { product_counts: @product_counts })
                else
                  render turbo_stream: turbo_stream.update("order_item", partial: "customers/orders/order_item", locals: { product_counts: @product_counts })
                end
              end
              # if naay existing nga @order_item.product nga similar ug product name
                # render turbo_stream: turbo_stream.update("order_item", partial: "customers/orders/order_item", locals: { order_item: @order_item })
              # else
            end
          end
        end
      end

      private
      
      def count_order_items
        #set_order
        @order_items = @order.order_items.includes(:product)
        @product_counts = @order_items.group_by { |item| item.product.name }.transform_values(&:count)
       end

      # Defines the permitted parameters for creating an order item
      def last_order_item   
        @customer_order_items = Order.includes(:order_items).find(params[:order_id])
        @last_order_item = @customer_order_items.order_items.order('created_at DESC').first
      end

      def order_item_params
        params.require(:order_item).permit(:product_id)
      end

      def set_order
        @order = Order.find(params[:order_id])
      end
    end
  end
end
