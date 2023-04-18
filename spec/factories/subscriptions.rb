FactoryBot.define do
  factory :subscription do
    name {Faker::TvShows::Friends.quote}
    price {Faker::Number.decimal(l_digits: 2, r_digits: 2)}

    association :customer
  end
end