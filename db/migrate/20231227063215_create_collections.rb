# frozen_string_literal: true

class CreateCollections < ActiveRecord::Migration[7.1]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.text :description
      t.string :kind,     null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
