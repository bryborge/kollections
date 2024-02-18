# frozen_string_literal: true

# A Collection Item
class Item < ApplicationRecord
  belongs_to :collection

  validates :name, presence: true
  validates :acquisition_date, presence: true
end
