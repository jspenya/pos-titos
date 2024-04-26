module Categories
  class ProductsController < ProductsController
    before_action :get_category
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    def index
      @products = @category.products.ordered

    end

    def show; end

    def new
      @product = @category.products.build
    end

    def create
      @category = Category.find(params[:category_id])
      @product = @category.products.build(product_params)

      if @product.save
        respond_to do |format|
          format.html { redirect_to products_path, notice: 'Product was successfully created.' }
          format.json { render :show, status: :created, location: @product }
          format.turbo_stream
        end
      else
        Rails.logger.info("HERE!!!!")
        Rails.logger.info(@product.errors.full_messages)
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @product.update(product_params)
        respond_to do |format|
          format.html { redirect_to category_products_path, notice: "Product was successfully updated." }
          format.json { render :show, status: :ok, location: @product }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product = @category.products.find(params[:id])
      @product.destroy!

      respond_to do |format|
        format.html { redirect_to category_path(@category), notice: "Product was successfully destroyed." }
        format.turbo_stream
      end
    end

    private


    def set_product
      @product = @category.products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :quantity, :price, :category_id, :image)
    end

    def get_category
      @category= Category.find(params[:category_id])
    end
  end
end
