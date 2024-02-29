class Checkout_Order
    def initialize 
        @customer = Customer.includes(:orders).find(params[:customer_id])
        @order = @customer.orders.includes(:order_items).find(params[:order_id])
        @total_order_amount = @order.order_items.includes(:product).sum("products.price")
    end

    private

    def create_transaction
        @transaction=Transaction.create!(@order.order)

    end

    def update_order_status
        @order.update!(status: 'done', total_amount: @total_order_amount)
    end
    
end
