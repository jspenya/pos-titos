# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  role       :integer          default("individual")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Customer < ApplicationRecord
  has_many :customer_orders, strict_loading: true
  has_many :orders, through: :customer_orders, strict_loading: true

  enum :role, {
    individual: 0,
    table: 1
  }, suffix: :customer

    # This is a shorter way to write the broadcast callbacks (create, update, destroy)
    broadcasts_to ->(customer) { "customers" }, inserts_by: :prepend

    # Broadcast updates to categories/show also
    after_update_commit -> { broadcast_replace_later_to "customer", partial: "customers/show_customer",
      locals: { category: self }, target: "customer_#{self.id}" }
end
