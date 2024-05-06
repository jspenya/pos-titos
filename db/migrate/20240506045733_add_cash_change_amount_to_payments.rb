class AddCashChangeAmountToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :cash_change_amount, :decimal, precision: 10, scale: 2
  end
end
