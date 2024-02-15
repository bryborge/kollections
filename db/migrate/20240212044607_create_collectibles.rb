# frozen_string_literal: true

class CreateCollectibles < ActiveRecord::Migration[7.1]
  def change
    create_table :collectibles do |t|
      t.integer :collection_id
      t.string :name
      t.text :description
      t.string :condition
      t.date :acquisition_date

      t.timestamps
    end
  end
end
