# frozen_string_literal: true

# A User Collection
class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :kind, presence: true

  COLLECTION_PROPERTIES = {
    'comics' => %w[Issue Publisher],
    'movies' => %w[Director Studio],
    'music' => %w[Artist Album],
    'books' => %w[Author Publisher]
  }.freeze
end
