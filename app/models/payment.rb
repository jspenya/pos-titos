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
class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :customer
  belongs_to :user

  enum :payment_method, {
    cash: 0,
    gcash: 1
  }, suffix: "payment"

  include PaymentWorkflow

  after_commit :complete!, on: :create

  scope :paid, -> { where(workflow_state: 'completed')}
  scope :created_between, ->(start_date, end_date) { where("payments.created_at >= ? AND payments.created_at <= ?", start_date, end_date) }

  attr_accessor :order_total
end
