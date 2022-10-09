# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    title { Faker::Company.name }
    notes { Faker::Quote.matz }
    video { Rack::Test::UploadedFile.new('public/1mb-file.mp4', 'video/mp4') }
    course
  end
end
