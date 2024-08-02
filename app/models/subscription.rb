class Subscription < ApplicationRecord
  belongs_to :forum
  belongs_to :user

  validates :priority, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
