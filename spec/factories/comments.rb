FactoryBot.define do
  factory :comment do
    user { nil }
    body { "MyText" }
    commentable_id { 1 }
    commentable_type { "MyString" }
  end
end
