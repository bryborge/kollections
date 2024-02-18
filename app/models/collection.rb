# frozen_string_literal: true

# A User Collection
class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true
end
