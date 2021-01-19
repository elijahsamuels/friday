Faker::Config.locale = 'en-US'
# https://github.com/faker-ruby/faker#generators

10.times do
    first_name = Faker::Name.unique.first_name
    last_name = Faker::Name.unique.last_name
    email = Faker::Internet.email
    password = Faker::Internet.password
    phone = Faker::PhoneNumber.phone_number

    User.create(first_name: first_name, last_name: last_name, email: email, password: password, phone: phone)
end

10.times do
    first_name = Faker::Name.unique.first_name
    last_name = Faker::Name.unique.last_name
    email = Faker::Internet.email
    password = Faker::Internet.password
    phone = Faker::PhoneNumber.phone_number

    Client.create(first_name: first_name, last_name: last_name, email: email, password: password, phone: phone)
end

10.times do
    client_name = Faker::Name.unique.name
    user_name = Faker::Name.unique.name
    user_id = Faker::Number.between(from: 1, to: 10)
    meeting_date = Faker::Date.between(from: '2021-01-01', to: '2024-12-31')
    meeting_time = Faker::Time.between(from: '10:00:00', to: '16:00:00', format: :default)

    Meeting.create(client_name: client_name, user_name: user_name, user_id: user_id, meeting_date: meeting_date, meeting_time: meeting_time)
end

