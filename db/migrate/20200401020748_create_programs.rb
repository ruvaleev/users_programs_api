# frozen_string_literal: true

class CreatePrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :programs do |t|
      t.string :title, unique: true, null: false
      t.text :description
      t.integer :users_count, default: 0
    end
  end
end
