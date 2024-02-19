module Customers
  module Orders
    module Renderable
      extend ActiveSupport::Concern

      def turbo_render_created_item
        @grouped_similar_items_in_order ||= grouped_similar_items_in_order

        if similar_items_in_order.exists?
          render turbo_stream: turbo_stream.replace("order_item_product_#{@order_item.product_id}",
          partial: "customers/orders/order_item",
          locals: { grouped_similar_items_in_order: @grouped_similar_items_in_order })
        else
          render turbo_stream: turbo_stream.append("order_item",
          partial: "customers/orders/order_item",
          locals: { grouped_similar_items_in_order: @grouped_similar_items_in_order })
        end
      end

      private

      def similar_items_in_order
        @similar_items_in_order ||= OrderItem.similar_items_in_order(@order_item.order_id, @order_item.product_id)
      end

      # Return object sample:
      #   {#<Product:0x00007f7688d78970
      #   id: 2, ... > => 4,
      # #<Product:0x00007f7688d78858
      #   id: 3, ... > => 3}
      def grouped_similar_items_in_order
        similar_items_in_order.group(:product).count
      end
    end
  end
end