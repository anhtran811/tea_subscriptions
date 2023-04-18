class Tea < ApplicationRecord
  has_many :tea_subscriptions, dependent: :destroy
  has_many :subscriptions, through: :tea_subscriptions, dependent: :destroy
  has_many :customers, through: :subscriptions, dependent: :destroy

  validates_presence_of :name, :type, :description, :brew_time, :price
end