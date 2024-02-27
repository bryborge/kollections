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
    context 'when User has associated collections' do
      let!(:collections) { create_list(:collection, 3, user:) }

      before { visit collections_path }

      it "Displays the user's collections" do
        # Verify the header is present
        expect(page).to have_content('Your Collections')

        # Verify each collection is listed with a correct link
        collections.each do |collection|
          expect(page).to have_link('View', href: collection_path(collection))
        end

        # Verify the "Add +" button exists and can be clicked
        expect(page).to have_link('Add +', href: new_collection_path)
        click_link 'Add +'

        # Verify that clicking the "Add +" button takes the user to the new collection page
        expect(page).to have_current_path(new_collection_path)
      end
    end

    context 'when User does not have associated collections' do
      before { visit collections_path }

      it "Displays a 'no collections' message" do
        # Verify the header is present
        expect(page).to have_content('Your Collections')

        # Verify no collections message is present and no collections are displayed
        expect(page).to have_content("You don't have any collections.")
        expect(page).not_to have_css('.card h-100')

        # Verify the "Add +" button exists and can be clicked
        expect(page).to have_link('Add +', href: new_collection_path)
        click_link 'Add +'

        # Verify that clicking the "Add +" button takes the user to the new collection page
        expect(page).to have_current_path(new_collection_path)
      end
    end
  end
end
