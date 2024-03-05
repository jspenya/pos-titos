class AddColumnsToTransactionsModel < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :transaction_type, :integer
    add_column :transactions, :workflow_state, :integer
  end
end
