# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  role       :integer          default("individual")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_customers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy, strict_loading: true

  enum :role, {
    individual: 0,
    table: 1
  }, suffix: :customer

    # This is a shorter way to write the broadcast callbacks (create, update, destroy)
    # broadcasts_to ->(customer) { "customers" }, inserts_by: :prepend

    # # Broadcast updates to categories/show also
    # after_update_commit -> { broadcast_replace_later_to "customer", partial: "customers/show_customer",
    #   locals: { category: self }, target: "customer_#{self.id}" }
end
