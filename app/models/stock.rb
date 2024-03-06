# == Schema Information
#
# Table name: stocks
#
#  id              :bigint           not null, primary key
#  last_checked_by :string
#  location        :string
#  quantity        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_item_id   :bigint
#  product_id      :bigint           not null
#
# Indexes
#
#  index_stocks_on_order_item_id  (order_item_id)
#  index_stocks_on_product_id     (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_item_id => order_items.id)
#  fk_rails_...  (product_id => products.id)
#
class Stock < ApplicationRecord
  belongs_to :product
end
