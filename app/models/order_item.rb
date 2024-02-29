# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class OrderItem < ApplicationRecord
  belongs_to :product
  validates :product, presence: true
  belongs_to :order

  after_commit :decrement_product_quantity, on: :create
  after_destroy :increment_product_quantity

  def self.similar_items_in_order(order_id = nil, product_id = nil)
    scope = self
    scope = scope.where(order_id:) if order_id
    scope = scope.where(product_id:) if product_id
    scope
  end

  private

  def increment_product_quantity
    product.increment!(:quantity, by = 1, touch: nil)
  end
  def decrement_product_quantity
    product.decrement!(:quantity, by = 1, touch: nil)
  end
end
