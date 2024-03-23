# frozen_string_literal: true

# Properties on Items of a give Collection "kind".
module CollectionProperties
  def self.defaults_for(kind)
    {
      'comics' => {
        'issue' => nil,
        'publisher' => nil
      },
      'movies' => {
        'director' => nil
      }
    }[kind] || {}
  end
end
