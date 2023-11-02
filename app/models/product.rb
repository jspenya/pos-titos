# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string
#  quantity    :integer
#  price       :decimal(, )
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [200, 200]
  end

  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true

  scope :ordered, -> { order(id: :desc) }

  # This is a shorter way to write the broadcast callbacks (create, update, destroy)
  broadcasts_to ->(product) { "products" }, inserts_by: :prepend

  # Broadcast updates to products/show also
  after_update_commit -> { broadcast_replace_later_to "product", partial: "products/show_product",
    locals: { product: self }, target: "product_#{self.id}" }
end
