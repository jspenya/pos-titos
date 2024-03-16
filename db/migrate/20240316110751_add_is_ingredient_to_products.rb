class AddIsIngredientToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :is_ingredient, :boolean, default: false
  end
end
