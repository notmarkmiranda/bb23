FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{Faker::Internet.email}#{n}" }
    password_digest { "password" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    nickname { Faker::Superhero.name }
  end
end
