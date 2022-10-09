# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { Faker::Company.name }
    description { Faker::Quote.matz }
    published_at { Date.today }
    published { false }
    author factory: :user
  end
end
