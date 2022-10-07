# frozen_string_literal: true

class Course < ApplicationRecord
  # has_many :courses, foreign_key: :author_id
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many :user_courses
  has_many :talents, through: :user_courses, source: :talent

  validates :title, format: { with: /\A[^0-9`!@#$%\^&*+_=]+\z/ }, presence: true
end
