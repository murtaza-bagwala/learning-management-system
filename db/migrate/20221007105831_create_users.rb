# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.date :dob
      t.string :mobile_no
      t.string :email
      t.string :university
      t.string :organization

      t.timestamps
    end
  end
end
