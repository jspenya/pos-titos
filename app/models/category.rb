# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :products, dependent: :destroy, strict_loading: true
  validates :name, presence: true

  scope :available, -> {
    joins("LEFT JOIN products ON categories.id = products.category_id")
    .joins("LEFT JOIN stocks ON stocks.product_id = products.id")
    .where("stocks.quantity > 0").uniq
  }

  # This is a shorter way to write the broadcast callbacks (create, update, destroy)
  broadcasts_to ->(category) { "categories" }, inserts_by: :prepend

  # Broadcast updates to categories/show also
  after_update_commit -> { broadcast_replace_later_to "category", partial: "categories/show_category",
    locals: { category: self }, target: "category_#{self.id}" }
end
