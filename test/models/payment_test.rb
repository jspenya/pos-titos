# == Schema Information
#
# Table name: payments
#
#  id             :bigint           not null, primary key
#  type           :integer
#  workflow_state :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  order_id       :bigint           not null
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
