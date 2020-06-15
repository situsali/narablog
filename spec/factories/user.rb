FactoryBot.define do
  factory :user do
    name     { Faker::Name.name }
    username { name.parameterize(separator: '_') }
    email    { Faker::Internet.email }
    password { 'Password' }

    trait :confirmed do
      confirmed_at { DateTime.now.to_formatted_s(:db) }
    end

    factory :admin_user do
      isadmin { true }
    end
  end
end
