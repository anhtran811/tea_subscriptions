FactoryBot.define do
  factory :tea_subscription do
    association :tea, :subscription
  end
end