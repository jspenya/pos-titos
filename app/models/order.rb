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
#  user_id      :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :user
  has_many :customer_orders, dependent: :destroy, strict_loading: true
  has_many :customers, through: :customer_orders, strict_loading: true
  has_many :order_items, dependent: :destroy, strict_loading: true

  enum :status, {in_progress: 0, done: 2}, default: :in_progress

  before_create :generate_name

  private

  def generate_name
    self.name = Date.today.to_s.gsub('-', '') + "ORDID##{self.id}"
  end
end
