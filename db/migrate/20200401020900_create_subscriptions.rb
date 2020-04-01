# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions, id: false do |t|
      t.references :user
      t.references :program
    end
  end
end
