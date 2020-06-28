FactoryBot.define do
  factory :post do
    user      { FactoryBot.create :admin_user }
    title     { Faker::Lorem.sentence }
    body      { Faker::Lorem.paragraph }

    trait :published do
      published { true }
    end
  end
end
