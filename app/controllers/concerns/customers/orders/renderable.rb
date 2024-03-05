module Customers
  module Orders
    module Renderable
      extend ActiveSupport::Concern

      def turbo_render_order_items
        total_order_amount
        @grouped_similar_items_in_order ||= grouped_similar_items_in_order
        # binding.break

        unless @order_item.previous_changes[:id].blank?
          render turbo_stream: [
            turbo_stream.append("order_item",
              partial: "customers/orders/order_item",
              locals: { grouped_similar_items_in_order: @grouped_similar_items_in_order }),
            turbo_stream.update("order_total", partial: "customers/orders/total_amount",
              locals: { total_order_amount: @total_order_amount }),
            turbo_stream.remove("no_order_items"),
            # turbo_stream.update("checkout_modal", partial: "customers/orders/checkout_modal", locals: { order_items: @order.order_items }),
          ]

          return
        end

        if similar_items_in_order.exists?
          render turbo_stream: [
            turbo_stream.replace("order_item_product_#{@order_item.product_id}",
              partial: "customers/orders/order_item",
              locals: { grouped_similar_items_in_order: @grouped_similar_items_in_order }),
            turbo_stream.update("order_total", partial: "customers/orders/total_amount",
              locals: { total_order_amount: @total_order_amount }),
          ]
        elsif !similar_items_in_order.exists? && !@order_item.persisted?
          # binding.break
          # turbo_remove = @order.order_items.exists? ? "" : turbo_stream.remove("order_total")
          render turbo_stream: [
            turbo_stream.remove("order_item_product_#{@order_item.product_id}"),
            turbo_stream.update("order_total", partial: "customers/orders/total_amount",
              locals: { total_order_amount: @total_order_amount }),
          ]
          # turbo_stream.replace("order_item_product_#{@order_item.product_id}", "Foo!")
        else
          render_turbo_append
        end

        turbo_stream.update("checkout_modal", partial: "customers/orders/checkout_modal", locals: { order_items: @order.order_items })
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

      def render_turbo_append
        render turbo_stream: [
          turbo_stream.prepend("order_item",
            partial: "customers/orders/order_item",
            locals: { grouped_similar_items_in_order: @grouped_similar_items_in_order }),
          turbo_stream.update("order_total", partial: "customers/orders/total_amount",
            locals: { total_order_amount: @total_order_amount }),
          # # turbo_stream.update("checkout_modal", partial: "customers/orders/checkout_modal", locals: { order_items: @order.order_items }),
        ]
      end
    end
  end
end