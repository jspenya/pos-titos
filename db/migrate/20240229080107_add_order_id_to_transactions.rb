class AddOrderIdToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :order, null: false, foreign_key: true
  end
end
