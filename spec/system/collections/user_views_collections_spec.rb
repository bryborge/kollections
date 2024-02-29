# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User views all of their collections' do
  include_context 'when user signed in'

  it 'navigates to new collection page' do
    click_link 'Add +'
    expect(page).to have_current_path(new_collection_path)
  end

  context 'when user does not have any collections' do
    before { visit collections_path }

    it 'does not display any collections' do
      # Verify no collections message is present and no collections are displayed
      expect(page).to have_content("You don't have any collections.")
      expect(page).not_to have_css('.card.h-100')
    end
  end

  context 'when user has collections' do
    let!(:collections) { create_list(:collection, 3, user:) }

    before do
      # generate a random number of items per collection
      collections.each do |collection|
        create_list(:item, rand(0..3), collection:)
      end

      visit collections_path
    end

    it 'displays the collections' do
      expect(page).to have_css('.card.h-100')

      # Verify each collection is listed with a correct link
      collections.each do |collection|
        expect(page).to have_link('View', href: collection_path(collection))
      end
    end

    it 'displays the number of items in each collection' do
      collections.each do |collection|
        expected_item_count = collection.items.count
        item_count_element  = find(".collection[data-collection-id='#{collection.id}']")

        expect(item_count_element.text).to eq(expected_item_count.to_s)
      end
    end
  end
end
