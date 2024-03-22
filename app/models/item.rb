# frozen_string_literal: true

# A Collection Item
class Item < ApplicationRecord
  belongs_to :collection

  validates :name, presence: true

  ##
  # SETTERS (for jsonb properties on specific item types. e.g., comic books, movies, etc)
  #

  def set_comic_book_properties(issue, publisher)
    self.properties = {
      issue:,
      publisher:
    }
  end

  ##
  # GETTERS (for jsonb properties on specific item types)
  #

  def comic_book_issue
    properties['issue']
  end

  def comic_book_publisher
    properties['publisher']
  end
end
