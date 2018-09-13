FactoryBot.define do
  factory :borrow do
    user
    book
    date_borrow {Faker::Date.backward(10)}
    borrow_days {Faker::Number.between(1, 30)}
  end
end
