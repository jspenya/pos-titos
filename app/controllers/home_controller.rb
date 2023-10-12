class HomeController < ApplicationController
    def homepage
        @category = Category.all
    end
    def dashboard
    end

    def show

    @product = Category.find_by(id:params[:id]).products
    @category= Category.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end
    def new_category
        @category = Category.new
    end
    def create_category
        @category = Category.new(category_params)
        if @category.save
            redirect_to root_path
        else
            render :new_category
        end

    end
    def add_product
        @product = Product.new
        
    end

    def create_product
        #@category= Category.find(params[:id])
        @product = Product.new(product_params)
    end
    
    private 

    def product_params
        params.required(:product).permit(:name, :quantity, :price, :category_id)
    end
    
    def category_params
        params.required(:category).permit(:name) 
    end


end
