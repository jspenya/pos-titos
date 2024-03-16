# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  is_ingredient :boolean          default(FALSE)
#  name          :string
#  price         :decimal(, )
#  quantity      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :bigint           not null
#  order_item_id :bigint
#
# Indexes
#
#  index_products_on_category_id    (category_id)
#  index_products_on_order_item_id  (order_item_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (order_item_id => order_items.id)
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
