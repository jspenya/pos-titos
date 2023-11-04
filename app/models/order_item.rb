# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OrderItem < ApplicationRecord
    has_one :product, dependent: :destroy
    validates :product, presence: true
end
