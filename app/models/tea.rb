class Tea < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :customers, through: :subscriptions, dependent: :destroy

  validates_presence_of :name, :variety, :description, :brew_time, :price
end