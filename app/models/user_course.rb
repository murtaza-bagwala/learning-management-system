# frozen_string_literal: true

class UserCourse < ApplicationRecord
  belongs_to :talent, class_name: 'User', foreign_key: 'user_id'
  belongs_to :course

  before_save :course_not_created_by_user!

  private

  def course_not_created_by_user!
    if course.author.id == talent.id
      Rails.logger.info('Author cannot join his own course')
      raise ForbiddenPathError
    end
  end
end
