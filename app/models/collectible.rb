# frozen_string_literal: true

# Collectible
class Collectible < ApplicationRecord
  belongs_to :collection

  validates :name, presence: true
end
