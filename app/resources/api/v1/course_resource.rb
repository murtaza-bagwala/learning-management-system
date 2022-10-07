# frozen_string_literal: true

module Api
  module V1
    class CourseResource < JSONAPI::Resource
      attributes :name, :email, :mobile_no, :dob, :university
    end
  end
end
