class Forum < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :subscriptions
  has_many :users, through: :subscriptions

  validates :forum_name, presence: true
  validates :description, presence: true
end
