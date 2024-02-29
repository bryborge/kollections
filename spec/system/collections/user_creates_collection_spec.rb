# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User creates collection' do
  include_context 'when user signed in'

  before { visit new_collection_path }

  it 'with valid attributes' do
    fill_in 'Name', with: 'Comic Books'
    fill_in 'Description', with: 'This is my entire comic book collection.'
    fill_in 'Kind', with: 'comics'
    click_button 'Create'

    collection = user.collections.last

    expect(page).to have_current_path(collection_path(collection))
    expect(page).to have_content('Collection was successfully created.')
  end

  it 'with invalid attributes' do
    fill_in 'Name', with: ''
    fill_in 'Description', with: 'This is my entire comic book collection.'
    fill_in 'Kind', with: ''
    click_button 'Create'

    expect(page).to have_current_path(collections_path)
    expect(page).to have_content('Collection was not created.')
  end
end
