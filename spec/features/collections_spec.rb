# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Collections' do
  let(:user) { create(:user) }
  let!(:collections) { create_list(:collection, 3, user:) }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  it 'User views the collections page' do
    visit collections_path

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
    # Update the path as per your routes
    expect(page).to have_current_path(new_collection_path)
  end
end
