# == Schema Information
#
# Table name: customer_orders
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#  order_id    :bigint           not null
#
# Indexes
#
#  index_customer_orders_on_customer_id  (customer_id)
#  index_customer_orders_on_order_id     (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (order_id => orders.id)
#
class CustomerOrder < ApplicationRecord
  belongs_to :order
  belongs_to :customer
end
