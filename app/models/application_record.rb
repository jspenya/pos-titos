class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :ordered, ->(order = :asc) { order(created_at: order) }
end
