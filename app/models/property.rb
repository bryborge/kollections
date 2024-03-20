# frozen_string_literal: true

# Item Property
class Property < ApplicationRecord
  belongs_to :propertiable, polymorphic: true

  validates :name, presence: true
end
