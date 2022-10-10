# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index]
      before_action :course_not_created_by_current_user!, only: :join_course

      def join_course
        user_course = current_user.user_courses.create!(course_id: @course.id)
        render json: { data: serialize_json_api(@course) }, status: :created
      end

      private

      def serialize_json_api(course)
        JSONAPI::ResourceSerializer
          .new(Api::V1::CourseResource)
          .object_hash(Api::V1::CourseResource.new(course, nil), current_user)
      end

      def course_not_created_by_current_user!
        @course = Course.find(params[:course_id])
        if @course.author.id == current_user.id
          Rails.logger.info('Author cannot join his own course')
          raise ForbiddenPathError
        end
      end
    end
  end
end
