# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  transaction_type :integer
#  workflow_state   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  order_id         :bigint           not null
#
# Indexes
#
#  index_transactions_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
