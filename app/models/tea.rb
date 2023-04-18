class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :customers, through: :subscriptions, dependent: :destroy

  validates_presence_of :name, :type, :description, :brew_time, :price
end