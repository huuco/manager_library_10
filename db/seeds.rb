User.create! name: "Admin", email: "admin@gmail.com", role: 2,
  password: "123123", password_confirmation: "123123"

User.create! name: "Manager", email: "tuannguyen@gmail.com", role: 1,
  password: "123123", password_confirmation: "123123"

50.times do
  User.create! name: Faker::Name.unique.name, email: Faker::Internet.unique.email,
    password: "123123", password_confirmation: "123123"
end

20.times do
  Category.create! title: Faker::Book.unique.genre,
    describe: Faker::Lorem.paragraph(5)
end
