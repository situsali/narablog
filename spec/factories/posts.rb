FactoryBot.define do
  factory :post do
    association :user, factory: :admin_user

    title     { Faker::Lorem.sentence }
    body      { Faker::Lorem.paragraph }

    before(:create) do |post|
      post.categories << FactoryBot.create(:category)
    end

    trait :published do
      published { true }
    end
  end
end
