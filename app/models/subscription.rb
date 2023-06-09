class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :name, :price, :status, :frequency

  enum status: { active: 0, cancelled: 1 }
  enum frequency: { biweekly: 0, monthly: 1, bimonthly: 2, quarterly: 3 }
end