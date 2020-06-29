FactoryBot.define do
  factory :post_category do
    association :post, factory: :post
    association :category, factory: :category
  end
end
