# == Schema Information
#
# Table name: stocks
#
#  id              :bigint           not null, primary key
#  last_checked_by :string
#  location        :string
#  quantity        :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :bigint           not null
#
# Indexes
#
#  index_stocks_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Stock < ApplicationRecord
  has_paper_trail

  belongs_to :product

  attr_writer :increment_quantity

  def increment_quantity=(val)
    self.quantity += val.to_i
  end

  def decrement_quantity=(val)
    raise CannotDecrementZero if self.quantity == 0
    self.quantity -= val.to_i
  end

  private

  class CannotDecrementZero < StandardError; end
end
