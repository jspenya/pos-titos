class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.references :product, null: false, foreign_key: true
      t.references :order_item, foreign_key: true
      t.integer :quantity
      t.string :location
      t.string :last_checked_by

      t.timestamps
    end
  end
end
