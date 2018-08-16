# User.create! name: "Admin", email: "admin@gmail.com", role: 2,
#   password: "123123", password_confirmation: "123123"

# User.create! name: "Manager", email: "tuannguyen@gmail.com", role: 1,
#   password: "123123", password_confirmation: "123123"

# 50.times do
#   User.create! name: Faker::Name.unique.name, email: Faker::Internet.unique.email,
#     password: "123123", password_confirmation: "123123"
# end

20.times do
  Category.create! title: Faker::Book.unique.genre,
    describe: Faker::Lorem.paragraph(5)
end

50.times do
  Author.create! name: Faker::Book.unique.author,
    birth_year: Faker::Number.between(1800, 2000),
    country: Faker::Address.country
end

40.times do
  Publisher.create! name: Faker::Book.unique.publisher, info: Faker::Lorem.sentence(5) 
end

100.times do 
  aut_id = rand(1..50)
  pub_id = rand(1..40)
  genre_id = rand(1..20)
  Book.create! title: Faker::Book.title, describe: Faker::Lorem.sentence(300),
    published_at: Faker::Date.backward(36500), author_id: aut_id,
    publisher_id: pub_id, category_id: genre_id
end
