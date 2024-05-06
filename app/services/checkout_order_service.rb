# CashTenderedNotEnoughError = Class.new(StandardError)
class CashTenderedNotEnoughError < StandardError; end

class CheckoutOrderService
  def initialize(payment, params)
    @payment = payment
    @params = params
  end

  def call
    raise CashTenderedNotEnoughError if @params[:cash_tendered].to_f < @params[:order_total].to_f

    update_order_status!
    update_payment_record!
  end

  private

  def update_payment_record!
    @payment.cash_change_amount = @payment.cash_tendered - order_total
    @payment.save!
  end

  def update_order_status!
    order = Order.find(@params[:order_id])
    order.update!(status: 2, total_amount: @params[:order_total].to_f)
  end

  def order_total
    Order.includes(:order_items)
         .find(@params[:order_id]).order_items
         .sum { |o| o.product.price }
  end
end
