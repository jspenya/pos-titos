class OrderItem < ApplicationRecord
    has_one :product, dependent: :destroy
    validates :product, presence: true
end
