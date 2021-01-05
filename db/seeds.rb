#HERES A CHANGE!


# https://github.com/faker-ruby/faker#generators

5.times do
    first_name = Faker::Name.unique.first_name
    last_name = Faker::Name.unique.last_name
    email = Faker::Internet.email

    User.create(first_name: first_name, last_name: last_name, email: email)
end