# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User edits an item within a collection' do
  include_context 'when user signed in'

  let(:collection) { create(:collection, user:) }
  let(:item) { create(:item, collection:) }

  before { visit edit_collection_item_path(collection, item) }

  it 'with valid attributes' do
    fill_in 'Name', with: 'Preacher'
    fill_in 'Description', with: 'This is issue 1 of the comic book series "Preacher" by Garth Ennis.'
    check 'Collected'
    click_button 'Update'

    expect(page).to have_current_path(collection_item_path(collection, item))
    expect(page).to have_content('Item was successfully updated.')
  end

  it 'with invalid attributes' do
    fill_in 'Name', with: ''
    fill_in 'Description', with: 'This is issue 1 of the comic book series "Preacher" by Garth Ennis.'
    check 'Collected'
    click_button 'Update'

    expect(page).to have_current_path(collection_item_path(collection, item))
    expect(page).to have_content('Item was not updated.')
  end
end
