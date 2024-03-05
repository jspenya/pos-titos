# == Schema Information
#
# Table name: payments
#
#  id             :bigint           not null, primary key
#  cash_tendered  :decimal(, )
#  payment_method :integer          default("cash")
#  workflow_state :string           default("pending")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :bigint           not null
#  order_id       :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_payments_on_customer_id  (customer_id)
#  index_payments_on_order_id     (order_id)
#  index_payments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
