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
class Transaction < ApplicationRecord
    belongs_to :order
    enum transaction_type: [:cash, :gcash]

    include Workflow
    workflow do
        state :pending do
          event :submit, :transitions_to => :ongoing
        end
        state :ongoing do
          event :review, :transitions_to => :completed
        end
        state :completed do
          event :accept, :transitions_to => :accepted
          event :reject, :transitions_to => :rejected
        end
        state :accepted
        state :rejected
      end
end
