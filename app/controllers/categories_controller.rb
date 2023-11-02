class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET requests
  def index
    @categories = Category.ordered
  end

  def show
    @products = @category.products.ordered
  end

  def edit; end

  def update
    if @category.update(category_params)
      respond_to do |format|
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      respond_to do |format|
        format.html { redirect_to categories_path, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to categories_path, notice: "Category was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
