module Customers
  module Orders
    module Renderable
      extend ActiveSupport::Concern

      def turbo_render_created_item
        total_order_amount
        @grouped_similar_items_in_order ||= grouped_similar_items_in_order

        if similar_items_in_order.exists?
          render turbo_stream: [
            turbo_stream.replace("order_item_product_#{@order_item.product_id}",
              partial: "customers/orders/order_item",
              locals: { grouped_similar_items_in_order: @grouped_similar_items_in_order }),
            turbo_stream.update("order_total", partial: "customers/orders/total_amount",
              locals: { total_order_amount: @total_order_amount })
          ]
        else
          render turbo_stream: [
            turbo_stream.append("order_item",
              partial: "customers/orders/order_item",
              locals: { grouped_similar_items_in_order: @grouped_similar_items_in_order }),
            turbo_stream.update("order_total", partial: "customers/orders/total_amount",
              locals: { total_order_amount: @total_order_amount })
          ]
        end
      end

      private

      def similar_items_in_order
        @similar_items_in_order ||= OrderItem.similar_items_in_order(@order_item.order_id, @order_item.product_id)
      end

      def grouped_similar_items_in_order
        similar_items_in_order.group(:product).count
      end
      def total_order_amount
        @order_items = @order.order_items.includes(:product)
        @total_order_amount = @order.order_items.includes(:product).sum("products.price")
      end
    end
  end
end