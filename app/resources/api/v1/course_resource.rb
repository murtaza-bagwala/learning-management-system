# frozen_string_literal: true

module Api
  module V1
    class CourseResource < JSONAPI::Resource
      attributes :title, :description, :published_at, :published, :created_by
      has_one :author, class_name: 'User', foreign_key: 'user_id'

      before_save do
        @model.user_id = context[:current_user].id if @model.new_record?
      end

      before_update :validate_user!
      before_remove :validate_user!

      def validate_user!
        raise ForbiddenPathError if context[:current_user].id != @model.user_id
      end

      def created_by
        {
          user_id: @model.user_id,
          name: @model.author.name
        }
      end
    end
  end
end
