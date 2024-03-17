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

  after_commit :decrement_quantity, on: :create
  after_destroy :increment_quantity

  scope :done, -> { joins(:order).where("orders.status = 2")}
  scope :created_this_week, -> {
    where("order_items.created_at >= ? AND order_items.created_at <= ?", Date.today.beginning_of_week, Date.today.end_of_day)
  }

  def self.similar_items_in_order(order_id = nil, product_id = nil)
    scope = self
    scope = scope.where(order_id:) if order_id
    scope = scope.where(product_id:) if product_id
    scope
  end

  private

  def increment_quantity
    product.stock.increment!(:quantity, by = 1, touch: nil)
  end

  def decrement_quantity
    product.stock.decrement!(:quantity, by = 1, touch: nil)
  end
end
