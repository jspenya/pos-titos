class ProductsController < ApplicationController
  before_action :get_category
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  def index
    @products = @category.products
  end

  def show; end

  def new
    @product = @category.products.build
  end
  # def create
  #   @category = Category.find(params[:category_id])
  #   @product = @category.products.create(product_params)
  #   redirect_to category_path(@category)
  # end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.build(product_params)

        respond_to do |format|
         if @product.save
            format.html { redirect_to category_path(@category), notice: 'Product was successfully created.' }
            format.json { render :show, status: :created, location: @product }
         else
            format.html { render :new }
            format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to category_path(@category), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }

      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = @category.products.find(params[:id])
    @product.destroy
    redirect_to category_path(@category), notice: 'Product was successfully destroyed.'
  end



  private
    def set_product
      @product = @category.products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :quantity, :price, :category_id)
    end
    def get_category
    @category= Category.find(params[:category_id])
    end

end
