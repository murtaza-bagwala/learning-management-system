# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[create index]

      def learnt_courses
        @learnt_courses = current_user.learnt_courses
        render json: serialize_json_api_array(@learnt_courses), status: :ok
      end

      def authored_courses
        @authored_courses = current_user.authored_courses
        render json: serialize_json_api_array(@authored_courses), status: :ok
      end

      private

      def serialize_json_api_array(courses)
        courses = courses.map { |course| Api::V1::CourseResource.new(course, nil) }
        JSONAPI::ResourceSerializer.new(Api::V1::CourseResource).serialize_to_hash(courses)
      end
    end
  end
end
