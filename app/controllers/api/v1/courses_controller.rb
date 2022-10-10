# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index]

      def join_course
        @course = Course.find(params[:course_id])
        user_course = current_user.user_courses.create!(course_id: @course.id)
        render json: { data: serialize_json_api(@course) }, status: :created
      end

      private

      def serialize_json_api(course)
        JSONAPI::ResourceSerializer
          .new(Api::V1::CourseResource)
          .object_hash(Api::V1::CourseResource.new(course, nil), current_user)
      end
    end
  end
end
