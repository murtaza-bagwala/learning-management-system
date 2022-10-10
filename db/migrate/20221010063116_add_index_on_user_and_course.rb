# frozen_string_literal: true

class AddIndexOnUserAndCourse < ActiveRecord::Migration[6.0]
  def change
    add_index :user_courses, %i[user_id course_id], unique: true
  end
end
