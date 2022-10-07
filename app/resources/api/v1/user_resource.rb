# frozen_string_literal: true

module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :name, :email, :mobile_no, :dob, :university
    end
  end
end
