class ChartsController < ApplicationController
  def index
    authorize :chart, :index?
  end

  def sales_all_time
    authorize :chart, :sales_all_time?
    # result = Payment.paid.each_with_object(Hash.new(0)) do |order_item, counts|
    #   product_name = order_item.product.name
    #   counts[product_name] += 1
    # end
    render json: Payment.paid.group_by_month(:created_at).sum(:cash_tendered)
  end

  def products_sold
    authorize :chart, :products_sold?

    result = OrderItem.done.includes(:product).each_with_object(Hash.new(0)) do |order_item, counts|
      product_name = order_item.product.name
      counts[product_name] += 1
    end

    render json: result
  end

  def products_sold_this_week
    authorize :chart, :products_sold_this_week?

    result = OrderItem.done.created_this_week.includes(:product).each_with_object(Hash.new(0)) do |order_item, counts|
      product_name = order_item.product.name
      counts[product_name] += 1
    end

    render json: result
  end

  def orders
    authorize :chart, :orders?

    render json: Order.done.group_by_day(:created_at).count
  end

  def order_types
    authorize :chart, :order_types?

    result = Order.done.includes(:customer).each_with_object(Hash.new(0)) do |order, counts|
      role = order.customer.role
      counts[role] += 1
    end

    render json: result
  end
end
