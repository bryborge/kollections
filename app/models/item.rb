# frozen_string_literal: true

# Collectable items
class Item < ApplicationRecord
  belongs_to :collection

  validates :name, presence: true
end
