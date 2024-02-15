# frozen_string_literal: true

# User's Collections
class Collection < ApplicationRecord
  belongs_to :user
  has_many :collectibles, dependent: :destroy

  validates :name, presence: true
end
