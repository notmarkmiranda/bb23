FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{Faker::Internet.email}#{n}" }
    password { "password" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    nickname { Faker::Superhero.name }

    trait :with_token do
      token { "randomToken" }
      token_expiration { 1.week.from_now }
    end
  end
end
