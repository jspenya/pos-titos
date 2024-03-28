module Customers
  class OrdersController < OrdersController
    before_action :set_orders, only: [:index, :show, :create]
    before_action :set_similar_items_in_order, only: [:show]
    def index; end

    def show
      @categories = Category.all
      @allProducts = Product.available
      if params[:category_id].present?
        @allProducts = @allProducts.where(category_id: params[:category_id])
      end
      @order_items = @order.order_items.includes(:product)
      @total_order_amount = @order.order_items.includes(:product).sum("products.price")
      @last_order_item = @order.order_items.last
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "testing",
          template: 'customers/orders/print_receipt',
          formats: [:html],
          layout: "pdf",
          encoding: "UTF-8",
          disposition: 'inline',
          zoom: 5
        end
      end
    end

    def create
      @order = Order.new(orders_params)

      if @order.save
        respond_to do |format|
          format.html { redirect_to customer_order_path(@customer, @order), notice: "Order was successfully created." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @order_items = @order.order_items.includes(:product)
      @total_order_amount = @order.order_items.includes(:product).sum("products.price")
    end

    private

    def set_similar_items_in_order
      @order_items = @order.order_items
      @grouped_similar_items_in_order = @order_items.similar_items_in_order(@order.id)
                                            .group(:product).count
    end

    def set_orders
      @customer = Customer.includes(:orders).find(params[:customer_id])
      @orders = @customer.orders.ordered.where(user_id: current_user.id).includes(:order_items)
    end
  end
end