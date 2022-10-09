# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      before_action :verify_user!, only: %i[create]

      def create
        lesson = @course.lessons.create!(lesson_params)
        render json: { data: serialize_json_api(lesson, @course) }, status: :created
      end

      def context
        { current_user: current_user, course: Course.find(params[:course_id]) }
      end

      private

      def lesson_params
        params.permit(:title, :notes, :video)
      end

      def serialize_json_api(lesson, course)
        JSONAPI::ResourceSerializer
          .new(Api::V1::LessonResource)
          .object_hash(Api::V1::LessonResource.new(lesson, nil), course)
      end

      def verify_user!
        @course = Course.find(params[:course_id])
        raise ForbiddenPathError if @course.author.id != current_user.id
      end
    end
  end
end
