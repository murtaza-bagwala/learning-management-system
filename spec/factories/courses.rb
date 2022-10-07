FactoryBot.define do
  factory :course do
    title { "MyString" }
    description { "MyText" }
    published_at { "2022-10-07 16:35:16" }
    published { false }
    user { "" }
  end
end
