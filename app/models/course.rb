# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many :user_courses
  has_many :talents, through: :user_courses, source: :talent
  has_many :courses
  has_many :lessons

  validates :title, uniqueness: true, presence: true
end
