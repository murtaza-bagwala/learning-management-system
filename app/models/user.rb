# frozen_string_literal: true

class User < ApplicationRecord
  has_many :authored_courses, class_name: 'Course', foreign_key: 'user_id'
  has_many :user_courses
  has_many :learnt_courses, through: :user_courses, source: :course

  validates :mobile_no, uniqueness: true, presence: true
  validates :name, format: { with: /\A[^0-9`!@#$%\^&*+_=]+\z/ }, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true

  def author?
    courses.present?
  end
end
