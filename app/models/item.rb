# frozen_string_literal: true

# Item
class Item < ApplicationRecord
  belongs_to :collection

  validates :name, presence: true
end
