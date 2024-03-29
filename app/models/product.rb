# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  is_ingredient :boolean          default(FALSE)
#  name          :string
#  price         :decimal(, )
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
class Product < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_one :stock, dependent: :destroy

  belongs_to :category

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [200, 200]
  end

  validates :name, presence: true
  validates :price, presence: true, unless: :is_ingredient?

  scope :available, -> {
    joins(:stock).where.not("stocks.quantity <= 0")
                 .where(is_ingredient: false)
  }

  after_commit :add_to_stock, on: :create

  # This is a shorter way to write the broadcast callbacks (create, update, destroy)
  # broadcasts_to ->(product) { "products" }, inserts_by: :prepend

  # Broadcast updates to products/show also
  # after_update_commit -> { broadcast_replace_later_to "product", partial: "products/show_product",
    # locals: { product: self }, target: "product_#{self.id}" }
  private

  def add_to_stock
    Stock.create(product_id: self.id)
  end
end
