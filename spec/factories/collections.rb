# frozen_string_literal: true

FactoryBot.define do
  factory :collection do
    user

    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end
