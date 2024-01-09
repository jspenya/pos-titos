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
end
