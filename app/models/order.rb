# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  name         :string
#  status       :integer
#  total_amount :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :user
  enum :status, {in_progress: 0, done: 2}, default: :in_progress


  # This is a shorter way to write the broadcast callbacks (create, update, destroy)
  broadcasts_to ->(order) { "orders" }, inserts_by: :prepend

  # Broadcast updates to categories/show also
  after_update_commit -> { broadcast_replace_later_to "order", partial: "orders/show_order",
    locals: { category: self }, target: "category_#{self.id}" }
end
