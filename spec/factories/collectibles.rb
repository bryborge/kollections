# frozen_string_literal: true

FactoryBot.define do
  factory :collectible do
    collection

    name { 'My Collectible' }
    description { 'The description of my collectible.' }
    condition { 'New' }
    acquisition_date { Time.zone.today }
  end
end
