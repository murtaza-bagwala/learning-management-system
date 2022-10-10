# frozen_string_literal: true

class User < ApplicationRecord
  has_many :authored_courses, class_name: 'Course', foreign_key: 'user_id'
  has_many :user_courses, dependent: :destroy
  has_many :learnt_courses, through: :user_courses, source: :course

  validates :mobile_no, uniqueness: true, presence: true, numericality: true,
                        length: { minimum: 10, maximum: 15 }, case_sensitive: false
  validates :name, uniqueness: true, format: { with: /\A[^0-9`!@#$%\^&*+_=]+\z/ }, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true

  before_destroy :transfer_courses_to_other_authors

  def author?
    authored_courses.present?
  end

  private

  def transfer_courses_to_other_authors
    if author?
      new_author = User.joins(:authored_courses).where("users.id != '#{id}'").first
      if new_author
        UserCourse.where(user_id: new_author.id, course_id: authored_courses.pluck(:id)).destroy_all
        authored_courses.each do |course|
          course.update!(user_id: new_author.id)
        end
      else
        Rails.logger.info('Unable to transfer courses to new author as no author found')
        raise ForbiddenPathError
      end
    end
  end
end
