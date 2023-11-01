class Order < ApplicationRecord
  belongs_to :user
  enum status: {in_progress: 0, done: 2}
end
