class AddDefaultQuantityToStocksQuantity < ActiveRecord::Migration[7.0]
  def change
    change_column :stocks, :quantity, :integer, :default => 0
  end
end
