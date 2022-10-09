# frozen_string_literal: true

class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons, id: :uuid do |t|
      t.string :title
      t.text :notes
      t.references :course, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
