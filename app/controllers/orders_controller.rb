class OrdersController < ApplicationController

    def index
        @orders = Order.all
    end

    def show
    end

    def new
        @order = Category.new
    end

    def create
    end

    def edit
    end

end