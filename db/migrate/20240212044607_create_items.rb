# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.integer :collection_id
      t.string :name
      t.text :description
      t.date :acquisition_date

      t.timestamps
    end
  end
end
