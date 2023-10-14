class CategoriesController < ApplicationController
  # GET requests
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @category = Category.new
  end
  # End of GET requests

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        flash[:notice] = "Category was successfully created."
        format.html { redirect_to categories_path }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to root_path, status: :see_other
  end
  private

  def category_params
    params.require(:category).permit(:name)
  end
end
