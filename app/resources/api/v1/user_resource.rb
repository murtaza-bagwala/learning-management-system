# frozen_string_literal: true

module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :name, :email, :mobile_no, :dob, :university, :organization
      has_many :authored_courses, class_name: 'Course', foreign_key: 'user_id'

      before_update :validate_user!
      before_remove :validate_user!

      def validate_user!
        raise ForbiddenPathError if context[:current_user] != @model
      end
    end
  end
end
