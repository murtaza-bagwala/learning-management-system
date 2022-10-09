# frozen_string_literal: true

module Api
  module V1
    class LessonResource < JSONAPI::Resource
      attributes :title, :notes, :video_url

      has_one :course

      before_update :validate_user_and_course!
      before_remove :validate_user_and_course!

      def video_url
        Rails.application.routes.url_helpers.rails_blob_path(@model.video, only_path: true) if @model.video.attached?
      end

      def validate_user_and_course!
        if context[:current_user].id != context[:course].user_id ||
           context[:course].id != @model.course_id
          raise ForbiddenPathError
        end
      end
    end
  end
end
