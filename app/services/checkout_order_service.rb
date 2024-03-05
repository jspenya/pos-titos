class CashTenderedNotEnoughError < StandardError; end

class CheckoutOrderService
  def initialize(payment_params)
    @payment_params = payment_params
  end

  def call
    raise CashTenderedNotEnoughError if @payment_params[:cash_tendered].to_f < @payment_params[:order_total].to_f

    update_order_status
    create_payment_record
  end

  private

  def create_payment_record
    Payment.create!(@payment_params)
  end

  def update_order_status
    order = Order.find(@payment_params[:order_id])
    order.update!(status: 2, total_amount: @payment_params[:order_total].to_f)
  end
end
