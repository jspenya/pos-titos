class ProductsController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.create(product_params)
    redirect_to category_path(@category)
  end

  private
    def product_params
      params.require(:product).permit(:name, :quantity, :price)
    end
end
