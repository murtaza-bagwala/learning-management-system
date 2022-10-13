# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      before_action :verify_user!, only: %i[create update destroy]
      before_action :verify_course!, only: %i[update destroy]

      # Had to override create and update actions here as the content-type of
      # this request is multipart-form as we are uploading videos
      # and jsonapi-resource only expect application/vnd.api+json
      # but the response is jsonapi-resource compliant

      def create
        lesson = @course.lessons.create!(lesson_params)
        render json: { data: serialize_json_api(lesson, @course) }, status: :created
      end

      def update
        @lesson.video.purge if lesson_params[:video].present?
        @lesson.update!(lesson_params)
        render json: { data: serialize_json_api(@lesson, @course) }, status: :ok
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

      def verify_course!
        @lesson = Lesson.find(params[:id])
        raise ForbiddenPathError if @course.id != @lesson.course_id
      end
    end
  end
end
