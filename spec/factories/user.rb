FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    sequence(:email){Faker::Internet.email}
    password "123123"
    password_confirmation "123123"

    trait :invalid_email do
      email {Faker::Name.name}
    end

    trait :admin do
      role :admin
    end

    trait :user do
      role :user
    end
  end
end
