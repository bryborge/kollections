# frozen_string_literal: true

# User's Collections
class Collection < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
end
