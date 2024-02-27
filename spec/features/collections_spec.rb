# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Collections' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  describe 'User views their collections index page' do
    it 'shows the header' do
      expect(page).to have_content('Your Collections')
    end

    it 'has a button to add a collection' do
      expect(page).to have_link('Add +', href: new_collection_path)
      click_link 'Add +'

      expect(page).to have_current_path(new_collection_path)
    end

    context 'when User does not have associated collections' do
      before { visit collections_path }

      it 'does not display any collections' do
        # Verify no collections message is present and no collections are displayed
        expect(page).to have_content("You don't have any collections.")
        expect(page).not_to have_css('.card.h-100')
      end
    end

    context 'when User has associated collections' do
      let!(:collections) { create_list(:collection, 3, user:) }

      before do
        # generate a random number of items per collection
        collections.each do |collection|
          create_list(:item, rand(0..3), collection:)
        end

        visit collections_path
      end

      it "displays the user's collections" do
        expect(page).to have_css('.card.h-100')

        # Verify each collection is listed with a correct link
        collections.each do |collection|
          expect(page).to have_link('View', href: collection_path(collection))
        end
      end

      it 'displays the number of items for each collection' do
        collections.each do |collection|
          expected_item_count = collection.items.count
          item_count_element  = find(".collection[data-collection-id='#{collection.id}']")

          expect(item_count_element.text).to eq(expected_item_count.to_s)
        end
      end
    end
  end
end
