class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :tea_subscriptions, dependent: :destroy
  has_many :teas, through: :tea_subscriptions, dependent: :destroy

  validates_presence_of :name, :price, :status, :frequency
end