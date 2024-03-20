# frozen_string_literal: true

class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name, null: false
      t.string :value, null: false
      t.references :propertiable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
