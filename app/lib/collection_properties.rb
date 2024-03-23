# frozen_string_literal: true

# Collection Properties ...
module CollectionProperties
  # ... on Items of a give Collection "kind".
  def self.defaults_for(kind)
    {
      'comics' => {
        'issue' => nil,
        'publisher' => nil
      },
      'movies' => {
        'director' => nil
      },
      'music' => {
        'artist' => nil
      },
      'books' => {
        'author' => nil
      }
    }[kind] || {}
  end
end
