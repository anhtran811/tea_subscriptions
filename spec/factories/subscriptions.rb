FactoryBot.define do
  factory :subscription do
    name {Faker::TvShows::Friends.quote}
    price {Faker::Number.decimal(l_digits: 2, r_digits: 2)}
    frequency {Faker::Number.within(range: 0..3)}
    status {Faker::Number.within(range: 0..1)}

    association :customer
  end
end