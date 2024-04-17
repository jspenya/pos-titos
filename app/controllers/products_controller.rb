class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.pluck(:id, :name)
    @products = Product.ordered
    if params[:category_id].present?
      @products = Product.where(category_id: params[:category_id])
    end
    authorize @products
  end

  def show; end

  def new
    @product = Product.new
    authorize @product
  end

  def create

    @product = Product.new(product_params)
    authorize @product
    if @product.save
      respond_to do |format|
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    authorize @product
    if @product.update(product_params)

      respond_to do |format|
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @product
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :quantity, :price, :category_id, :image, :is_ingredient)
  end
end
