class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.ordered
  end

  def show
    @orders = @customer.orders
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      respond_to do |format|
        format.html { redirect_to customer_orders_path(@customer), notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @customer.update(customer_params)
      respond_to do |format|
        format.html { redirect_to customers_path, notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy!

    respond_to do |format|
      format.html { redirect_to customers_path, notice: "Customer was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :type, :role)
  end
end
