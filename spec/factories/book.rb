FactoryBot.define do
  factory :book do
    title {Faker::Book.title}
    describe {Faker::Lorem.sentence(300)}
    published_at {Faker::Date.backward(36500)}
    author
    publisher
    category
  end
end
