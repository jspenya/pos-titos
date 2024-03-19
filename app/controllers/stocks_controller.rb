class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :update]

  def index
    @stocks = Stock.ordered
    authorize @stocks
  end

  def show
    authorize @stock
  end

  def update
    authorize @stock

    @stock.update!(permitted_params)

    respond_to do |format|
      format.html { redirect_to stocks_path, notice: 'Stock was successfully updated.' }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@stock)
      end
    end
  rescue => e
    Rails.logger.info "Failed -> #{e}"
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: "Unable to find that stock."
  end

  def permitted_params
    params.require(:stock).permit(
      :quantity,
      :increment_quantity,
      :decrement_quantity
    )
  end
end
