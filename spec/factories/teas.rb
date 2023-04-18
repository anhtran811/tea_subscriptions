FactoryBot.define do
  factory :tea do
    name {Faker::Tea.variety}
    type {Faker::Tea.type}
    description {Faker::Coffee.notes}
    brew_time {Faker::Number.number(digits: 3)}
    price {Faker::Number.decimal(l_digits: 1, r_digits: 2)}
  end
end