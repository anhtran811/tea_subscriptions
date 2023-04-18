class Customer < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :tea_subscriptions, through: :subscriptions, dependent: :destroy
  has_many :teas, through: :tea_subscriptions, dependent: :destroy

  validates_presence_of :first_name, :last_name, :email, :address, :city, :zip_code
  validates_uniqueness_of :email
end