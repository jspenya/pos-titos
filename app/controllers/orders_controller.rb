class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.ordered
    authorize @orders
  end

  def show
  end

  def new
    @order = Order.new
    #authorize @order
  end

  def create
    @order = Order.new(orders_params)
    if @order.save
      respond_to do |format|
        format.html { redirect_to orders_path, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_path, notice: "Order was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_order
    @order = Order.includes(:order_items).find(params[:id])
  end

  def orders_params
    params.require(:order).permit(:user_id, :name, :status, :customer_id)
  end
end
