module Orders
  class OrderItemsController < ApplicationController
    before_action :set_order_item, only: [:show, :edit, :update, :destroy]

    def index
      @order_items = OrderItem.ordered
    end

    def show
    end

    def new
      @order_item = OrderItem.new
    end

    def create
      @order_item = OrderItem.new(order_items_params)
      if @order_item.save
        respond_to do |format|
          format.html { redirect_to orders_path, notice: "OrderItem was successfully created." }
          format.json { render :show, status: :created, location: @order_item }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def destroy
      @order_item.destroy!

      respond_to do |format|
        format.html { redirect_to orders_path, notice: "Order Item was successfully destroyed." }
        format.turbo_stream
      end
    end

    private

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_items_params
      params.require(:order).permit(:order_id)
    end
  end
end
