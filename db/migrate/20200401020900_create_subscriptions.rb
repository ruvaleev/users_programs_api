# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :program
      t.boolean :active, default: true
    end
  end
end
