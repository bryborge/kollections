# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    collection

    name { 'My Item' }
    description { 'The description of my item.' }
    acquisition_date { Time.zone.today }
  end
end
