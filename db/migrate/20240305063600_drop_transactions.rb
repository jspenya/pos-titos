class DropTransactions < ActiveRecord::Migration[7.0]
  def up
    drop_table :transactions
  end

  def down
    create_table :transactions do |t|
      t.timestamps
    end
  end
end
