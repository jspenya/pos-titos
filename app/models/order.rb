# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  name         :string
#  status       :integer
#  total_amount :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  customer_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_orders_on_customer_id  (customer_id)
#  index_orders_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  has_many :order_items, dependent: :destroy, strict_loading: true
  has_many :payments, dependent: :destroy

  enum :status, {in_progress: 0, done: 2}, default: :in_progress

  scope :done, -> { where(status: 2)}

  after_commit :generate_name, on: :create

  private

  def generate_name
    update(name: Date.today.to_s.gsub('-', '') + "ORDID##{self.id}")
  end
end
