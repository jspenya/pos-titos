module Customers
  module Orders
    class OrderItemsController < ::Orders::OrderItemsController
      def new
        @products = Product.available
      end

      def create
        puts "PARAMS: #{params}"
        respond_to do |format|
          format.html {  }
          format.turbo_stream
        end
      end
    end
  end
end
