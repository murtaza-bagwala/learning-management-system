# frozen_string_literal: true

class UserCourse < ApplicationRecord
  belongs_to :talent, class_name: 'User', foreign_key: 'user_id'
  belongs_to :course
end
