# frozen_string_literal: true

FactoryBot.define do
  factory :collection do
    name { 'My Collection' }
    description { 'The description of my collection.' }
    user
  end
end
