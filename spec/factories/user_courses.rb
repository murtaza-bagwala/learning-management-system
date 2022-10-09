# frozen_string_literal: true

FactoryBot.define do
  factory :user_course do
    talent factory: :user
    course
  end
end
