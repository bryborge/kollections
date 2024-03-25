# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :collection, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.boolean :collected, null: false, default: false
      t.jsonb :properties, null: false, default: {}

      t.timestamps
    end
  end
end
