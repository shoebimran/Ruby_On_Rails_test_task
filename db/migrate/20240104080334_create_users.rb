# frozen_string_literal: true

# Creates the 'users' table in the database.
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, primary_key: [:uuid] do |t|
      t.string :uuid
      t.string :gender
      t.jsonb :name
      t.jsonb :location
      t.integer :age

      t.timestamps
    end
  end
end
