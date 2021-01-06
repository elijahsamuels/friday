Faker::Config.locale = 'en-US'
# https://github.com/faker-ruby/faker#generators

5.times do
    first_name = Faker::Name.unique.first_name
    last_name = Faker::Name.unique.last_name
    email = Faker::Internet.email
    password = Faker::Internet.password
    phone = Faker::PhoneNumber.phone_number

    User.create(first_name: first_name, last_name: last_name, email: email, password: password, phone: phone)
    # binding.pry
end

5.times do
    first_name = Faker::Name.unique.first_name
    last_name = Faker::Name.unique.last_name
    email = Faker::Internet.email
    password = Faker::Internet.password
    phone = Faker::PhoneNumber.phone_number

    Client.create(first_name: first_name, last_name: last_name, email: email, password: password, phone: phone)
end

5.times do
    client_name = Faker::Name.unique.name
    user_name = Faker::Name.unique.name

    Meeting.create(client_name: client_name, user_name: user_name)
end

