class StockVersionsController < ApplicationController
  before_action :set_stock, only: [:show]

  def index
    @stocks = Stock.ordered
  end

  def show
    @versions = @stock.versions

    if params[:start_time].present? && params[:end_time].present?
      @versions = @versions.where(
        "versions.created_at >= ? AND versions.created_at <= ?",
        params[:start_time], params[:end_time]
      )
    end

    @versions = @versions.sort { |v| v.created_at }
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
