# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User creates item within a collection' do
  include_context 'when user signed in'

  let(:collection) { create(:collection, user:) }

  before { visit new_collection_item_path(collection) }

  it 'with valid attributes' do
    fill_in 'Name', with: 'Preacher'
    fill_in 'Description', with: 'This is issue 1 of the comic book series "Preacher" by Garth Ennis.'
    fill_in 'Acquisition date', with: '2024-02-16'
    click_button 'Create'

    item = Item.last

    expect(page).to have_current_path(collection_item_path(collection, item))
    expect(page).to have_content('Item was successfully created.')
  end

  it 'with invalid attributes' do
    fill_in 'Name', with: ''
    fill_in 'Description', with: 'This is issue 1 of the comic book series "Preacher" by Garth Ennis.'
    fill_in 'Acquisition date', with: ''
    click_button 'Create'

    expect(page).to have_current_path(collection_items_path(collection))
    expect(page).to have_content('Item was not created.')
  end
end
