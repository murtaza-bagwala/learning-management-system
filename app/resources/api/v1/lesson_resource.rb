# frozen_string_literal: true

module Api
  module V1
    class LessonResource < JSONAPI::Resource
      attributes :title, :notes, :video_url

      has_one :course

      def video_url
        Rails.application.routes.url_helpers.rails_blob_path(@model.video, only_path: true) if @model.video.attached?
      end
    end
  end
end
