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
  scope :created_today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  attr_accessor :order_total
end
