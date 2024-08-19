class CustomerOrdersController < ApplicationController
  def index
    @tables = Customer.table_customer

    authorize :customer_orders, :index?
  end

  def tables
    @tables = Customer.table_customer

    authorize :customer_orders, :tables?
  end

  def individual_orders
    @individual = Customer.individual_customer

    authorize :customer_orders, :individual_orders?
  end

  def new
    table = Customer.table_customer.find(params[:table])

    @customer_order = table.customer_orders.build
  end

  def create
  end
end
