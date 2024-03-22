# frozen_string_literal: true

# A Collection Item
class Item < ApplicationRecord
  belongs_to :collection
  has_many :properties, as: :propertiable, dependent: :destroy
  accepts_nested_attributes_for :properties, allow_destroy: true

  validates :name, presence: true
end
