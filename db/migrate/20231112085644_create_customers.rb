class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
