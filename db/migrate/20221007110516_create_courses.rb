class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :title
      t.text :description
      t.datetime :published_at
      t.boolean :published
      t.reference :user

      t.timestamps
    end
  end
end
