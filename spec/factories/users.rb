# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    dob { Faker::Date.birthday(min_age: 18, max_age: 65) }
    mobile_no { Faker::PhoneNumber.cell_phone_in_e164 }
    email { Faker::Internet.email }
    university { Faker::Educator.university }
    organization { Faker::Company.name }
  end
end
