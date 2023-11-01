class AddOrderItemToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :order_item, foreign_key: true
  end
end
