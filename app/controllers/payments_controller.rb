class PaymentsController < ApplicationController
  def index
    @payments = Payment.paid

    if params[:start_time].present? && params[:end_time].present?
      @payments = @payments.created_between(params[:start_time], params[:end_time])
    end

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@payments)
      end
    end
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)

    CheckoutOrderService.new(payment_params).call
    flash[:notice] = "Payment successful!"

    redirect_to customer_orders_path(payment_params[:customer_id])
  rescue CashTenderedNotEnoughError
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.prepend("pay_order_modal_body", partial: "shared/error_message", locals: { message: "Cash tendered is insufficient for order." })
      end
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:order_id, :customer_id, :user_id, :cash_tendered, :order_total)
  end
end
