# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :title
      t.text :description
      t.datetime :published_at
      t.boolean :published
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
