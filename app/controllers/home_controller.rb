class HomeController < ApplicationController
    def homepage
        @category = Category.all
    end
    def dashboard
    end

    def show
        @product = Category.find_by(id:params[:id]).products
        rescue ActiveRecord::RecordNotFound
            redirect_to root_path
    end

end
