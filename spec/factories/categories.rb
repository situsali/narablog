FactoryBot.define do
  factory :category do
    title        { Faker::Lorem.sentence }
    description  { Faker::Lorem.paragraph }
  end
end
