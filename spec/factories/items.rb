# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    collection

    name { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    collected { true }
  end
end
